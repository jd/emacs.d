(defcustom jd:programming-language-major-modes
  '(prog-mode     ; This is the mode perl, makefile, lisp-mode, scheme-mode,
                  ; emacs-lisp-mode, sh-mode, java-mode, c-mode, c++-mode,
                  ; python-mode inherits from.
    lua-mode
    cmake-mode
    tex-mode                            ; LaTeX inherits
    sgml-mode                           ; HTML inherits
    css-mode
    nxml-mode
    diff-mode
    haskell-mode
    rst-mode)
  "What considering as programming languages.")

(dolist (mode jd:programming-language-major-modes)
  (add-hook
   (intern (concat (symbol-name mode) "-hook"))
   (lambda ()
     (font-lock-add-keywords
      nil
      '(("\\<\\(FIXME\\|HACK\\|XXX\\|TODO\\|NOTE\\)"
         1
         '(:box (:color "grey10" :line-width 2) :background "red" :bold t :foreground "yellow")
         prepend)))
     (rainbow-mode 1)
     (rainbow-delimiters-mode 1)
     (setq show-trailing-whitespace t)
     (flyspell-prog-mode))))

;; CC mode
(c-add-style "jd"
	     '("gnu"
	       (c-offsets-alist
		(block-open . 0)
		(block-close . 0)
		(substatement-open . 0)
		(case-label . +)
		(func-decl-cont . 0)
		(inline-open . 0))
	       (c-hanging-braces-alist
                (brace-list-close nil)
		(defun-open before after)
		(defun-close after)
		(class-open before after)
		(class-close before)
		(substatement-open after before)
		(substatement-close after))
	       (c-block-comment-prefix . "* ")
	       (c-echo-syntactic-information-p . t)
	       (c-basic-offset . 4)))
(setq c-block-comment-prefix "* ")

(add-hook 'c-mode-common-hook
	  (lambda ()
            (when (fboundp 'doxymacs-mode)
              (doxymacs-mode 1))
	    (c-set-style "jd")
	    (c-toggle-auto-newline 1)))
(add-hook 'c-initialization-hook
	  (lambda () (define-key c-mode-base-map (kbd "RET") 'newline-and-indent)))

(font-lock-add-keywords 'c-mode
                        '(("\\<.+_t\\>" . font-lock-type-face)
                          ("\\<bool\\>" . font-lock-type-face)
                          ("\\<foreach\\>" . font-lock-keyword-face)))

;; elisp
(defcustom jd:elisp-programming-major-modes
  '(emacs-lisp-mode
    lisp-interaction-mode
    ielm-mode)
  "Mode that are used to do Elisp programming.")

(dolist (mode jd:elisp-programming-major-modes)
  (add-hook
   (intern (concat (symbol-name mode) "-hook")) 'turn-on-eldoc-mode))

(provide 'jd-coding)
