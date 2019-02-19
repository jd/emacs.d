(setq flycheck-completing-read-function 'ido-completing-read)
(add-hook 'flycheck-mode-hook 'flycheck-color-mode-line-mode)
