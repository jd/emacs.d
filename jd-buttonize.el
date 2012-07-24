(defun jd:awesome-browse-bug (bug)
  "Browse an awesome bug. Argument is a bug number."
  (interactive
   (list (or current-prefix-arg
             (read-number "awesome bug number: #"))))
  (browse-url
   (format "http://awesome.naquadah.org/bugs/index.php?do=details&task_id=%s" bug)))

(defun jd:gnu-browse-bug (bug)
  "Browse a GNU bug. Argument is a bug number."
  (interactive
   (list (or current-prefix-arg
             (read-number "GNU bug number: #"))))
  (browse-url
   (format "http://debbugs.gnu.org/%s" bug)))

(defcustom jd:button-alist
  '(("debian"
     "#\\([0-9]+\\)"
     0
     debian-bug-web-bug
     1)

    ("emacs"
     "#\\([0-9]+\\)"
     0
     jd:gnu-browse-bug
     1)

    ("awesome"
     "\\(?:FS\\)?#\\([0-9]+\\)"
     0
     jd:awesome-browse-bug
     1))
  "Alist of regexps matching button in various buffers.
Each entry has the form (CONTEXT-REGEXP REGEXP BUTTON CALLBACK PAR).
CONTEXT-REGEXP: is the string matching if the buttonization should be enabled in this context. For Gnus, it's the current group name. For Erc, it's the current default recipient.
REGEXP: is the string matching text around the button
BUTTON: is the number of the regexp grouping actually matching the button
CALLBACK: is the function to call when the user push this button
PAR: is a number of regexp grouping whose text will be passed to CALLBACK.")

(provide 'jd-buttonize)
