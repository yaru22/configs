;; Add various UI modules to the load-path
(add-to-list 'load-path "~/.emacs.d/ui/")

;; Disabling Emacs splashscreen
(setq inhibit-splash-screen t)

;; Window frame title
(setq frame-title-format "emacs [%b %*% + %f]")
(setq icon-title-format "emacs [%b]")

;; Turn on/off various UI elements on Emacs window
(tool-bar-mode 0)
(line-number-mode 1)
(column-number-mode 1)
(display-time-mode 1)

;; Make "yes or no" "y or n"
(fset 'yes-or-no-p 'y-or-n-p)

;; Enabling X11 Copy & Paste to/from Emacs:
(setq x-select-enable-clipboard t)
(if (eq system-type 'gnu-linux)
    (setq interprogram-paste-function 'x-cut-buffer-or-selection-value))
(if (eq system-type 'windows-nt)
    (setq interprogram-paste-function 'x-selection-value))

;; Get a buffer menu with the right mouse button
(global-set-key [mouse-3] 'mouse-buffer-menu)

;; Highlight the current line by default
(global-hl-line-mode 1)

;; Turn on line number mode by default
(require 'linum+)
(global-linum-mode 1)

;; Turn on column marker at 80th column
(require 'column-marker)
(add-hook 'haskell-mode-hook (lambda () (interactive) (column-marker-1 80)))
(add-hook 'js-mode-hook (lambda () (interactive) (column-marker-1 80)))
