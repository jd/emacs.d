(setq safe-local-variable-values '((encoding . utf-8)))
(setq backup-directory-alist '(("." . "~/.emacs.d/backups/")))
(setq kept-old-versions 5)
(setq delete-old-versions t)
(setq backup-by-copying t)
(setq version-control t)
;; Autosave out of my way
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))
