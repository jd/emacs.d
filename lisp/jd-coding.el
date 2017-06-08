(defcustom jd:programming-language-major-modes
  '(prog-mode     ; This is the mode perl, makefile, lisp-mode, scheme-mode,
                  ; emacs-lisp-mode, sh-mode, java-mode, c-mode, c++-mode,
                  ; python-mode inherits from.
    lua-mode
    cmake-mode
    tex-mode                            ; LaTeX inherits
    css-mode
    nxml-mode
    diff-mode
    haskell-mode
    sql-mode
    rst-mode)
  "What considering as programming languages.")

(defun jd:customize-prog-mode-common ()
  (jd:font-lock-add-hack-keywords)
  (rainbow-mode 1)
  (rainbow-delimiters-mode 1)
  (setq show-trailing-whitespace t)
  (flyspell-prog-mode))

(defun jd:customize-programming-language-mode ()
  (jd:customize-prog-mode-common)
  (flycheck-mode 1))

(dolist (mode jd:programming-language-major-modes)
  (add-hook
   (intern (concat (symbol-name mode) "-hook"))
   'jd:customize-programming-language-mode))

(add-hook 'sgml-mode-hook 'jd:customize-prog-mode-common)

(add-hook 'python-mode-hook 'fci-mode)
;; (add-hook 'python-mode-hook 'anaconda-mode)
;; (add-hook 'python-mode-hook 'anaconda-eldoc-mode)

;; Fucking slow down everything
;; (semantic-mode 1)

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
  (let ((sym (intern (concat (symbol-name mode) "-hook"))))
    (add-hook sym 'turn-on-eldoc-mode)))

;; lisp
(add-hook 'lisp-mode-hook (defun jd:turn-on-slime-mode ()
                            (slime-mode 1)
                            (slime-autodoc-mode 1)))

(slime-setup '(slime-fancy slime-autodoc slime-indentation))

(provide 'jd-coding)
