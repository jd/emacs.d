(setq dired-recursive-deletes 'always)
(setq dired-listing-switches "-alh")
(add-hook 'dired-mode-hook 'turn-on-gnus-dired-mode)
