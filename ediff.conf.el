;; Don't break out a separate frame for ediff
(setq ediff-window-setup-function 'ediff-setup-windows-plain)
;; Horizontal splitting really ought to be the default, honestly.
(setq ediff-split-window-function 'split-window-horizontally)
