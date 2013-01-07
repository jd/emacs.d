(require 'org-depend)
(setq org-directory "~/Org")
(setq org-hide-leading-stars t)
(setq org-src-fontify-natively t)
(setq org-startup-indented t)
(setq org-completion-use-iswitchb t)
(setq org-log-done t)
(setq org-email-link-description-format "Email %c (%d): %s")
(setq org-link-frame-setup
      '((gnus . org-gnus-no-new-news)
	(file . find-file)))
(setq org-todo-keywords
      '((sequence "TODO(t!)"
                  "STARTED(s!)"
                  "DELEGATED(g@)"
                  "BLOCKED(b@)"
                  "FEEDBACK(f!/@)"
                  "REWORK(r!/!)"
                  "VERIFY(v/!)"
                  "|"
                  "DONE(d!)"
                  "CANCELED(c@)")
        (sequence "PROJECT(j!)" "|" "CANCELED(c@)" "DONE(d!)")))
(setq org-enforce-todo-dependencies t)
(setq org-link-abbrev-alist
      '(("colissimo" . "http://www.coliposte.net/particulier/suivi_particulier.jsp?colispart=")
        ("launchpad" . "https://bugs.launchpad.net/bugs/")))

(add-hook 'org-mode-hook 'turn-on-auto-fill)
(add-hook 'org-mode-hook
          (lambda ()
            (add-hook
             (make-local-variable 'after-save-hook)
             (lambda ()
               (when (string-prefix-p (expand-file-name org-directory) buffer-file-name)
                 (call-process-shell-command
                  (format
                   "git commit -m \"Org auto-commit\" -s %s && git push &"
                   buffer-file-name)
                  nil 0))))))

(require 'org-crypt)
(defun jd:org-decrypt-entires-silently ()
  (let ((m (buffer-modified-p)))
    (org-decrypt-entries)
    (unless m
      (set-buffer-modified-p nil))))
(add-hook 'org-mode-hook 'jd:org-decrypt-entires-silently)
(add-hook 'org-mode-hook (defun jd:org-decrypt-after-save ()
                           (add-hook (make-local-variable 'after-save-hook)
                                     'jd:org-decrypt-entires-silently)))

(setq org-clock-persist-query-save t)
(setq org-show-notification-handler
      (defun jd:org-show-notification-handler (notification)
        (require 'notifications)
        (notifications-notify
         :title notification)))
