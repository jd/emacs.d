(setq erc-keywords '("julien" "danjou" "awesome" "naquadah"))

(defcustom jd:erc-pals-file "~/.erc.pals"
  "File containing a list of pals for ERC.
Put each name on a line."
  :type 'file)

(defcustom jd:erc-fools-file "~/.erc.fools"
  "File containing a list of pals for ERC.
Put each name on a line."
  :type 'file)

(defun jd:erc-read-file (file)
  (when (file-exists-p file)
    (remove-if
     (lambda (str) (string= str ""))
     (split-string
      (with-temp-buffer
        (insert-file-contents-literally file)
        (buffer-string))
      "\n"))))

(setq erc-pals (jd:erc-read-file jd:erc-pals-file))
(setq erc-fools (jd:erc-read-file jd:erc-fools-file))

(setq erc-match-exclude-server-buffer t)
