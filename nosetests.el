;; Authors: Chmouel Boudjnah <chmouel@chmouel.com>
;;          Julien Danjou <julien@danjou.info
;;
;; Provide two function to help with running nosetests. One
;; `nosetests-get-command` that would copy your yank ring the current
;; test to feed to nose on the shell and the other `nosetests-compile`
;; that would launch the current test with nose in a compile buffer.

(defvar nosetests-bin "nosetests")

(defvar nosetests-arg "-sx")

(defun nosetests-get-root-directory ()
  "Return root directory to run tests."
  (file-truename (or (locate-dominating-file
                      (buffer-file-name) "setup.py") "./")))

(defun nosetests-get-command ()
  (let ((current-function (python-info-current-defun)))
    (unless current-function
      (error "No function at point"))
    (concat
     nosetests-bin " "
     nosetests-arg " "
     (subst-char-in-string
      ?/ ?.
      (file-name-sans-extension
       (substring (file-truename
                   (buffer-file-name))
                  (length (nosetests-get-root-directory)))))
     ":"
     current-function)))

;;;###autoload
(defun nosetests-compile ()
  (interactive)
  (let ((default-directory (nosetests-get-root-directory)))
    (compile (nosetests-get-command))))

(provide 'nosetests)
