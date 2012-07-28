(setq display-time-24hr-format t)
(setq display-time-mail-function
      (lambda ()
        ;; Gnus launched?
        (when (boundp 'gnus-newsrc-alist)
          (dolist (entry gnus-newsrc-alist)
            (let ((group (car entry)))
              (when (< (gnus-group-level group) 2)
                (let ((unread (gnus-group-unread group)))
                  (when (and (numberp unread)
                             (> unread 0))
                    (return group)))))))))
(setq display-time-format "")
(setq display-time-default-load-average nil) ; no load average displayed
(setq display-time-use-mail-icon t)
(setq display-time-mail-icon
      '(image :type png :file "~/.emacs.d/icons/email.png" :ascent center))
;; Refresh after settings are loaded
(display-time)
