(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)

(package-initialize)

(dolist (package '(naquadah-theme
                   elpy
                   graphviz-dot-mode
                   rjsx-mode
                   ;; anaconda-mode
		   oauth2		; Should be a dep of google-stuff
                   protobuf-mode
                   dockerfile-mode
		   browse-kill-ring
                   fill-column-indicator
                   ido-completing-read+ ; for magit
                   adoc-mode
                   powerline
		   go-mode
                   puppet-mode
                   gnuplot
                   bbdb
		   rainbow-mode
		   google-maps
		   multi-term
		   hy-mode
		   markdown-mode
		   gnuplot-mode
		   magit
		   rainbow-delimiters
		   htmlize
		   lua-mode
		   google-contacts
		   yaml-mode
		   haskell-mode
		   php-mode
		   ;; cmake-mode
		   goto-last-change
		   git-gutter
		   mmm-mode
                   cython-mode
		   clojure-mode
		   slime
		   jinja2-mode
                   flycheck
                   flycheck-color-mode-line
                   crux
                   rust-mode
                   color-identifiers-mode
                   typescript-mode
                   ))
  (unless (package-installed-p package)
    (package-install package)))
