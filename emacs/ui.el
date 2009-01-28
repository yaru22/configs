(tool-bar-mode 0)
(line-number-mode 1)
(column-number-mode 1)
(display-time-mode 1)

(setq x-select-enable-clipboard t)
(setq interprogram-paste-function 'x-cut-buffer-or-selection-value)

;; Window frame title
(setq frame-title-format "emacs [%b %*% + %f]")
(setq icon-title-format "emacs [%b]")

;; Get a buffer menu with the right mouse button
(global-set-key [mouse-3] 'mouse-buffer-menu)

;; Make "yes or no" "y or n"
(fset 'yes-or-no-p 'y-or-n-p)

