;; Emacs 24 comes with Emacs Lisp Package Archive (ELPA). The following sets
;; the list of package repos.
(setq package-archives '(("ELPA" . "http://tromey.com/elpa/")
                         ("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")))

(load "~/.emacs.d/ui")
(load "~/.emacs.d/keys")
(load "~/.emacs.d/utils")
(load "~/.emacs.d/modes")

