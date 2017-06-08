(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)

(package-initialize)

(dolist (package '(naquadah-theme
                   ;; anaconda-mode
		   oauth2		; Should be a dep of google-stuff
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
                   crux
                   ))
  (unless (package-installed-p package)
    (package-install package)))
