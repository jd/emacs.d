(define-key python-mode-map (kbd "RET") 'newline-and-indent)
(add-hook 'python-mode-hook 'turn-on-eldoc-mode)
