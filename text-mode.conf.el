(add-hook 'text-mode-hook
          (defun jd:text-mode-hook ()
            (unless (eq major-mode 'org-mode)
              (jd:font-lock-add-hack-keywords))
            (turn-on-flyspell)
            (auto-fill-mode 1)
            (use-hard-newlines 1 'never)))
