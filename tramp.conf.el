;; This is supposed to make sudo work, but it breaks /ssh:user@hostname:/
;; (add-to-list 'tramp-default-proxies-alist '(".*" "\\`.+\\'" "/ssh:%h:"))
