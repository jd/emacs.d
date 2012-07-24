(setq erc-track-exclude-types '("NICK" "JOIN" "PART" "QUIT" "MODE"
                                "301" ; away notice
                                "305" ; return from awayness
                                "306" ; set awayness
                                "332" ; topic notice
                                "333" ; who set the topic
                                "353" ; Names notice
                                "324" ; modes
                                "329" ; channel creation date
                                ))
(setq erc-track-exclude-server-buffer t)
(setq erc-track-exclude '("*stickychan" "*status"))
(setq erc-track-showcount t)
(setq erc-track-shorten-start 1)
(setq erc-track-switch-direction 'importance)
(setq erc-track-visibility 'selected-visible)

;; This seems useful when using a visibility set to `selected-visible'.  If
;; you go to a frame where (nth 1 erc-modified-channels-alist) is
;; (current-buffer), when it will fail to switch. Recomputing will fix that.
(defadvice erc-track-switch-buffer
  (before jd:erc-track-switch-buffer-reset-display activate protect)
  "Recompute `erc-modified-channels-alist' before trying to
switch to a track channel."
  (when (eq major-mode 'erc-mode)
    (erc-track-modified-channels)))
