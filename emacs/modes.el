;; No tab
(setq-default tab-width 2)
(setq-default indent-tabs-mode nil)

;; c-mode and c++-mode
;; http://www.chemie.fu-berlin.de/chemnet/use/info/cc-mode/cc-mode_6.html
(add-hook 'c-mode-common-hook
  (lambda ()
    (c-set-style "cc-mode")
    (c-set-offset 'substatement-open 0)))

;; Javascript mode
(setq js-indent-level 2)

;; Turns on flymake for all files which have a flymake mode
(add-hook 'find-file-hook 'flymake-find-file-hook)

;; Lua mode
(setq lua-indent-level 2)

;; HTML mode for .tmpl files
(add-to-list 'auto-mode-alist '("\\.tmpl$" . html-mode))

;; Tramp default method
(setq tramp-default-method "ssh")

;; Activate Emacs Code Browser manually since ecb-auto-activate doesn't seem to work
;; (ecb-activate)
