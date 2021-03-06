(add-to-list 'erc-modules 'smiley)
(add-to-list 'erc-modules 'match)
(add-to-list 'erc-modules 'scrolltobottom)
(add-to-list 'erc-modules 'notifications)

(setq erc-header-line-format "%t: %o")
(setq erc-join-buffer 'bury)
(setq erc-warn-about-blank-lines nil)
(setq erc-interpret-mirc-color t)

(setq erc-server-reconnect-attempts t)
(setq erc-server-reconnect-timeout 10)

(setq erc-prompt (lambda ()
                   (if erc-network
                       (concat "[" (symbol-name erc-network) "]")
                     (concat "[" (car erc-default-recipients) "]"))))

(defun erc-button-url-previous ()
  "Go to the previous URL button in this buffer."
  (interactive)
  (let* ((point (point))
         (found (catch 'found
                  (while (setq point (previous-single-property-change point 'erc-callback))
                    (when (eq (get-text-property point 'erc-callback) 'browse-url)
                      (throw 'found point))))))
    (if found
        (goto-char found)
      (error "No previous URL button."))))

(define-key erc-mode-map [backtab] 'erc-button-url-previous)

(add-hook 'erc-mode-hook
          (defun jd:fix-scrolling-bug ()
            "See http://debbugs.gnu.org/cgi/bugreport.cgi?bug=11697"
            (set (make-local-variable 'scroll-conservatively) 1000)))

(defun erc-generate-new-buffer-name (server port target &optional proc)
  "Create a new buffer name based on the arguments."
  (let ((buf-name
	 (if target
	     (concat target
                     (when erc-network
                       (concat "@" (symbol-name erc-network))))
	   (concat server ":"
		   (if (numberp port)
		       (number-to-string port)
		     port)))))
    (if erc-reuse-buffers
	(let ((buf (get-buffer buf-name)))
	  (if buf
	      (with-current-buffer buf
		;; Check that the server/port is the same
		(if (and (string= erc-session-server server)
			 (erc-port-equal erc-session-port port)
			 ;; If this is for a target, we're good, if it's a
			 ;; server we need to check it's dead
			 (or target
			     (and
			      (erc-server-buffer-p)
			      (not (erc-server-process-alive)))))
		    buf-name
                  (generate-new-buffer-name buf-name)))
	    buf-name))
      (generate-new-buffer-name buf-name))))
