;;; javascript-mode.el --- major mode for editing JavaScript code

;; Copyright (C) 1997-2001 Steven Champeon
;;               2002-2004 Ville Skyttä

;; Author:     1997 Steven Champeon <schampeo@hesketh.com>
;; Maintainer: Ville Skyttä <scop@xemacs.org>
;; Keywords:   languages javascript

;; Modified by Mihai Bazon <mihai.bazon@gmail.com>:
;;
;;   - fixed indentation (to match my taste :-p)
;;   - highlight literal regexps
;;   - removed stuff I don't need (like js-shell support). :-p

;; The original file (but not this version) is part of XEmacs.

;; XEmacs is free software; you can redistribute it and/or modify it
;; under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; XEmacs is distributed in the hope that it will be useful, but
;; WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with XEmacs; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 59 Temple Place - Suite 330,
;; Boston, MA 02111-1307, USA.

;; Synched up with: not in GNU Emacs.

;;; Commentary:

;; javascript-mode was originally derived from java-cust.el
;; (by Jonathan Payne) by Steven Champeon. It has been modified
;; a lot afterwards by Ville Skyttä.

;; Contributors:
;;   Sreng Truong      (bug fix for 21.1)
;;   Sebastian Delmont (fix for prototype function indentation problems)
;;   Stefan Schlee     (GNU Emacs compatibility fixes)
;;   Igor Rayak        (ditto)

;; TODO:
;; - Multiple font-lock/highlight levels.
;; - Investigate if Semantic Bovinator should be used.
;; - Check syntax-table stuff.

;;; Code:

