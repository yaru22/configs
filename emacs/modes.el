;; Add various modes to the load-path
(add-to-list 'load-path "~/.emacs.d/modes/")

;; No tab
(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)

;; c-mode and c++-mode
;; http://www.chemie.fu-berlin.de/chemnet/use/info/cc-mode/cc-mode_6.html
(add-hook 'c-mode-common-hook
  (lambda ()
    (c-set-style "cc-mode")
    (c-set-offset 'substatement-open 0)))

;; Activate Emacs Code Browser manually since ecb-auto-activate doesn't seem to work
;; (ecb-activate)
