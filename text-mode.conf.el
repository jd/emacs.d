(add-hook 'text-mode-hook
          (lambda ()
            (jd:font-lock-add-hack-keywords)
            (auto-fill-mode 1)
            (use-hard-newlines 1 'never)))
