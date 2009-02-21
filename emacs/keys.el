;; 'C-x r j e' to open ~/.emacs
(set-register ?e '(file . "~/.emacs"))

;; key bindings for the frequently used functions
(global-set-key [C-tab] 'bs-cycle-next)
(global-set-key [C-S-iso-lefttab] 'bs-cycle-previous)
(global-set-key [f2 ?h] 'hl-line-mode)
(global-set-key [f2 ?s] 'term)
(global-set-key [f2 f2] 'kill-buffer)
(global-set-key [f2 ?l] 'setnu-mode)

;; F6 sets a bookmark, F7 loads the list of bookmarks
(global-set-key [f6] 'bookmark-set)
(global-set-key [f7] 'bookmark-bmenu-list)