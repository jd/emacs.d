;;;###autoload
(defun jd:google (keywords)
  "Form a google query URL and give it to browse-url"
  (interactive
   (list
    (if (use-region-p)
	(buffer-substring (region-beginning) (region-end))
      (read-string "Search Google for: " (thing-at-point 'word)))))
  (browse-url
   (concat "http://www.google.com/search?q="
	   (replace-regexp-in-string
	    "[[:space:]]+"
	    "+"
	    keywords))))

(provide 'jd-google)
