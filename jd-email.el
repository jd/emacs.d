(defvar jd:email-addresses
  '("\\(julien\\|jd\\)\\(\\+.+\\)?@danjou\\.info"
    "acid\\(-.+\\)?@debian\\.org"
    "jdanjou@freedesktop\\.org"
    "jdanjou\\(\\+.+\\)?@ornix\\.org"
    "jdanjou@gmail\\.com"
    "julien\\.danjou@enovance\\.com"
    "jd@enovance\\.com"
    "jd\\(\\+.+\\)?@naquadah.org")
  "Regexp of my email addreses.")

(defvar jd:email-addresses-regexp
  (concat "^\\("
          (mapconcat 'identity jd:email-addresses "\\|")
          "\\)$"))

(provide 'jd-email)
