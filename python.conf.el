(define-key python-mode-map (kbd "RET") 'newline-and-indent)
(define-key python-mode-map (kbd "S-<f5>") 'nosetests-compile)
(add-hook 'python-mode-hook 'turn-on-eldoc-mode)
