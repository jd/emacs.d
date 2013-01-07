(define-key doc-mode-map (kbd "C-c C-v")
  (defun jd:doc-preview ()
    (interactive)
    (async-shell-command (concat "evince " (file-name-sans-extension (buffer-file-name)) ".pdf"))))
