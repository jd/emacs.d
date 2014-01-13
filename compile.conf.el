(require 'notifications)
(setq compilation-scroll-output 'first-error)
(add-to-list 'compilation-finish-functions
             (defun jd:compilation-finish-function (buf end)
               (notifications-notify :title "Compilation finished"
                                     :body end)))
