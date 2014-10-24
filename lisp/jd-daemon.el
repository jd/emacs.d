(when (not (daemonp))
  (server-mode 1))
;; In server mode, C-x C-c delete frame
(when (or (daemonp)
          server-mode)
  (global-set-key "\C-x\C-c" 'delete-frame))

(provide 'jd-daemon)
