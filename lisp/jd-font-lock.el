;;;###autoload
(defun jd:font-lock-add-hack-keywords ()
  (font-lock-add-keywords
   nil
   '(("\\<\\(FIXME\\|HACK\\|XXX\\|TODO\\|NOTE\\)\\>"
      1
      '(:box (:color "grey10" :line-width 2) :background "red" :weight bold :foreground "yellow")
      prepend))))
