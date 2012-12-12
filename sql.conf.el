(add-hook 'sql-mode-hook
          (defun jd:sql-mode-set-sql-product ()
            (sql-set-product 'postgres))) ; That's what I do the most.mode.conf
