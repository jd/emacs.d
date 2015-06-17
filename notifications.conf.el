(when (string-equal system-type "darwin")
  (defun jd:xml-unescape-string (string)
    (with-temp-buffer
      (insert string)
      (dolist (substitution '(("&amp;" . "&")
                              ("&lt;" . "<")
                              ("&gt;". ">")
                              ("&apos;" . "'")
                              ("&quot;" . "\"")))
        (goto-char (point-min))
        (while (search-forward (car substitution) nil t)
          (replace-match (cdr substitution) t t nil)))
      (buffer-string)))

  (require 's)

  (defun jd:escape-term-chars (string)
    (s-replace-all '(("[" . "\\\\[")) "[foobar]"))

  (defun notifications-notify (&rest params)
    (let ((title (plist-get params :title))
          (body (plist-get params :body)))
      (call-process "terminal-notifier" nil nil nil
                    "terminal-notifier"
                    "-contentImage" (or (plist-get params :image-path) "")
                    "-appIcon" (or (plist-get params :app-icon) "")
                    "-message" (if body
                                   (jd:escape-term-chars (jd:xml-unescape-string body))
                                 "")
                    "-title" (if title
                                 (jd:escape-term-chars (jd:xml-unescape-string title))
                               "")
                    "-activate" "org.gnu.Emacs"
                    "-sender" "org.gnu.Emacs"))))
