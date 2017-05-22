(require 'jd-buttonize)

(add-to-list 'gnus-buttonized-mime-types "multipart/signed")

(dolist (button jd:button-alist)
  (add-to-list 'gnus-header-button-alist
               (apply (lambda (context-regexp regexp button callback par)
                        `("Subject:"
                          ,regexp
                          ,button
                          (string-match-p ,context-regexp gnus-newsgroup-name)
                          ,callback
                          ,par))
                      button))
  (add-to-list 'gnus-button-alist
               (apply (lambda (context-regexp regexp button callback par)
                        `(,regexp
                          ,button
                          (string-match-p ,context-regexp gnus-newsgroup-name)
                          ,callback
                          ,par))
                      button)))

(defun jd:gnus-article-browse-review-or-bug ()
  (interactive)
  (gnus-with-article-buffer
    (save-excursion
      (article-goto-body)
      (when (re-search-forward
             "^\\(?:To view, visit \\)?\\(https://review.openstack.org/[0-9]+\\|https://bugs.launchpad.net/bugs/[0-9]+\\|https://bugzilla.redhat.com/show_bug.cgi\\?id=[0-9]+\\|https://github.com/.+/.+/issues/[0-9]+\\|https://travis-ci.org/.+/.+/builds/.+\\)" nil t)
        (browse-url (match-string-no-properties 1))))))

(define-key gnus-summary-mode-map "\\" 'jd:gnus-article-browse-review-or-bug)
(define-key gnus-article-mode-map "\\" 'jd:gnus-article-browse-review-or-bug)

(setq gnus-article-browse-delete-temp t)

(define-key gnus-article-mode-map (kbd "C-c C-\\")
  (defun jd:gnus-mime-pipe-gcalcli ()
    (interactive)
    (gnus-mime-pipe-part "/usr/local/bin/gcalcli  --calendar jdanjou@redhat.com import")))

(setq gnus-visible-headers
      (concat gnus-visible-headers "\\|^User-Agent:\\|^X-Mailer:"))
