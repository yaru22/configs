(exec-path-from-shell-copy-env "GOPATH")
(exec-path-from-shell-copy-env "GOBIN")
(exec-path-from-shell-copy-env "GO15VENDOREXPERIMENT")
(setq go-projectile-switch-gopath 'never)
(setq go-projectile-tools-path (getenv "GOBIN"))

(add-hook 'go-mode-hook '(lambda ()
  (local-set-key (kbd "C-c C-f") 'gofmt)))
(add-hook 'go-mode-hook '(lambda ()
  (local-set-key (kbd "C-c C-r") 'go-remove-unused-imports)))
(add-hook 'go-mode-hook '(lambda ()
  (local-set-key (kbd "C-c C-g") 'go-goto-imports)))
(add-hook 'go-mode-hook '(lambda ()
  (local-set-key (kbd "C-c C-k") 'godoc)))
(defun my-go-mode-hook ()
  (setq gofmt-command "goreturns")
  (add-hook 'before-save-hook 'gofmt-before-save)
  (if (not (string-match "go" compile-command))
      (set (make-local-variable 'compile-command)
           "go build -v && go test -v && go vet")))
(add-hook 'go-mode-hook 'my-go-mode-hook)
