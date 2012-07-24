(defun phone-number-bounds-of-phone-number-at-point ()
  "Return the start and end points of a phone number at the current point.
The result is a paired list of character positions for an phone
number located at the current point in the current buffer. An
phone number is any decimal digit 0 through 9 with an optional
starting plus symbol (`+') and with `.', `-' or space in it."
  (save-excursion
    (skip-chars-backward "()0123456789 .+-")
    (if (looking-at "[()+0-9 ]+")
        (let ((start (point)))
          (skip-chars-forward "()0123456789 .+-")
          (cons start (point)))
      nil)))

(put 'phone-number 'bounds-of-thing-at-point
     'phone-number-bounds-of-phone-number-at-point)
