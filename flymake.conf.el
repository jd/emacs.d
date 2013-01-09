(defun flymake-pyflakes-init ()
  (let* ((temp-file (flymake-init-create-temp-buffer-copy
                     'flymake-create-temp-inplace))
         (local-file (file-relative-name
                      temp-file
                      (file-name-directory buffer-file-name))))
    `("python-flymake" (,local-file))))

(add-to-list 'flymake-allowed-file-name-masks
             '("\\.py\\'" flymake-pyflakes-init))

(defvar jd:flymake-display-error-message-timer
  (run-with-idle-timer 1 t 'jd:flymake-display-err-for-current-line))

(defun jd:flymake-display-err-for-current-line ()
  "Display a message with errors/warnings for current line if it has errors and/or warnings."
  (interactive)
  (let* ((line-no             (flymake-current-line-no))
	 (line-err-info-list  (nth 0 (flymake-find-err-info flymake-err-info line-no)))
	 (menu-data           (flymake-make-err-menu-data line-no line-err-info-list)))
    (when menu-data
      (message (mapconcat
                (lambda (err) (mapconcat 'identity (remove-if 'null err) " + "))
                (cadr menu-data)
                " + ")))))
