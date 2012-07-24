(setq lua-indent-level 4)

;; Lua mode is crap and setup a keymap each time you active the mode
(add-hook 'lua-mode-hook (lambda ()
                           (define-key lua-mode-map (kbd "RET")
                             'newline-and-indent)))
