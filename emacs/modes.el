(add-to-list 'load-path "~/.emacs.d/modes/")

;; no tab
(setq-default tab-width 4)
(setq-default indent-tabs-mode t)

;; auto-complete modes
(load "~/.emacs.d/modes/auto-complete.el")
(load "~/.emacs.d/modes/auto-complete-haskell.el")
(load "~/.emacs.d/modes/auto-complete-yasnippet.el")

;; hl-line-mode to all the programming modes
(add-hook 'emacs-lisp-mode-hook 'hl-line-mode)
(add-hook 'c-mode-hook 'hl-line-mode)
(add-hook 'c++-mode-hook 'hl-line-mode)
(add-hook 'objc-mode-hook 'hl-line-mode)
(add-hook 'javascript-mode-hook 'hl-line-mode)
(add-hook 'python-mode-hook 'hl-line-mode)
(add-hook 'haskell-mode-hook 'hl-line-mode)
(add-hook 'lisp-mode-hook 'hl-line-mode)
(add-hook 'sgml-mode-hook 'hl-line-mode)
(add-hook 'css-mode-hook 'hl-line-mode)

;; c-mode and c++-mode
;; http://www.chemie.fu-berlin.de/chemnet/use/info/cc-mode/cc-mode_6.html
(load "~/.emacs.d/modes/xcscope")
(add-hook 'c-mode-common-hook
  (lambda ()
    (c-set-style "cc-mode")
    (c-set-offset 'substatement-open 0)))

;; css-mode
(load "~/.emacs.d/modes/css-mode")
(add-to-list 'auto-mode-alist '("\\.css$" . css-mode))

;; javascript-mode
(load "~/.emacs.d/modes/javascript-mode")
(add-to-list 'auto-mode-alist '("\\.js$" . javascript-mode))

;; haskell-mode
(load "~/.emacs.d/modes/haskell-mode/haskell-site-file")
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
(add-hook 'haskell-mode-hook 'turn-on-haskell-font-lock)

;; scala-mode
(add-to-list 'load-path "~/.emacs.d/modes/scala-mode/")
(require 'scala-mode-auto)

(setq yas/scala-dir "~/.emacs.d/modes/scala-mode/contrib/yasnippet/snippets")
(yas/load-directory yas/scala-dir)
(add-hook 'scala-mode-hook
		  '(lambda ()
			 (yas/minor-mode-on)))
