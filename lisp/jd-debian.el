(defconst jd:debian-doc-directory "/usr/share/doc")

;;;###autoload
(defun jd:debian-view-changelog (package)
  (interactive
   (list (completing-read "Package: "
                          (remove-if
                           (lambda (dir)
                             (string-match "^\\." dir))
                           (directory-files jd:debian-doc-directory))
                          nil t)))
  (view-file
   (concat jd:debian-doc-directory "/" package "/changelog.Debian.gz")))


(defconst jd:debian-changelog-url "http://changelog.debian.net")

;;;###autoload
(defun jd:debian-view-online-changelog (package)
  (interactive (list (read-string "Package: ")))
  (let* ((url-request-extra-headers '(("Accepts" . "text/plain")))
         (buffer (url-retrieve-synchronously
                  (concat jd:debian-changelog-url "/" package)))
         (content (with-current-buffer buffer
                    (goto-char (point-min))
                    (when (search-forward-regexp "^HTTP/.+ 404" (line-end-position) t)
                      (kill-buffer)
                      (error (format "Unknown package %s" package)))
                    (search-forward "\n\n" nil t)
                    (buffer-substring-no-properties (point) (point-max))))
         (changelog (get-buffer-create (concat package " Debian changelog"))))
    (with-current-buffer changelog
      (insert content)
      (goto-char (point-min))
      (debian-changelog-mode))
    (switch-to-buffer changelog)
    (kill-buffer buffer)))

(provide 'jd-debian)
