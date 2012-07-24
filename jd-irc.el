(defun jd:erc-start ()
  (erc-tls
   :server "prometheus.naquadah.org"
   :port 6666
   :nick "jd-naquadah")
  (erc-tls
   :server "prometheus.naquadah.org"
   :port 6666
   :nick "jd-oftc")
  (erc-tls
   :server "prometheus.naquadah.org"
   :port 6666
   :nick "jd-freenode")
  (erc-tls
   :server "prometheus.naquadah.org"
   :port 6666
   :nick "jd-lost-oasis"))

(defun jd:erc-stop ()
  "Disconnect from IRC servers."
  (interactive)
  (dolist (buffer (erc-buffer-list))
    (kill-buffer buffer)))

;;;###autoload
(defun jd:irc ()
  "Connect to IRC servers."
  (interactive)
  (let ((buflist (when (fboundp 'erc-buffer-list)
                   (erc-buffer-list))))
    (if buflist
        (if (yes-or-no-p "Restart IRC?")
            (progn
              (jd:erc-stop)
              (jd:erc-start))
          (message "Not doing anything."))
      (jd:erc-start))))

(provide 'jd-irc)
