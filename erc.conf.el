(add-to-list 'erc-modules 'smiley)
(add-to-list 'erc-modules 'match)
(add-to-list 'erc-modules 'scrolltobottom)
(add-to-list 'erc-modules 'notifications)
(add-to-list 'erc-modules 'track-score)

(setq erc-header-line-format "%t: %o")
(setq erc-join-buffer 'bury)

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
