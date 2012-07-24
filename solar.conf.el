;; Set time display format
(setcar (memq '12-hours calendar-time-display-form) '24-hours)
(delq 'am-pm calendar-time-display-form)))
