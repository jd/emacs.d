;; Check every 5 minutes when emacs is idle
(gnus-demon-add-handler 'gnus-group-get-new-news 5 t)
