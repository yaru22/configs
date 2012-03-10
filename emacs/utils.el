;; Enable Emacs Lisp Package Archive (ELPA) for Emacs 22/23
;; (let ((buffer (url-retrieve-synchronously
;; 	       "http://tromey.com/elpa/package-install.el")))
;;   (save-excursion
;;     (set-buffer buffer)
;;     (goto-char (point-min))
;;     (re-search-forward "^$" nil 'move)
;;     (eval-region (point) (point-max))
;;     (kill-buffer (current-buffer))))

;; Add various utils to the load-path
(add-to-list 'load-path "~/.emacs.d/utils/")

;; Load useful utilities
(load "~/.emacs.d/utils/dos2unix")
(load "~/.emacs.d/utils/indent-buffer")

;; Installing yasnippet
(add-to-list 'load-path
                  "~/.emacs.d/plugins/yasnippet-0.6.1c")
    (require 'yasnippet) ;; not yasnippet-bundle
    (yas/initialize)
    (yas/load-directory "~/.emacs.d/plugins/yasnippet-0.6.1c/snippets")

;; Find file at point lets you put the point over a file name and open
;; it with C-x C-f
(ffap-bindings)

;; Occur-mode
(global-set-key (kbd "C-c C-o") 'occur)
(define-key occur-mode-map "n" 'next-error-no-select)
(define-key occur-mode-map "p" 'previous-error-no-select)

;; C-o is occur in isearch
(defun isearch-occur ()
  "Invoke 'occur' from within search."
  (interactive)
  (let ((case-fold-search isearch-case-fold-search))
    (occur (if isearch-regexp isearch-string (regexp-quote isearch-string)))))

(define-key isearch-mode-map (kbd "C-o") 'isearch-occur)

;; C-k is "kill match" in isearch
(defun kill-isearch-match ()
  "Kill the current isearch match string and continue searching."
  (interactive)
  (kill-region isearch-other-end (point)))

(define-key isearch-mode-map (kbd "C-k") 'kill-isearch-match)

;; Increment the number at point
(defun increment-number-at-point (&optional arg)
  "Increment the number forward from point by 'arg'."
  (interactive "p*")
  (save-excursion
    (save-match-data
      (let (inc-by field-width answer)
        (setq inc-by (if arg arg 1))
        (skip-chars-backward "0123456789")
        (when (re-search-forward "[0-9]+" nil t)
          (setq field-width (- (match-end 0) (match-beginning 0)))
          (setq answer (+ (string-to-number (match-string 0) 10) inc-by))
          (when (< answer 0)
            (setq answer (+ (expt 10 field-width) answer)))
          (replace-match (format (concat "%0" (int-to-string field-width) "d")
                                 answer)))))))

(global-set-key (kbd "C-c +") 'increment-number-at-point)

