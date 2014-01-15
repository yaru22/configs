;; Add various modes to the load-path
(add-to-list 'load-path "~/.emacs.d/modes/")

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

;; flymake-jshint mode
;; This requires that you have jshint-mode (run "npm install jshint-mode")
;; https://github.com/daleharvey/jshint-mode
(add-to-list 'load-path "~/node_modules/jshint-mode")
(require 'flymake-jshint)
(add-hook 'javascript-mode-hook
    (lambda () (flymake-mode t)))

;; Turns on flymake for all files which have a flymake mode
(add-hook 'find-file-hook 'flymake-find-file-hook)

;; Lua mode
(setq lua-indent-level 2)

;; Coffee script mode
(require 'coffee-mode)

;; Less CSS mode
(require 'less-css-mode)

;; HTML mode for .tmpl files
(add-to-list 'auto-mode-alist '("\\.tmpl$" . html-mode))

;; Tramp default method
(setq tramp-default-method "ssh")

;; Activate Emacs Code Browser manually since ecb-auto-activate doesn't seem to work
;; (ecb-activate)
