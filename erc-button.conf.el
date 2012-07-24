(require 'jd-buttonize)

(dolist (button jd:button-alist)
  (add-to-list 'erc-button-alist
               (apply (lambda (context-regexp regexp button callback par)
                        `(,regexp
                          ,button
                          (string-match-p ,context-regexp (car erc-default-recipients))
                          ,callback
                          ,par))
                      button)))
