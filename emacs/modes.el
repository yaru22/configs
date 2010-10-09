;; Add various modes to the load-path
(add-to-list 'load-path "~/.emacs.d/modes/")
(add-to-list 'load-path "~/.emacs.d/modes/ghc-mod/")

;; No tab
(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)

;; c-mode and c++-mode
;; http://www.chemie.fu-berlin.de/chemnet/use/info/cc-mode/cc-mode_6.html
(load "~/.emacs.d/modes/xcscope")
(add-hook 'c-mode-common-hook
  (lambda ()
    (c-set-style "cc-mode")
    (c-set-offset 'substatement-open 0)))

;; javascript-mode
(autoload 'js2-mode "js2.elc" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

;; haskell-mode
(add-to-list 'exec-path "~/.cabal/bin/")
(require 'inf-haskell)
(autoload 'ghc-init "ghc" nil t)
(add-hook 'haskell-mode-hook (lambda () (ghc-init) (flymake-mode)))

;; scala-mode
(add-to-list 'load-path "/usr/local/scala/misc/scala-tool-support/emacs")
(require 'scala-mode-auto)
(setq yas/my-directory "/usr/local/scala/misc/scala-tool-support/emacs/contrib/yasnippet/snippets")

;; Activate Emacs Code Browser manually since ecb-auto-activate doesn't seem to work
(ecb-activate)
