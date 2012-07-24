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
