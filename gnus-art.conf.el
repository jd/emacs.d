(require 'jd-buttonize)

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
    (article-goto-body)
    (while (re-search-forward
            (concat "^\\(To view, visit \\)?\\(https://review.openstack.org/[0-9]+\\|https://bugs.launchpad.net/bugs/[0-9]+\\)") nil t)
      (browse-url (match-string-no-properties 2)))))

(define-key gnus-summary-mode-map "\\" 'jd:gnus-article-browse-review-or-bug)
(define-key gnus-article-mode-map "\\" 'jd:gnus-article-browse-review-or-bug)

(setq gnus-article-browse-delete-temp t)
