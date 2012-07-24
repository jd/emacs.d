(add-hook 'text-mode-hook
          (lambda ()
            (auto-fill-mode 1)
            (use-hard-newlines 1 'never)))
