(setq mm-verify-option 'known)
(setq mm-decrypt-option 'known)
;; Even if attached, treat as inline
(add-to-list 'mm-attachment-override-types "image/.*")
(add-to-list 'mm-attachment-override-types "message/rfc822")
(add-to-list 'mm-attachment-override-types "text/x-patch")
(setq mm-inline-large-images 'resize)
(setq mm-discouraged-alternatives '("text/html" "text/richtext"))
