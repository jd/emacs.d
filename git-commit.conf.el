(add-hook 'git-commit-mode-hook (lambda () (toggle-save-place 0))) ; Disable it
(add-hook 'git-commit-mode-hook 'turn-on-flyspell)
