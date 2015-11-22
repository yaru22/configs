;; Emacs 24 comes with Emacs Lisp Package Archive (ELPA). The following sets
;; the list of package repos.
(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                         ("marmalade" . "https://marmalade-repo.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")))

(load "~/.emacs.d/ui")
(load "~/.emacs.d/keys")
(load "~/.emacs.d/utils")
(load "~/.emacs.d/modes")
