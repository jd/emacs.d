(require 'notifications)
(setq compilation-auto-jump-to-first-error t)
(setq compilation-scroll-output 'first-error)
(setq compilation-finish-function
      (defun jd:compilation-finish-function (buf end)
        (notifications-notify :title "Compilation finished"
                              :body end)))
