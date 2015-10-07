;; dot emacs from Julien Danjou <julien@danjou.info>
;; Written since 2009!

;; Expand load-path
(add-to-list 'load-path "~/.emacs.d/lisp")

;; Add development directory for some project
(dolist (dir '("~/Source/gnus/lisp"
               "~/Source/naquadah-theme"))
  (when (file-exists-p dir)
    (add-to-list 'load-path dir)))

;; Generate autoloads
(let ((generated-autoload-file "~/.emacs.d/lisp/jd-autoloads.el"))
  (update-directory-autoloads "~/.emacs.d/lisp")
  (load generated-autoload-file)
  (let ((buf (get-file-buffer generated-autoload-file)))
    (when buf (kill-buffer buf))))

;; Each file named <somelibrary>.preload.el is loaded right now, e.g. before the
;; library is loaded. This should really not be needed, but some libraries are
;; badly designed and need this until I have the time to fix them.
(dolist (file (directory-files user-emacs-directory))
  (when (string-match (format "^\\(.+\\)\\.preload\\.el$") file)
    (load (concat user-emacs-directory file))))

;; Each file named <somelibrary>.conf.el is loaded just after the library is
;; loaded.
(dolist (file (directory-files user-emacs-directory))
  (when (string-match (format "^\\(.+\\)\\.conf\\.el$") file)
    (eval-after-load (match-string-no-properties 1 file)
      `(load ,(concat user-emacs-directory file)))))

(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

;; Install packages
(require 'package)

(defvar jd:projects-directory (expand-file-name "~/Source")
  "Where I store my projects.
This variable is used in some places.")


(require 'jd-keybindings)
(require 'jd-daemon)
(require 'jd-coding)
(require 'ob)
(require 'org-crypt)
(require 'org-habit)
(require 'org-plot)
(require 'naquadah-theme)
(require 'saveplace)
(require 'uniquify)
(require 'mmm-auto)
(require 'google-contacts-message)
(require 'google-contacts-gnus)

(powerline-default-theme)

;; C source code
(setq frame-title-format '("" invocation-name ": %b"))
(set-frame-font "Hack 12")
;; (set-fontset-font t 'unicode (font-spec :family "Droid Sans"))
(if (string-equal system-type "darwin")
    ;; (set-fontset-font "fontset-default"
    ;;                   'unicode
    ;;                   '("Menlo" . "iso10646-1"))
    (progn
      (add-to-list 'exec-path "/usr/local/bin")
      (add-to-list 'exec-path "/usr/local/sbin"))
  (menu-bar-mode -1))                   ; Kill the menu bar
(setq ns-right-alternate-modifier nil)  ; Do not use the right Option as
                                        ; meta, rather use it for
                                        ; composition
(tool-bar-mode -1)			; Kill the toolbar
(setq scroll-step 1)
(setq visible-bell nil)                 ; This bugs with El Capitan
(setq-default fill-column 79)
(setq user-full-name "Julien Danjou")
(defalias 'yes-or-no-p 'y-or-n-p)
(set-default 'indicate-buffer-boundaries '((up . nil) (down . nil) (t . left)))
(setq next-screen-context-lines 5)      ; I want to keep more lines when
                                        ; switching pages
(setq use-dialog-box nil)               ; Seriously…
(setq source-directory "~/Source/emacs/src")
(put 'narrow-to-region 'disabled nil)
(set-default 'indent-tabs-mode nil)    ; always use spaces to indent, no tab

(display-time-mode 1)
(global-hi-lock-mode 1)                 ; highlight stuff
(global-git-gutter-mode 1)              ; git gutter seems nice
(savehist-mode 1)
(blink-cursor-mode 1)			; blink!
(delete-selection-mode 1)		; Transient mark can delete/replace
(when (fboundp 'set-scroll-bar-mode)
  (set-scroll-bar-mode 'right))		; Scrollbar on the right
(when (fboundp 'scroll-bar-mode)
  (scroll-bar-mode -1))			; But no scrollbar
(line-number-mode 1)			; Show line number
(column-number-mode 1)			; Show colum number
(global-hl-line-mode 1)			; Highlight the current line
(global-auto-revert-mode 1)
(windmove-default-keybindings)	      ; Move between frames with Shift+arrow
(show-paren-mode t)
(mouse-avoidance-mode 'animate)         ; Move the mouse away
(browse-kill-ring-default-keybindings)
(ido-mode 1)

(org-crypt-use-before-save-magic)
(bbdb-initialize 'gnus 'message)
(bbdb-mua-auto-update-init 'gnus 'message)
