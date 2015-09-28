(require 'jd-email)

;; When I reply, I don't want to have me in To or Cc
(setq message-dont-reply-to-names (concat "\\("
                                          jd:email-addresses-regexp
                                          "\\|"
                                          ;; Nor the Debian BTS
                                          "^submit@bugs.debian\\.org$"
                                          "\\)"))
(setq message-confirm-send t)
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

(setq message-send-mail-function
      (defun jd:message-smtpmail-send-it ()
        (if (string-match-p "redhat.com" (message-field-value "From"))
            (let ((smtpmail-smtp-server "smtp.corp.redhat.com"))
              (message-smtpmail-send-it))
          (message-smtpmail-send-it))))
