;;; Convert DOS file format to Unix

;; look at 
;; M-x comint-strip-ctrl-m
;;   Command: Strip trailing `^M' characters from the current output group.


;; from: elf@ee.ryerson.ca (Luis Fernandes)
;; 22 May 1997

;;; Usage: M-x dos2unix
;;;
(defun dos2unix ()
  "Convert this entire buffer from MS-DOS text file format to UNIX."
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (replace-regexp "\r$" "" nil)
    (goto-char (1- (point-max)))
    (if (looking-at "\C-z")
        (delete-char 1)))
  (set-buffer-file-coding-system 'unix))
