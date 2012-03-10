;; Emacs 24 comes with Emacs Lisp Package Archive (ELPA). The following sets
;; the list of package repos.
(setq package-archives '(("ELPA" . "http://tromey.com/elpa/")
                         ("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")))

;;; This was installed by package-install.el.
;;; This provides support for the package system and
;;; interfacing with ELPA, the package archive.
;;; Move this code earlier if you want to reference
;;; packages in your .emacs.
(when
    (load
     (expand-file-name "~/.emacs.d/elpa/package.el"))
  (package-initialize))


(load "~/.emacs.d/ui")
(load "~/.emacs.d/keys")
(load "~/.emacs.d/utils")
(load "~/.emacs.d/modes")