(require 'cc-mode)
(require 'comint)

(eval-when-compile
  (require 'regexp-opt)
  (require 'font-lock)
  (require 'speedbar)
  )

;; ------------------------------------------------------------------------ ;;

(defconst javascript-mode-version "1.9" "Version of `javascript-mode'.")

;; ------------------------------------------------------------------------ ;;

(defgroup javascript nil
  "Major mode for editing JavaScript code."
  :tag "JavaScript"
  :group 'languages
  :prefix "javascript-")

(defcustom javascript-mode-hook nil
  "Hook for customizing `javascript-mode'."
  :group 'javascript
  :type 'hook)

;; ------------------------------------------------------------------------ ;;

(defvar javascript-mode-abbrev-table nil
  "Abbrev table in use in `javascript-mode' buffers.")
(define-abbrev-table 'javascript-mode-abbrev-table ())

;; ------------------------------------------------------------------------ ;;

(defvar javascript-mode-map (c-make-inherited-keymap)
  "Keymap used in `javascript-mode' buffers.")

(defvar javascript-menu nil)
(easy-menu-define javascript-menu javascript-mode-map
                  "JavaScript Mode Commands" (c-mode-menu "JavaScript"))

;; ------------------------------------------------------------------------ ;;

;; Reserved words in JavaScript.
(defconst javascript-reserved-words
  (eval-when-compile
    (regexp-opt
     '(
       "abstract"
       "boolean"
       "break"
       "byte"
       "case"
       "catch"
       "char"
       "class"
       "const"
       "continue"
       "debugger"
       "default"
       "delete"
       "do"
       "double"
       "else"
       "enum"
       "export"
       "extends"
       "false"
       "final"
       "finally"
       "float"
       "for"
       "function"
       "goto"
       "if"
       "implements"
       "import"
       "in"
       "instanceof"
       "int"
       "interface"
       "long"
       "native"
       "new"
       "null"
       "package"
       "private"
       "protected"
       "public"
       "return"
       "short"
       "static"
       "super"
       "switch"
       "synchronized"
       "this"
       "throw"
       "throws"
       "transient"
       "true"
       "try"
       "typeof"
       "var"
       "void"
       "volatile"
       "while"
       "with"
       ) t))
  "Expression for matching reserved words in `javascript-mode' buffers.

From Core JavaScript Reference 1.5, Appendix A (Reserved Words):
<http://developer.netscape.com/docs/manuals/js/core/jsref15/keywords.html>")

(defconst javascript-builtin-words
  (eval-when-compile
    (regexp-opt
     '(
       "Array"
       "Date"
       "Function"
       "Infinity"
       "Math"
       "NaN"
       "Number"
       "Object"
       "Packages"
       "RegExp"
       "String"
       "decodeURI"
       "decodeURIComponent"
       "encodeURI"
       "encodeURIComponent"
       "eval"
       "isFinite"
       "isNaN"
       "parseFloat"
       "parseInt"
       "undefined"
       "window"
       "document"
       ) t))
  "Built-in JavaScript keywords")


;; JavaScript identifiers
;; This one is intentionally not too strict...
(defconst javascript-identifier
  "[a-zA-Z_\\$][a-zA-Z0-9_\\$]*"
  "Expression for matching identifiers in `javascript-mode' buffers.

From Core JavaScript Guide 1.5, Chapter 2 (Values, Variables and Literals):
<http://developer.netscape.com/docs/manuals/js/core/jsguide15/ident.html>")

;; ------------------------------------------------------------------------ ;;

;; Font lock keywords

(defconst javascript-function-re
  (concat "\\(^\\|[ \t;{]\\)function[ \t]+\\("
          javascript-identifier
          "\\)"))

(defconst javascript-prototype-function-re
  (concat "\\(^\\|[ \t;{]\\)"
          "\\("
          javascript-identifier
          "\\(\\."
          javascript-identifier
          "\\)*"
          "\\)"
          "[ \t]*[=:][ \t\n]*function"))

(defconst javascript-variable-re
  (concat "\\(^\\|[ \t;{(]\\)\\(const\\|var\\)[ \t]+\\("
          javascript-identifier
          "\\)"))

;; (defconst jsavascript-basic-type-re
;;   (regexp-opt '("boolean" "byte" "char" "double" "float" "int" "long"
;;                 "short" "void") 'words)
;;   "Regular expression matching any predefined type in JavaScript.")

;; (defconst javascript-constant-re
;;   (regexp-opt '("false" "null" "true") 'words)
;;   "Regular expression matching any future reserved words in JavaScript.")

(defconst javascript-font-lock-keywords
  (list

   ;; Reserved words.
   (cons (concat
          "\\(^\\|[ \t;{(]\\)\\("
          javascript-reserved-words
          "\\)[ \t\n(){};,]")
         '(2 'font-lock-keyword-face))

   ;;    (cons (concat
   ;;           "\\<\\("
   ;;           javascript-reserved-words
   ;;           "\\)\\>")
   ;;          '(1 'font-lock-keyword-face))

   ;; literal regexps
   (cons "[[({,;=+*.-][[:blank:]]*\\(/.*?/\\w*\\)[[:blank:]]*[[:punct:]]"
         '(1 font-lock-string-face))

   (cons (concat
          "\\<\\("
          javascript-builtin-words
          "\\)\\>")
         '(1 'font-lock-builtin-face))

   ;; Function declarations.
   (cons javascript-function-re '(2 'font-lock-function-name-face))

   ;; This would catch both declarations and calls.
   (cons (concat
          "\\(^\\|[ \t.;{(]\\)\\("
          javascript-identifier
          "\\)[ \t]*(")
         '(2 'font-lock-function-name-face))

   ;; Prototype functions
   (cons javascript-prototype-function-re '(2 'font-lock-function-name-face))

   ;; Variables and constants.
   (cons javascript-variable-re '(3 'font-lock-variable-name-face))

   ;; This would catch more of them and properties as well.
   (cons (concat
          "\\(^\\|[ \t(\\[\\.{;]\\)\\("
          javascript-identifier
          "\\)[ \t]*[^(]")
         '(2 'font-lock-variable-name-face))

   )
  "Highlighting rules for `javascript-mode' buffers.")

;; ------------------------------------------------------------------------ ;;

