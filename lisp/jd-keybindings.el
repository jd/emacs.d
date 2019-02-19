(global-set-key "\C-cq"
                (defun jd:quit-emacs ()
                  (interactive)
                  (if (yes-or-no-p "Quit emacs? ")
                      (save-buffers-kill-emacs)
                    (message "Coward!"))))

(global-set-key "\C-ccd"
                (defun jd:edit-emacs-dir ()
                  "Edit the ~/.emacs.d/ dir"
                  (interactive)
                  (let ((default-directory "~/.emacs.d/"))
                    (call-interactively 'find-file))))

(global-set-key [f11]
                (defun jd:set-frame-maximized ()
                  (interactive)
                  (set-frame-parameter nil 'fullscreen
                                       (if (eq (frame-parameter nil 'fullscreen) 'maximized) nil 'maximized))))

(global-set-key "\C-xm" (defun jd:compose-mail (arg)
                          (interactive "P")
                          (if arg
                              (let ((gnus-newsgroup-name (gnus-group-completing-read)))
                                (gnus-post-news 'post gnus-newsgroup-name))
                            (compose-mail-other-window))))

(global-set-key "\C-x\C-b" 'ibuffer)

(global-set-key [s-f12] (lambda ()
                          (interactive)
                          (if (gnus-alive-p)
                              (switch-to-buffer gnus-group-buffer)
                            (gnus))))

(global-set-key "\M-/" 'hippie-expand)

(global-set-key (kbd "C-c C-,") 'magit-status)

(global-set-key (kbd "<f5>") 'recompile)

(global-set-key (kbd "C-x k") 'kill-this-buffer)

(require 'multi-term)
(global-set-key [f6] (lambda () (interactive)
                       (unless (multi-term-dedicated-exist-p)
                         (multi-term-dedicated-open))
                       (multi-term-dedicated-select)))
(global-set-key [S-f6] 'multi-term-dedicated-toggle)
(global-set-key [f9] 'multi-term-next)
(global-set-key [S-f9] 'multi-term)

(global-set-key (kbd "C-c g") 'jd:google)

(global-set-key (kbd "C-c d v") 'jd:debian-view-changelog)
(global-set-key (kbd "C-c d V") 'jd:debian-view-online-changelog)
(global-set-key (kbd "C-c d b") 'gnus-read-ephemeral-debian-bug-group)

(global-set-key (kbd "C-x C-/") 'goto-last-change)

(require 'crux)

(global-set-key (kbd "C-x 4 t") 'crux-transpose-windows)
(global-set-key (kbd "C-c r") 'crux-rename-file-and-buffer)
(global-set-key (kbd "C-c c e") 'crux-find-user-init-file)
(global-set-key [remap move-beginning-of-line] 'crux-move-beginning-of-line)
(global-set-key (kbd "C-<return>") 'crux-smart-open-line)

(provide 'jd-keybindings)
