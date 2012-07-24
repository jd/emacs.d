(setq kill-ring-max 500)
(setq mail-user-agent 'gnus-user-agent)
(setq read-mail-command 'gnus)

;; TODO find a better way to do this than advising
;; Clear lines with only spaces when moving around
(defun jd:delete-horizontal-space-on-empty-lines ()
  (unless buffer-read-only
    (save-excursion
      (beginning-of-line)
      ;; This is an empty line, delete its spaces
      (when (looking-at "[ \t]*$")
        (delete-horizontal-space)))))

(defadvice next-line
  (before jd:next-line-delete-horizontal-space activate protect)
  "Delete spaces before going to next line."
  (jd:delete-horizontal-space-on-empty-lines))

(defadvice previous-line
  (before jd:previous-line-delete-horizontal-space activate protect)
  "Delete spaces before going to next line."
  (jd:delete-horizontal-space-on-empty-lines))