(defvar javascript-imenu-generic-expression
  `((nil ,javascript-function-re 2)
    ;; ("Variables" ,javascript-variable-re 3)
    (nil ,javascript-prototype-function-re 2)
    )
  "Imenu generic expression for JavaScript mode.
See `imenu-generic-expression'.")

;; ------------------------------------------------------------------------ ;;



;;;###autoload
(defun javascript-mode ()
  "Major mode for editing JavaScript code.

See the documentation for `c++-mode': JavaScript mode is an extension of it.
Use the hook `javascript-mode-hook' to execute custom code when entering
JavaScript mode.

\\{javascript-mode-map}"
  (interactive)

  (let ((current-c++-mode-hook (and (boundp 'c++-mode-hook) c++-mode-hook)))

    ;; Temporarily disable the c++-mode hook; don't wanna run
    ;; it when loading up c++-mode.
    (setq c++-mode-hook nil)
    (c++-mode)

    ;; Do our stuff.
    (setq major-mode 'javascript-mode mode-name "JavaScript")
    (use-local-map javascript-mode-map)
    (setq local-abbrev-table javascript-mode-abbrev-table)
    (c-set-offset 'inher-cont '+)

    ;; Change menu name.  Kudos to Geert Ribbers and Igor Rayak.
    (easy-menu-remove '("C++"))
    (easy-menu-add javascript-menu)

    ;; GNU Emacs reportedly needs this for font locking to work properly.
    (unless (featurep 'xemacs)
      (set (make-local-variable 'font-lock-defaults)
           '(javascript-font-lock-keywords nil nil)))

    ;; cc-mode does not handle JavaScript prototype function declarations well.
    ;; Thanks to Sebastian Delmont.
    ;;    (set (make-local-variable 'c-lambda-key) "function")
    ;;    (c-set-offset 'inlambda 0)
    ;; XXX: what was that for?  c-lambda-key doesn't exist :-(

    ;; imenu support.
    (set (make-local-variable 'imenu-generic-expression)
         javascript-imenu-generic-expression)





    ;; <DWIM> indentation <mihai.bazon@gmail.com>

    (defun js-lineup-arglist (langelem)
      ;; the "DWIM" in c-mode doesn't Do What I Mean in JS.
      ;; see doc of c-lineup-arglist for why I redefined this
      (save-excursion
        (let ((indent-pos (point)))
          ;; Normal case.  Indent to the token after the arglist open paren.
          (goto-char (c-langelem-2nd-pos c-syntactic-element))
          (if (and c-special-brace-lists
                   (c-looking-at-special-brace-list))
              ;; Skip a special brace list opener like "({".
              (progn (c-forward-token-2)
                     (forward-char))
            (forward-char))
          (let ((arglist-content-start (point)))
            (c-forward-syntactic-ws)
            (when (< (point) indent-pos)
              (goto-char arglist-content-start)
              (skip-chars-forward " \t"))
            (vector (current-column))))))

    (c-set-offset 'arglist-close '(c-lineup-close-paren))
    (c-set-offset 'arglist-cont 0)
    (c-set-offset 'arglist-cont-nonempty '(js-lineup-arglist))
    (c-set-offset 'arglist-intro '+)

    (setq c-special-indent-hook nil)

    (defconst js-re-function-start
      (concat "function\\(\\s +" javascript-identifier "\\)?\\s *?([^)]*)")
      "Matches the beginning of a JavaScript function definition;
      it can include a function name (identifier) or not.  It
      goes upto but not including the opening bracket.")

    (defconst js-re-string
      "\\(\"\\(\\\\.\\|[^\"\\\\]\\)*\"\\|'\\(\\\\.\\|[^'\\\\]\\)*'\\)"
      "Matches a JavaScript string literal including quotes")

    (defun point-at-indentation ()
      "Return the position at the line indentation (i.e. the
first non-whitespace character in the line)"
      (save-excursion
        (back-to-indentation)
        (point)))

    ;; As far as I can see, cc-mode indentation engine fails for
    ;; JavaScript in one of the following situations:
    ;;
    ;;   - anonymous function passed as an argument
    ;;   - literal object passed as an argument
    ;;   - literal array passed as an argument (this almost works in fact)
    ;;
    ;; + of course, any variant that involves nesting the above.
    ;;
    ;; The idea of our fix is to provide an "advice" to
    ;; c-guess-basic-syntax (see "Advising Functions" in the Elisp
    ;; manual).  This function will determine if we are in one of the
    ;; situations described above and return proper description of the
    ;; case, that is:
    ;;
    ;; 1.  function()
    ;;     |{                                  'defun-open
    ;; 1.1       |                             'defun-block-intro
    ;;
    ;; 2.  function() {
    ;;     |                                   'defun-block-intro
    ;;
    ;; 3.  function() {
    ;;         ...
    ;;     |}                                  'defun-close
    ;;
    ;; 4.  var a = { or [
    ;;             |                           'arglist-intro
    ;;
    ;; 5.  var a = { or [
    ;;         ...
    ;;         |                               'arglist-cont
    ;;
    ;; 6.  var a = { or [ foo
    ;;               |                         'arglist-cont-nonempty
    ;;
    ;; 7.  var a = { or [
    ;;         ...
    ;;     |}                                  'arglist-close
    ;;
    ;; Indentation will therefore work, based on the assumption that
    ;; the first line of such block is indented correctly.

    (defadvice c-guess-basic-syntax (after c-guess-basic-syntax-JS activate)
      (save-excursion
        (let* ((ps (save-excursion (parse-partial-sexp (point-min) (point-at-bol))))
               (orig-point (point))
               (ret)
               (a) (b) (p)              ; temporary veriables here and there
               (last (nth 1 ps)))

          (beginning-of-line)

          ;; first off, let's check if we're in situation 1.
          (unless ret
            (save-excursion
              (when (and (looking-at "[ \t\n]*{")
                         (looking-back (concat js-re-function-start "[ \t\n]*")))
                (goto-char (match-beginning 0))
                (setq ret `((defun-open ,(point-at-indentation)))))))

          ;; 1.1 or 2?
          (unless ret
            (save-excursion
              (when (and (looking-back "{[ \t\n]*")
                         (progn (setq a (match-beginning 0))
                                (goto-char a)
                                (looking-back (concat js-re-function-start "[ \t\n]*"))))
                (setq b (match-beginning 0))
                (when (= (line-number-at-pos a) (line-number-at-pos b))
                  (setq a (point-at-indentation)))
                (setq ret `((defun-block-intro ,a))))))

          ;; 3?
          (unless (or ret (not last))
            (save-excursion
              (when (looking-at "\\s *}")
                (goto-char last)
                (when (and (looking-at "{")
                           (progn (setq a (match-beginning 0))
                                  (goto-char a)
                                  (looking-back (concat js-re-function-start "[ \t\n]*"))))
                  (setq b (match-beginning 0))
                  (when (= (line-number-at-pos a) (line-number-at-pos b))
                    (setq a (point-at-indentation)))
                  (setq ret `((defun-close ,a)))))))

          ;; 4?
          (unless ret
            (save-excursion
              (when (and (looking-back "[{[]\\s *\n\\s *")
                         (not (assoc 'case-label ad-return-value)) ; sometimes CC mode gets it right
                         (not (assoc 'statement-block-intro ad-return-value))) ; again
                (goto-char (match-beginning 0))
                (setq ret `((arglist-intro ,(point-at-indentation)))))))

          ;; 6?
          (unless (or ret (not last))
            (save-excursion
              (goto-char last)
              (when (looking-at (concat "{\\s *\\(" js-re-string "\\|" javascript-identifier "\\)\\s *:"))
                (setq p (match-beginning 0))
                (setq a (match-beginning 1))
                (setq b (point-at-indentation))
                (goto-char orig-point)
                (back-to-indentation)
                (if (looking-at "\\s *}")
                    (setq ret `((arglist-close ,b ,p)))
                  (setq ret `((arglist-cont-nonempty ,b ,p)))))))

          ;; 5?
          (unless (or ret (not last))
            (save-excursion
              (goto-char last)
              (when (looking-at (concat "{[ \t\n]*\\(" js-re-string "\\|" javascript-identifier "\\)\\s *:"))
                (setq a (point-at-indentation))
                (goto-char orig-point)
                (beginning-of-line)
                (if (looking-at "\\s *}")
                    (setq ret `((arglist-close ,a ,last)))
                  (goto-char (+ last 1))
                  (skip-chars-forward " \t\n")
                  (if (= (line-number-at-pos) (line-number-at-pos orig-point))
                      (setq ret `((arglist-intro ,a)))
                    (setq ret `((arglist-cont ,(point)))))))))

          ;; 7?
          (unless (or ret (not last))
            (save-excursion
              (when (and (looking-at "\\s *\\]")
                         (progn (goto-char last)
                                (looking-at "\\[")))
                (setq ret `((arglist-close ,(point-at-indentation) ,(point)))))))

          (when ret
            (setq ad-return-value ret)))))

    ;; </DWIM>

    ;; Restore the original c++-mode-hook.
    (setq c++-mode-hook current-c++-mode-hook)

    (run-hooks 'javascript-mode-hook)))

;; ------------------------------------------------------------------------ ;;

;;;###autoload(add-to-list 'auto-mode-alist '("\\.js$" . javascript-mode))

;; Speedbar handling
(if (fboundp 'speedbar-add-supported-extension)
    (speedbar-add-supported-extension '(".js")))

;; ------------------------------------------------------------------------ ;;

(provide 'javascript-mode)

;;; javascript-mode.el ends here
