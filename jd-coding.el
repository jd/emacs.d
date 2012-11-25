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
    sql-mode
    rst-mode)
  "What considering as programming languages.")

(defun jd:customize-programming-language-mode ()
  (font-lock-add-keywords
   nil
   '(("\\<\\(FIXME\\|HACK\\|XXX\\|TODO\\|NOTE\\)"
      1
      '(:box (:color "grey10" :line-width 2) :background "red" :bold t :foreground "yellow")
      prepend)))
  (idle-highlight-mode 1)
  (rainbow-mode 1)
  (rainbow-delimiters-mode 1)
  (setq show-trailing-whitespace t)
  (flyspell-prog-mode))

(dolist (mode jd:programming-language-major-modes)
  (add-hook
   (intern (concat (symbol-name mode) "-hook"))
   'jd:customize-programming-language-mode))

(semantic-mode 1)
(global-semantic-stickyfunc-mode 1)
(global-semantic-idle-summary-mode 1)

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
;; Don't insert electric newlines on ;
;; That makes me CRAZY
(setq-default c-hanging-semi&comma-criteria nil)

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

;; lisp
(add-hook 'lisp-mode-hook (defun jd:turn-on-slime-mode ()
                            (slime-mode 1)))

(provide 'jd-coding)
