(setq magit-repo-dirs `(,jd:projects-directory "~/Debian"))
(setq magit-commit-signoff t)
(setq magit-remote-ref-format 'remote-slash-branch)
(setq magit-completing-read-function 'magit-ido-completing-read)
(setq magit-save-some-buffers nil)

;; Remove stashes from the status buffer
(setq magit-status-sections-hook (delq 'magit-insert-stashes magit-status-sections-hook))
(setq magit-last-seen-setup-instructions "1.4.0")
