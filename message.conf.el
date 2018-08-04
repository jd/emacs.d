(require 'jd-email)

;; When I reply, I don't want to have me in To or Cc
(setq message-dont-reply-to-names (concat "\\("
                                          jd:email-addresses-regexp
                                          "\\|"
                                          ;; Nor the Debian BTS
                                          "^submit@bugs.debian\\.org$"
                                          "\\)"))
(setq message-confirm-send t)
(add-hook 'message-send-hook
          (defun jd:check-redhat-from-redhat ()
            (unless (string-match-p "redhat.com" (message-field-value "From"))
              (when (or (string-match-p "redhat.com" (or (message-field-value "To") ""))
                        (string-match-p "redhat.com" (or (message-field-value "Cc") "")))
                ;; I could use `y-or-n-p' but since `message-confirm-send' is
                ;; enabled, I'm too much used of pressing `y' after C-c C-c.
                (unless (string= "ok" (read-from-minibuffer "Send message to redhat.com addresses with non redhat.com From? [ok] "))
                  (keyboard-quit))))))

;; Kill buffer when message is sent
(setq message-kill-buffer-on-exit t)
(setq message-elide-ellipsis "\n[…]\n\n")
(setq message-citation-line-function 'message-insert-formatted-citation-line)
(add-hook 'message-mode-hook 'footnote-mode)
(add-hook 'message-mode-hook 'turn-on-flyspell)
(setq message-subscribed-address-functions '(gnus-find-subscribed-addresses))

(defvar jd:message-signatures
  '("/* Free Software hacker
   https://julien.danjou.info */"
    "# Free Software hacker
# https://julien.danjou.info"
        "// Free Software hacker
// https://julien.danjou.info"
        ";; Free Software hacker
;; https://julien.danjou.info"
        "-- Free Software hacker
-- https://julien.danjou.info")
  "Random signatures to pick.")

(setq message-signature '(concat "Julien Danjou\n" (nth (random (length jd:message-signatures)) jd:message-signatures)))

;; `message-send-mail-function' can be called before any of this is set, so we
;; should set it right now and not using `eval-after-load'.
(setq smtpmail-smtp-server "smtp.fastmail.com")
(setq smtpmail-stream-type 'starttls)
(setq smtpmail-smtp-service "submission")

(setq message-send-mail-function
      (defun jd:message-smtpmail-send-it ()
        (if (string-match-p "redhat.com" (message-field-value "From"))
            (let ((smtpmail-smtp-server "smtp.corp.redhat.com"))
              (message-smtpmail-send-it))
          (message-smtpmail-send-it))))
