;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Brian Park"
      user-mail-address "yaru22@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c g k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c g d') to jump to their definition and see how
;; they are implemented.

;;
;; OrgMode
;;

(use-package! org
  :mode (("\\.org\\'" . org-mode)
         ("\\.org_archive\\'" . org-mode)
         ("\\.org_tmpl\\'" . org-mode))
  :init
  (setq
   ;; directories
   org-directory "~/workspace/notes"
   org-roam-directory "~/workspace/notes"
   org-attach-id-dir "~/workspace/notes/data"

   ;; babel
   org-babel-load-languages '((emacs-lisp . t)
                              (dot . t)
                              (js . t)
                              (plantuml . t)
                              (python . t)
                              (sqlite . t)))

  :config
  ;; modules
  (require 'org-checklist)
  (require 'org-habit)

  ;; key bindings
  (map! :leader
        :prefix "n"
        "c" #'org-capture)
  (map! :map org-mode-map
        "M-n" #'outline-next-visible-heading
        "M-p" #'outline-previous-visible-heading)
  (setq
   ;; agenda
   org-agenda-files '("~/workspace/notes/")

   ;; babel
   org-confirm-babel-evaluate nil
   org-src-fontify-natively t
   org-src-tab-acts-natively t

   ;; capture
   org-capture-templates
   '(
     ("j" "Journal" entry
      (file+olp+datetree "~/workspace/notes/journal.org")
      (file "~/workspace/notes/templates/journal.org_tmpl")
      :jump-to-captured t :empty-lines-after 1)
     ("d" "Daily Review" entry
      (file+olp+datetree "~/workspace/notes/reviews.org" "Daily")
      (file "~/workspace/notes/templates/daily_review.org_tmpl")
      :jump-to-captured t)
     ("w" "Weekly Review" entry
      (file+olp+datetree "~/workspace/notes/reviews.org" "Weekly")
      (file "~/workspace/notes/templates/weekly_review.org_tmpl")
      :jump-to-captured t)
     ("m" "Monthly Review" entry
      (file+olp+datetree "~/workspace/notes/reviews.org" "Monthly")
      (file "~/workspace/notes/templates/monthly_review.org_tmpl")
      :jump-to-captured t)
     ("q" "Quarterly Review" entry
      (file+olp+datetree "~/workspace/notes/reviews.org" "Quarterly")
      (file "~/workspace/notes/templates/quarterly_review.org_tmpl")
      :jump-to-captured t)
     ("y" "Yearly Review" entry
      (file+olp+datetree "~/workspace/notes/reviews.org" "Yearly")
      (file "~/workspace/notes/templates/yearly_review.org_tmpl")
      :jump-to-captured t)
     )

   ;; export
   org-export-backends '(ascii beamer html icalendar latex md odt)

   ;; indentation
   org-startup-indented nil
   org-adapt-indentation t
   org-hide-leading-stars t

   ;; logging
   org-log-done 'time
   org-log-into-drawer t
   org-log-note-clock-out nil
   org-log-reschedule 'note

   ;; misc
   org-src-window-setup 'current-window

   ;; todo
   org-return-follows-link t
   org-enforce-todo-dependencies t
   org-track-ordered-property-with-tag t

   ;; notification
   org-show-notification-handler (lambda (msg)
                                   (ns-do-applescript
                                    (format "display notification \"%s\"" msg)))

   )
  )

(use-package deft
  :after org
  :custom
  (deft-recursive t)
  (deft-use-filter-string-for-filename t)
  (deft-default-extension "org")
  (deft-directory "~/workspace/notes")
  )
