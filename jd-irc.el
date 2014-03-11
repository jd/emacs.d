(defun jd:erc-start ()
  (erc-tls
   :server "prometheus.naquadah.org"
   :port 6666
   :nick "jd/naquadah")
  (erc-tls
   :server "prometheus.naquadah.org"
   :port 6666
   :nick "jd/bitlbee")
  (erc-tls
   :server "prometheus.naquadah.org"
   :port 6666
   :nick "jd/oftc")
  (erc-tls
   :server "prometheus.naquadah.org"
   :port 6666
   :nick "jd/freenode")
  (erc-tls
   :server "prometheus.naquadah.org"
   :port 6666
   :nick "jd/lost-oasis")
  (erc-tls
   :server "prometheus.naquadah.org"
   :port 6666
   :nick "jd/cloudwatt"))

(defun jd:erc-stop ()
  "Disconnect from IRC servers."
  (interactive)
  (dolist (buffer (erc-buffer-list))
    (when (erc-server-buffer-p buffer)
      (kill-buffer buffer))))

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

;; (setq rcirc-server-alist
;;       `(("prometheus.naquadah.org"
;;          :encryption tls
;;          :port 6666
;;          :nick "jd/naquadah"
;;          :password ,(funcall
;;                      (cadr
;;                       (memq :secret
;;                             (car (auth-source-search :host "prometheus.naquadah.org"
;;                                                      :max 1
;;                                                      :port 6666
;;                                                      :user "jd/naquadah"
;;                                                      :require '(:secret)))))))))

(provide 'jd-irc)
