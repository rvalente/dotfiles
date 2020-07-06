;;; init.el --- my basic emacs setup for sane defaults

;; Copyright 2020 Ronald Valente

;; Author: Ronald Valente
;; Version: 2.0.0
;; Created: 2019-04-04
;; Update: 2020-07-04

;;; Commentary:

;; The idea here is to set a minimum number of options to improve the
;; initial ergonomics of Emacs, at least for my personal usage.

;;; Code:

;; Migrate to straight.el to replace package.el
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;; Setup stright.el integration with use-package
(straight-use-package 'use-package)

;; Minimal UI
(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(menu-bar-mode -1)
(save-place-mode 1)                           ;; return to the last place we were in the file
(show-paren-mode t)                           ;; show matching parens
(delete-selection-mode t)                     ;; delete the selection with a keypress like every other editor
(blink-cursor-mode -1)                        ;; the blinking cursor is nothing, but an annoyance
(global-linum-mode t)                         ;; enable line numbers globally
(line-number-mode t)
(column-number-mode t)
(size-indication-mode t)
(setq inhibit-startup-message t)              ;; hide the startup message
(setq ring-bell-function 'ignore)             ;; disable the annoying bell
(setq require-final-newline t)                ;; Newline at the end of the file, always
(setq-default indent-tabs-mode nil)           ;; Use spaces instead of tabs

;; revert buffers automatically when underlying files are changed externally
(global-auto-revert-mode t)

;; Fancy titlebar for macOS
;; Removes the dark gray titlebar from macOS window
(add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
(add-to-list 'default-frame-alist '(ns-appearance . darl))
(setq ns-use-proxy-icon nil)
(setq frame-title-format nil)

(set-face-attribute 'default nil :font "Fira Code Retina-12")
(set-frame-font "Fira Code Retina-12" nil t)

;; more useful frame title
(setq frame-title-format
      '((:eval (if (buffer-file-name)
                   (abbreviate-file-name (buffer-file-name))
                 "%b"))))

;; enable y/n answers
(fset 'yes-or-no-p 'y-or-n-p)

;; Make emacs more performant
(setq gc-cons-threshold 50000000)             ;; run gc every 50mb instead of 0.7mb
(setq large-file-warning-threshold 100000000) ;; warn when opening files larger than 100MB

;; nice scrolling
(setq scroll-margin 0
      scroll-conservatively 100000
      scroll-preserve-screen-position 1)

;; Better integration with macOS shell
(use-package exec-path-from-shell
  :straight t
  :config
  (when (memq window-system '(mac ns x))
    (exec-path-from-shell-initialize)
    (exec-path-from-shell-copy-env "GOPATH")))

(use-package paren
  :config
  (show-paren-mode +1))

(use-package elec-pair
  :config
  (electric-pair-mode +1))

(use-package hl-line
  :config
  (global-hl-line-mode +1))

(use-package magit
  :straight t
  :bind (("C-x g" . magit-status)
         ("C-x M-g" . magit-dispatch)))

(use-package projectile
  :straight t
  :config
  (define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
  (projectile-mode +1))

(use-package treemacs
  :straight t
  :bind
  (:map global-map
        ("C-<f8>" . treemacs-select-window)
        ([f8]     . treemacs))
  :config
  (setq treemacs-is-never-other-window t))

(use-package treemacs-projectile
  :after treemacs projectile
  :straight t)

(use-package treemacs-magit
  :after treemacs magit
  :straight t)

;; Only trim whitespace for lines you have edited
(use-package ws-butler
  :straight t
  :config
  (ws-butler-global-mode)
  (setq ws-butler-keep-whitespace-before-point nil))

;; Enable language server protocol support
;; https://github.com/golang/tools/blob/master/gopls/doc/emacs.md
(use-package lsp-mode
  :straight t
  :commands (lsp lsp-deferred)
  :config
  (setq lsp-prefer-flymake nil)
  :hook (go-mode . lsp-deferred))

;; Set up before-save hooks to format buffer and add/delete imports.
;; Make sure you don't have other gofmt/goimports hooks enabled.
(defun lsp-go-install-save-hooks ()
  (add-hook 'before-save-hook #'lsp-format-buffer t t)
  (add-hook 'before-save-hook #'lsp-organize-imports t t))
(add-hook 'go-mode-hook #'lsp-go-install-save-hooks)

;; Optional - provides fancier overlays.
(use-package lsp-ui
  :straight t
  :commands lsp-ui-mode
  :hook (lsp-mode-hook . lsp-ui-mode)
  :config
  (setq lsp-ui-doc-enable nil
        lsp-ui-peek-enable t
        lsp-ui-sideline-enable t
        lsp-ui-imenu-enable t
        lsp-ui-flycheck-enable t
        lsp-gopls-staticcheck t
        lsp-eldoc-render-all t
        lsp-gopls-complete-unimported t)
  :init)

;; Company mode is a standard completion package that works well with lsp-mode.
(use-package company
  :straight t
  :config
  ;; Optionally enable completion-as-you-type behavior.
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 1)
  (setq company-tooltop-align-annotations t))

;; company-lsp integrates company mode completion with lsp-mode.
;; completion-at-point also works out of the box but doesn't support snippets.
(use-package company-lsp
  :straight t
  :after company
  :commands company-lsp
  :config
  (push 'company-lsp company-backends))

;; Optional - provides snippet support.
(use-package yasnippet
  :straight t
  :commands yas-minor-mode
  :hook (go-mode . yas-minor-mode))

;; Enable Golang Support
(use-package go-mode
  :straight t
  :hook ((go-mode . lsp-deferred)
         (before-save . lsp-format-buffer)
         (before-save . lsp-organize-imports)))

(use-package sql-indent
  :straight t)

;; Setup web-mode for gohtml and html
(use-package web-mode
  :straight t
  :config
  (add-to-list 'auto-mode-alist '("\\.gohtml\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
  (setq web-mode-engines-alist
        '(("go" . "\\.gohtml\\'")))
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-code-indent-offset 2))

;; Setup markdown-mode for the best markdown experience
(use-package markdown-mode
  :straight t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))

;; Setup flycheck syntax checking
(use-package flycheck
  :straight t
  :init (global-flycheck-mode))

;; Org-mode Configuration
;; Don't ask for confirmation on eval buffers
(setq org-confirm-babel-evaluate nil)

;;; init.el ends here
