(add-to-list 'load-path "~/.emacs.d/modes/")
(add-to-list 'load-path "~/.emacs.d/modes/ghc-mod/")

;; no tab
(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)

;; auto-complete modes
(load "~/.emacs.d/modes/auto-complete.el")
(load "~/.emacs.d/modes/auto-complete-haskell.el")

;; hl-line-mode to all the programming modes
(add-hook 'c-mode-hook 'hl-line-mode)
(add-hook 'c++-mode-hook 'hl-line-mode)
(add-hook 'css-mode-hook 'hl-line-mode)
(add-hook 'emacs-lisp-mode-hook 'hl-line-mode)
(add-hook 'haskell-mode-hook 'hl-line-mode)
(add-hook 'javascript-mode-hook 'hl-line-mode)
(add-hook 'lisp-mode-hook 'hl-line-mode)
(add-hook 'objc-mode-hook 'hl-line-mode)
(add-hook 'python-mode-hook 'hl-line-mode)
(add-hook 'scala-mode-hook 'hl-line-mode)
(add-hook 'sgml-mode-hook 'hl-line-mode)

;; c-mode and c++-mode
;; http://www.chemie.fu-berlin.de/chemnet/use/info/cc-mode/cc-mode_6.html
(load "~/.emacs.d/modes/xcscope")
(add-hook 'c-mode-common-hook
  (lambda ()
    (c-set-style "cc-mode")
    (c-set-offset 'substatement-open 0)))

;; javascript-mode
(load "~/.emacs.d/modes/javascript-mode")
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