(add-to-list 'load-path "~/.emacs.d/modes/")

;; javascript-mode
(load "~/.emacs.d/modes/javascript-mode")
(add-to-list 'auto-mode-alist '("\\.js$" . javascript-mode))

;; haskell-mode
(load "~/.emacs.d/modes/haskell-mode/haskell-site-file")
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
(add-hook 'haskell-mode-hook 'turn-on-haskell-font-lock)
