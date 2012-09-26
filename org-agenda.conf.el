(setq org-agenda-day-face-function
      (defun jd:org-agenda-day-face-holidays-function (date)
        "Compute DATE face with holidays."
        (unless (org-agenda-todayp date)
          (dolist (file (org-agenda-files nil 'ifmode))
            (let ((face
                   (dolist (entry (org-agenda-get-day-entries file date))
                     (let ((category (with-temp-buffer
                                       (insert entry)
                                       (org-get-category (point-min)))))
                       (cond ((or (string= "Holidays" category)
                                  (string= "RTT" category)
                                  (string= "Vacation" category))
                              (return 'org-agenda-date-weekend))
                             ((string-match-p "Telecommuting" entry)
                              (return 'org-agenda-date-tc)))))))
              (when face (return face)))))))
(setq org-stuck-projects
      '("TODO=\"PROJECT\""
	("TODO" "STARTED" "FEEDBACK" "REWORK" "VERIFY" "DELEGATED")
	nil ""))
(setq org-agenda-category-icon-alist
      '(("[Ee]macs" "/usr/share/icons/hicolor/16x16/apps/emacs-snapshot.png" nil nil :ascent center)
        ("Naquadah" "~/.emacs.d/icons/org/naquadah.png" nil nil :ascent center)
        ("Visitors" "~/.emacs.d/icons/org/visitors.png" nil nil :ascent center)
        ("\\(Party\\|Celeb\\)" "~/.emacs.d/icons/org/party.png" nil nil :ascent center)
        ("Wine" "~/.emacs.d/icons/org/wine.png" nil nil :ascent center)
        ("Gnus" "~/.emacs.d/icons/org/gnus.png" nil nil :ascent center)
        ("Org" "~/.emacs.d/icons/org/org.png" nil nil :ascent center)
        ("Medical" "~/.emacs.d/icons/org/medical.png" nil nil :ascent center)
        ("Music" "~/.emacs.d/icons/org/music.png" nil nil :ascent center)
        ("Wii" "~/.emacs.d/icons/org/wii.png" nil nil :ascent center)
        ("Trip" "~/.emacs.d/icons/org/trip.png" nil nil :ascent center)
        ("Train" "~/.emacs.d/icons/org/train.png" nil nil :ascent center)
        ("Anniv" "~/.emacs.d/icons/org/anniversary.png" nil nil :ascent center)
        ("Debian" "~/.emacs.d/icons/org/debian.png" nil nil :ascent center)
        ("Plants" "~/.emacs.d/icons/org/tree.png" nil nil :ascent center)
        ("awesome" "~/.emacs.d/icons/org/awesome.png" nil nil :ascent center)
        ("Solar" "~/.emacs.d/icons/org/solar.png" nil nil :ascent center)
        ("Reading" "~/.emacs.d/icons/org/book.png" nil nil :ascent center)
        ("OpenStack" "~/.emacs.d/icons/org/openstack.png" nil nil :ascent center)
        ("\\(Holidays\\|Vacation\\)" "~/.emacs.d/icons/org/holidays.png" nil nil :ascent center)
        (".*" '(space . (:width (16))))))
(setq org-agenda-files (list org-directory))
(setq org-agenda-custom-commands
      '(("p" "Projects" todo "PROJECT"
         ((org-agenda-dim-blocked-tasks t)
          (org-agenda-skip-scheduled-if-done nil)
          (org-agenda-skip-deadline-if-done nil)
          (org-agenda-todo-ignore-with-date nil)
          (org-agenda-todo-ignore-scheduled nil)
          (org-agenda-todo-ignore-deadlines nil)))
        ("b" "Things to buy any time" tags-todo "+tobuy+SCHEDULED=\"\"")
        ("y" "Syadmin stuff to do" tags-todo "+sysadmin+SCHEDULED=\"\"")))
(setq org-agenda-skip-additional-timestamps-same-entry nil)
(setq org-agenda-skip-scheduled-if-done t)
(setq org-agenda-skip-deadline-if-done t)
(setq org-agenda-todo-ignore-timestamp 'future)
(setq org-agenda-todo-ignore-scheduled t)
(setq org-agenda-skip-deadline-prewarning-if-scheduled t)
(setq org-agenda-skip-timestamp-if-done t)
(setq org-agenda-dim-blocked-tasks 'invisible)
