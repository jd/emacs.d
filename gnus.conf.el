(require 'jd-email)
;; Move spam into spam
(require 'spam)

;; gnus
(setq gnus-select-method '(nnimap "Naquadah"
                                  (nnimap-address "mail.naquadah.org")
                                  (nnimap-stream ssl)))

(setq gnus-novice-user nil)             ; I AM NOT!
(setq gnus-spam-process-destinations
      '(("." "spam")))
(setq gnus-agent nil)                   ; No agent
(setq gnus-summary-line-format
      (concat "%z%U%R %~(max-right 17)~(pad-right 17)&user-date;  "
              "%~(max-right 20)~(pad-right 20)f %B%s\n"))
(setq gnus-message-archive-group 'identity)
(setq gnus-message-archive-method "")
;; Expire
(setq gnus-total-expirable-newsgroups
      (concat "^\\("
              (mapconcat 'identity
                         '("lists\\."
                           "spam$"
                           "INBOX\\.naquadah\\.adm$")
                         "\\|")
              "\\)"))

(setq gnus-parameters
      '(("^lists\\."
         (subscribed . t))
        ("^lists\\.ding"
         (to-list . "ding@gnus.org"))
        ("^lists\\.awesome\\(-devel\\)?"
         (to-list . "awesome\\1@naquadah.org"))
        ("^lists\\.launchpad\\.\\(.+\\)"
         (to-list . "\\1@lists.launchpad.net")
         (list-identifier . "\\\\[\\1\\\\]")
         (banner . "_______________________________________________
Mailing list: https://launchpad.net/~\\1
Post to     : \\1@lists.launchpad.net
Unsubscribe : https://launchpad.net/~\\1
More help   : https://help.launchpad.net/ListHelp"))
        ("^lists\\.debian\\.\\(.+\\)"
         (to-list . "debian-\\1@lists.debian.org"))
        ("^lists\\.freedesktop\\.\\(.+\\)"
         (list-identifier . "\\\\[\\1\\\\]")
         (banner
          .
          "_______________________________________________
\\1 mailing list
\\1@lists.freedesktop.org
http://lists.freedesktop.org/mailman/listinfo/\\1"))
        ("^lists\\.ornix\\.\\(.+\\)"
         (to-list . "\\1@ornix.org"))
        ("^lists\\.\\(muse-el-.*\\)"
         (to-list . "\\1@gna.org"))
        ("^lists\\.camlistore"
         (to-list . "camlistore@googlegroups.com"))
        ("^lists\\.gnu\\.\\(.+\\)"
         (to-list . "\\1@gnu.org"))
        ("^lists\\.el-get-devel"
         (to-list . "el-get-devel@tapoueh.org"))
        ("^lists\\.debconf\\.\\(.+\\)"
         (list-identifier . "\\\\[\\1\\\\]")
         (banner . "_______________________________________________
\\1 mailing list
\\1@lists.debconf.org
http://lists.debconf.org/mailman/listinfo/\\1"))
        ("^lists\\.openstack\\.review"
         (highlight-words .  ((" : \\(FAILURE\\)" 1 1 error)
                              (" : \\(SUCCESS\\)" 1 1 success)
                              (" : \\(SKIPPED\\)" 1 1 warning)
                              ("Patch Set [[:digit:]]+: Looks good to me (core reviewer); Approved" 0 0 success)
                              ("Patch Set [[:digit:]]+: Looks good to me (core reviewer)" 0 0 success)
                              ("Patch Set [[:digit:]]+: Looks good to me, but someone else must approve" 0 0 success)
                              ("Patch Set [[:digit:]]+: Doesn't seem to work" 0 0 error)
                              ("Patch Set [[:digit:]]+: Do not merge" 0 0 error)
                              ("Patch Set [[:digit:]]: I would prefer that you didn't merge this" 0 0 error)
                              ("Patch Set [[:digit:]]+: Works for me" 0 0 success)
                              ("Patch Set [[:digit:]]+: Verified" 0 0 success)
                              ("Patch Set [[:digit:]]+: Approved" 0 0 success)
                              ("^.+ has uploaded a new change for review." 0 0 bold)
                              ("Jenkins has submitted this change and it was merged." 0 0 success))))
        ("^lists\\.openstack\\.\\(.+\\)"
         (to-list . "\\1@lists.openstack.org")
         (list-identifier . "\\\\[\\1\\\\]")
         (banner . "_______________________________________________
\\1 mailing list
\\1@lists.openstack.org
http://lists.openstack.org/cgi-bin/mailman/listinfo/\\1"))
        ("^lists\\.debian\\.alioth\\.\\(.+\\)"
         (to-list . "\\1@lists.alioth.debian.org")
         (list-identifier . "\\\\[\\1\\\\]")
         (banner . "_______________________________________________
\\1 mailing list
\\1@lists.alioth.debian.org
http://lists.alioth.debian.org/mailman/listinfo/\\1"))))

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
  (jd:gnus-image-or-space (char-to-string gnus-unread-mark) "~/.emacs.d/icons/email.png"
                          (> (string-to-number gnus-tmp-number-of-unread) 0)))

(defun gnus-user-format-function-M (dummy)
  (jd:gnus-image-or-space (char-to-string gnus-ticked-mark) "~/.emacs.d/icons/important.png"
                          (cdr (assq 'tick gnus-tmp-marked))))

(setq gnus-group-line-format "%ue%uM %S%p[%5t][%L]\t%P%5y:%B%(%g%)%O\n")

;; gnus-sum
(setq gnus-summary-thread-gathering-function 'gnus-gather-threads-by-references)
(setq gnus-ignored-from-addresses jd:email-addresses-regexp)
(setq gnus-thread-sort-functions '(gnus-thread-sort-by-number
                                   gnus-thread-sort-by-subject
                                   gnus-thread-sort-by-date))
(setq gnus-auto-select-subject 'unread) ; Select unread article on group entering
(setq gnus-summary-stop-at-end-of-message t)
(setq gnus-summary-to-prefix "→"
      gnus-summary-newsgroup-prefix "⇶"
      ;; Marks
      gnus-ticked-mark ?⚑
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
        ("lists\\.debian\\.france"
         (address "julien@danjou.info"))
        ("INBOX\\.nous"
         (reply-to "nous@danjou.info"))))
(setq gnus-gcc-mark-as-read t)
;; Automatically sign when sending mails
(add-hook 'gnus-message-setup-hook 'mml-secure-message-sign-pgpmime)
;; This is used when "posting"...
(setq gnus-mailing-list-groups "lists")

;; gnus-async
(setq gnus-use-header-prefetch t)       ; prefetch header for next group

;; gnus-art
(add-to-list 'gnus-emphasis-alist
             '("\\b@jd\\|Julien\\|Danjou\\|jd\\b" 0 0 warning))
(setq gnus-visible-headers
      (concat gnus-visible-headers "\\|^User-Agent:\\|^X-Mailer:"))
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
(add-to-list 'gnus-buttonized-mime-types "multipart/signed")
(setq gnus-blocked-images nil)          ; HTML rendering

;; gnus-gravatar
(setq gnus-gravatar-properties '(:ascent center))
(setq gnus-gravatar-too-ugly jd:email-addresses-regexp)

;; nnheader
(setq gnus-nov-is-evil t)               ; No NOV

;; nnmail
(setq nnmail-expiry-wait 60)

;; gnus-score
(setq gnus-home-score-file "~/.gnus.score")

;; gnus-win
(gnus-add-configuration
 ;; two panes side-by-side
 '(article (horizontal 1.0
                       (summary .5 point)
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

;; No cursor
(defun jd:no-cursor ()
  (setq cursor-type nil))
(add-hook 'gnus-summary-mode-hook 'jd:no-cursor)
(add-hook 'gnus-group-mode-hook 'jd:no-cursor)
