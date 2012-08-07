(add-to-list 'semanticdb-project-root-functions
             (defun jd:semanticdb-is-project-root (directory-name)
               (save-match-data
                 (when (string-match
                        (concat "^\\(" (regexp-quote (expand-file-name jd:projects-directory)) "/[^/]+\\)")
                        directory-name)
                   (match-string 1 directory-name)))))
