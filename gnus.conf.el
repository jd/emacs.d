(require 'jd-email)
;; Move spam into spam
(require 'spam)

;; gnus
(setq gnus-select-method
      '(nnimap "Danjou"
               (nnimap-stream shell)
               (nnimap-shell-program
                "/usr/local/opt/dovecot/libexec/dovecot/imap -o mail_location=maildir:~/Mail/Danjou")))

(setq gnus-novice-user nil)             ; I AM NOT!
(setq gnus-spam-process-destinations
      '(("." "Spam")))
(setq gnus-agent nil)                   ; No agent
(setq gnus-summary-line-format
      (concat "%z%U%R %~(max-right 17)~(pad-right 17)&user-date;  "
              "%~(max-right 20)~(pad-right 20)f %B%s\n"))
;; TODO this is needed because the group passed to
;; `gnus-message-archive-group' is not fully qualified, which sucks, and I
;; should fix it sometime
(setq gnus-message-archive-group (lambda (group)
                                   (concat
                                    (if (string-match-p "^nn.+:" group)
                                        ""
                                      "nnimap+Danjou:")
                                    (if (string= group "") "INBOX" group))))
;; Expire
(setq gnus-total-expirable-newsgroups
      (concat "^\\("
              (mapconcat 'identity
                         '("Lists\\."
                           "Spam$"
                           "INBOX\\.Naquadah\\.adm$")
                         "\\|")
              "\\)"))

(setq nnmail-expiry-wait-function
      (lambda (newsgroup)
        (if (string-match-p (concat "^\\("
                                    (mapconcat 'identity
                                               '("Lists\\."
                                                 "Spam$"
                                                 "INBOX\\.Naquadah\\.adm$")
                                               "\\|")
                                    "\\)")
                            newsgroup)
            120
          'immediate)))

;; Old this parameters are searched through using `gnus-group-find-parameter'
;; and each item in the list that matches the regexp overrides the previous
;; value.
;; Check with e.g. (gnus-group-find-parameter "INBOX" 'expiry-target)
(setq gnus-parameters
      '(("."
         (expiry-target . "Trash"))
        ("^Lists\\.Gnus\\.ding"
         (to-list . "ding@gnus.org"))
        ("^Lists\\.Debian\\.\\(.+\\)"
         (to-list . "debian-\\1@lists.debian.org"))
        ("^Lists\\.OpenStack\\.review"
         (highlight-words .  (("\\bFAILURE\\b" 0 0 error)
                              ("\\bSUCCESS\\b" 0 0 success)
                              ("\\bSKIPPED\\b" 0 0 warning)
                              ("\\bLOST\\b" 0 0 warning)
                              ("\\bUNSTABLE\\b" 0 0 warning)
                              ("\\bAbandoned\\b" 0 0 error)
                              ("Patch Set [[:digit:]]" 0 0 bold)
                              ("([[:digit:]]+ inline comment)" 0 0 warning)
                              ("Looks good to me (core reviewer)" 0 0 success)
                              ("Looks good to me, but someone else must approve" 0 0 success)
                              ("Doesn't seem to work" 0 0 error)
                              ("Do not merge" 0 0 error)
                              ("I would prefer that you didn't merge this" 0 0 error)
                              ("Works for me" 0 0 success)
                              ("\\bVerified\\+2\\b" 0 0 success)
                              ("\\bVerified\\+1\\b" 0 0 success)
                              ("\\bVerified-1\\b" 0 0 error)
                              ("\\bWorkflow\\+1\\b" 0 0 success)
                              ("\\bWorkflow-1\\b" 0 0 error)
                              ("\\bCode-Review\\+2\\b" 0 0 success)
                              ("\\bCode-Review\\+1\\b" 0 0 success)
                              ("\\bCode-Review-1\\b" 0 0 error)
                              ("\\bCode-Review-2\\b" 0 0 error)
                              ("^.+ has uploaded a new change for review." 0 0 bold)
                              ("Jenkins has submitted this change and it was merged." 0 0 success))))
        ("^Lists\\.Travis-CI"
         (highlight-words .  (("\\bFailed\\b" 0 0 error)
                              ("\\bErrored\\b" 0 0 error)
                              ("\\bBroken\\b" 0 0 error)
                              ("\\bFixed\\b" 0 0 success)
                              ("\\bPassed\\b" 0 0 success))))
        ("^Lists\\.GitHub"
         (highlight-words .  (("\\bFAILED\\b" 0 0 error)
                              ("\\bERRORED\\b" 0 0 error)
                              ("\\bPASSED\\b" 0 0 success))))
        ("^Lists\\.OpenStack\\.\\(.+\\)"
         (to-list . "\\1@lists.openstack.org")
         (list-identifier . "\\\\[\\1\\\\]")
         (banner . "_______________________________________________+
.+
.+
http://lists.openstack.org/cgi-bin/mailman/listinfo/\\1"))
        ("^Lists\\.OpenStack-fr\\.\\(.+\\)"
         (to-list . "\\1@listes.openstack.fr"))))

;; gnus-start
(setq gnus-subscribe-newsgroup-method 'gnus-subscribe-alphabetically)
;; Do not save .newsrc, we do not use a newsreader
(setq gnus-save-newsrc-file nil)
(setq gnus-read-newsrc-file nil)
(setq gnus-always-read-dribble-file t)
;; Check every 5 minutes when emacs is idle when Gnus is started
(add-hook 'gnus-startup-hook
          (defun jd:gnus-check-for-new-mail ()
            (gnus-demon-add-handler 'gnus-group-get-new-news 5 t)))
(add-hook 'gnus-after-getting-new-news-hook 'gnus-notifications)
(add-hook 'gnus-after-getting-new-news-hook 'gnus-group-find-new-groups)
(add-hook 'gnus-after-getting-new-news-hook
          (defun jd:gnus-sort-groups-after-new-news ()
            (gnus-group-sort-groups gnus-group-sort-function)))

(defvar *mbsync-process* nil)

(add-hook 'gnus-get-new-news-hook
          (defun jd:run-mbsync ()
            (unless (process-live-p *mbsync-process*)
              (setq *mbsync-process* (start-process "mbsync"
                                                    (with-current-buffer
                                                        (get-buffer-create "*mbsync*")
                                                      (buffer-disable-undo)
                                                      (erase-buffer)
                                                      (current-buffer))
                                                    "nice"
                                                    (executable-find "mbsync")
                                                    "-a"
                                                    "-V")))))

;; gnus-group
;; Redefine this to nil because I pressed it by mistake too many times
(define-key gnus-group-mode-map (kbd "M-c") nil)
(setq gnus-group-default-list-level (- gnus-level-subscribed 1))
(setq gnus-group-sort-function '(gnus-group-sort-by-alphabet
                                 gnus-group-sort-by-level))

(defun jd:gnus-image-or-space (string image image-p)
  (let ((image (create-image image)))
    (if (display-images-p)
        (if image-p
            (propertize string 'display
                        (append image
                                '(:ascent center)))
          (propertize " " 'display `(space . (:width ,(car (image-size image))))))
      (if image-p
          string
        " "))))

(defun gnus-user-format-function-e (dummy)
  (char-to-string gnus-unread-mark))

(defun gnus-user-format-function-M (dummy)
  (char-to-string gnus-ticked-mark))

(setq gnus-group-line-format "%ue%uM %S%p[%5t][%L]\t%P%5y:%B%(%g%)%O\n")

;; gnus-sum
(setq gnus-summary-thread-gathering-function 'gnus-gather-threads-by-references)
(setq gnus-ignored-from-addresses jd:email-addresses-regexp)
(setq gnus-thread-sort-functions '(gnus-thread-sort-by-number
                                   gnus-thread-sort-by-subject
                                   gnus-thread-sort-by-date
                                   gnus-thread-sort-by-total-score))
(setq gnus-auto-select-subject 'unread) ; Select unread article on group entering
(setq gnus-summary-stop-at-end-of-message t)
(setq gnus-summary-to-prefix "→"
      gnus-summary-newsgroup-prefix "⇶"
      ;; Marks
      gnus-ticked-mark ?🚩
      gnus-dormant-mark ?⚐
      gnus-expirable-mark ?♻
      gnus-read-mark ?✓
      gnus-del-mark ?✗
      gnus-killed-mark ?☠
      gnus-replied-mark ?↺
      gnus-forwarded-mark ?↪
      gnus-cached-mark ?☍
      gnus-recent-mark ?✩
      gnus-unseen-mark ?★
      gnus-unread-mark ?✉
      gnus-score-over-mark ?↑           ; ↑ ☀
      gnus-score-below-mark ?↓         ; ↓ ☂
      gnus-sum-thread-tree-false-root " ◌ "
      gnus-sum-thread-tree-single-indent "◎ "
      gnus-sum-thread-tree-indent "   "
      gnus-sum-thread-tree-root "● "
      gnus-sum-thread-tree-leaf-with-other "├─▶ "
      gnus-sum-thread-tree-single-leaf     "└─▶ " ; "╰─►"
      gnus-sum-thread-tree-vertical        "│ ")

;; gnus-msg
(setq gnus-posting-styles
      '((".*"
         (name "Julien Danjou")
         (address "julien@danjou.info"))
        ("debian"
         (address "acid@debian.org")
         (organization "Debian"))
        ("mergify"
         (address "jd@mergify.io")
         (signature "Julien Danjou")
         (organization "Mergify.io"))
        ("mergify\.support"
         (address "jd@mergify.io")
         (reply-to "support@mergify.io")
         (Cc "support@mergify.io")
         (organization "Mergify.io"))))

(setq gnus-gcc-mark-as-read t)
;; Automatically sign when sending mails
;; (add-hook 'gnus-message-setup-hook 'mml-secure-message-sign-pgpmime)
;; This is used when "posting"...
(setq gnus-mailing-list-groups "Lists")

;; gnus-async
(setq gnus-use-header-prefetch t)       ; prefetch header for next group

;; gnus-art
(add-to-list 'gnus-emphasis-alist
             '("\\b@jd\\|Julien\\|Danjou\\|jd\\b" 0 0 warning))
(add-to-list 'gnus-emphasis-alist
             `(,(concat "\\b"
                        (mapconcat 'identity '("ceilometer" "aodh" "gnocchi" "panko" "metmon") "\\|")
                        "\\b")
               0 0 highlight))
(setq gnus-sorted-header-list
      '("^From:" "^To:" "^Newsgroups:" "^Cc:" "^Subject:" "^Summary:" "^Keywords:" "^Followup-To:" "^Date:" "^Organization:"))
(setq gnus-face-properties-alist
      '((pbm . (:face gnus-x-face :ascent center))
        (png . (:ascent center))))
(setq gnus-treat-from-picon nil)
(setq gnus-treat-newsgroups-picon nil)
(setq gnus-treat-mail-picon nil)
(setq gnus-treat-from-gravatar 'head)
(setq gnus-treat-mail-gravatar 'head)
(setq gnus-treat-body-boundary nil)    ; No body/header separator
(setq gnus-blocked-images nil)          ; HTML rendering
(setq gnus-large-newsgroup 1000)

;; gnus-gravatar
(setq gnus-gravatar-properties '(:ascent center))
(setq gnus-gravatar-too-ugly jd:email-addresses-regexp)

;; nnheader
(setq gnus-nov-is-evil t)               ; No NOV

;; gnus-score
(setq gnus-home-score-file "~/.gnus.score")

;; gnus-win
(gnus-add-configuration
 ;; two panes side-by-side
 '(article (horizontal 1.0
                       (summary .55 point)
                       (article 1.0))))
(gnus-add-configuration
 ;; two panes side-by-side
 '(summary (horizontal 1.0
                       (summary 1.0 point))))
;; Vertical display when replying
(gnus-add-configuration '(reply (vertical 1.0
                                          (horizontal 1.0
                                                      (message .5 point)
                                                      (article 1.0))
                                          (summary .2))))
(gnus-add-configuration '(reply-yank (vertical 1.0
                                               (horizontal 1.0
                                                           (message .5 point)
                                                           (article 1.0))
                                               (summary .2))))
(gnus-add-configuration '(forward (vertical 1.0
                                            (horizontal 1.0
                                                        (message .5 point)
                                                        (article 1.0))
                                            (summary .2))))
