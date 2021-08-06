
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
   org-attach-id-dir "~/workspace/notes/data"
   )
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
   org-agenda-files '(
                      "~/workspace/notes/habits.org"
                      "~/workspace/notes/projects.org"
                      "~/workspace/notes/reviews.org"
                      "~/workspace/notes/people.org"
                      )

   ;; archive
   org-archive-reversed-order t

   ;; babel
   org-confirm-babel-evaluate nil
   org-src-fontify-natively t
   org-src-tab-acts-natively t

   ;; capture
   org-capture-templates
   '(
     ("t" "Trading Journal" entry
      (file+olp+datetree "~/workspace/notes/trading_journal.org")
      (file "~/workspace/notes/templates/journal.org_tmpl")
      :empty-lines-after 1
      :jump-to-captured t)
     ("j" "Journal" entry
      (file+olp+datetree "~/workspace/notes/journal.org")
      (file "~/workspace/notes/templates/journal.org_tmpl")
      :empty-lines-after 1
      :jump-to-captured t)
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
     ("Q" "Quarterly Review" entry
      (file+olp+datetree "~/workspace/notes/reviews.org" "Quarterly")
      (file "~/workspace/notes/templates/quarterly_review.org_tmpl")
      :jump-to-captured t)
     ("y" "Yearly Review" entry
      (file+olp+datetree "~/workspace/notes/reviews.org" "Yearly")
      (file "~/workspace/notes/templates/yearly_review.org_tmpl")
      :jump-to-captured t)
     )
   org-id-link-to-org-use-id 'create-if-interactive

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
   org-log-reschedule nil

   ;; misc
   org-ellipsis " ▼"  ;; instead of showing "..." when headers are collapsed
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

(after! org
  ;; Set faces for heading levels
  (dolist (face '((org-level-1 . 1.25)
                  (org-level-2 . 1.2)
                  (org-level-3 . 1.15)
                  (org-level-4 . 1.1)
                  (org-level-5 . 1.05)
                  (org-level-6 . 1.03)
                  (org-level-7 . 1.03)
                  (org-level-8 . 1.03)))
    (set-face-attribute (car face) nil :height (cdr face)))
  )

;;
;; Org Roam
;;

(use-package! org-roam
  :custom-face
  (org-roam-link ((t (:inherit org-link :foreground "#E95533"))))

  :init
  (setq org-roam-v2-ack t)
  (map! :leader
        :prefix "n"
        :desc "org-roam" "l" #'org-roam-buffer-toggle
        :desc "org-roam-node-insert" "i" #'org-roam-node-insert
        :desc "org-roam-node-find" "f" #'org-roam-node-find
        :desc "org-roam-ref-find" "r" #'org-roam-ref-find
        :desc "org-roam-show-graph" "g" #'org-roam-show-graph
        :desc "org-roam-capture" "c" #'org-roam-capture
        :desc "org-roam-dailies-capture-today" "j" #'org-roam-dailies-capture-today)
  (setq org-roam-directory (file-truename "~/workspace/notes/")
        org-roam-db-gc-threshold most-positive-fixnum
        org-id-link-to-org-use-id t)

  :config
  (require 'org-roam-protocol)
  ;; https://www.orgroam.com/manual.html#Configuring-what-is-displayed-in-the-buffer
  (setq org-roam-mode-section-functions
        (list #'org-roam-backlinks-section
              #'org-roam-reflinks-section
              ;; #'org-roam-unlinked-references-section
              ))
  (org-roam-setup)
  (set-popup-rules!
    `((,(regexp-quote org-roam-buffer) ; persistent org-roam buffer
       :side right
       :width .33
       :height .5
       :ttl nil
       :modeline nil
       :quit nil
       :slot 1)
      ("^\\*org-roam: " ; node dedicated org-roam buffer
       :side right
       :width .33
       :height .5
       :ttl nil
       :modeline nil
       :quit nil
       :slot 2)))

  (add-hook 'org-roam-mode-hook #'turn-on-visual-line-mode)

  (setq org-roam-capture-templates
        '(("d" "default" plain
           "%?"
           :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org"
                              "#+TITLE: ${title}\n")
           :immediate-finish t
           :unnarrowed t)))

  (setq org-roam-capture-ref-templates
        '(("r" "ref" plain
           "%?"
           :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org"
                              "
#+TITLE: ${title}
#+FILETAGS: lit

* Notes

* Highlights
  * ${body}
")
           :immediate-finish t
           :jump-to-captured t
           :unnarrowed t)))
  )

;;
;; Deft
;;

(use-package! deft
  :after org
  :custom
  (deft-recursive t)
  (deft-use-filter-string-for-filename t)
  (deft-default-extension "org")
  (deft-directory "~/workspace/notes")
  )

;;
;; Ivy
;;

(use-package! ivy
  :bind (("C-s" . swiper-isearch))
  )
