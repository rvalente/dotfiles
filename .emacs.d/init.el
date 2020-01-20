;;; init.el --- my basic emacs setup for sane defaults

;; Copyright 2019 Ronald Valente

;; Author: Ronald Valente
;; Version: 1.1.0
;; Created: 2019-04-04

;;; Commentary:

;; The idea here is to set a minimum number of options to improve the
;; initial ergonomics of Emacs, at least for my personal usage.

;;; Code:

;; Minimal UI
(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(menu-bar-mode -1)
(save-place-mode 1)                           ;; return to the last place we were in the file
(show-paren-mode t)                           ;; show matching parens
(delete-selection-mode t)                     ;; delete the selection with a keypress like every other editor
(blink-cursor-mode -1)                        ;; the blinking cursor is nothing, but an annoyance

(setq inhibit-startup-message t)              ;; hide the startup message
(setq make-backup-files nil)                  ;; dont make backup files
(setq column-number-mode t)                   ;; display the column and line number

;; Make emacs more performant
(setq gc-cons-threshold 50000000)             ;; run gc every 50mb instead of 0.7mb
(setq large-file-warning-threshold 100000000) ;; warn when opening files larger than 100MB

;; Disable annoyinb bell and startup screen
(setq ring-bell-function 'ignore)             ;; disable the annoying bell
(setq inhibit-startup-screen t)               ;; disable startup screen

;; nice scrolling
(setq scroll-margin 0
      scroll-conservatively 100000
      scroll-preserve-screen-position 1)

;; mode line settings
(global-linum-mode t) ;; enable line numbers globally
(line-number-mode t)
(column-number-mode t)
(size-indication-mode t)

;; enable y/n answers
(fset 'yes-or-no-p 'y-or-n-p)

;; more useful frame title
(setq frame-title-format
      '((:eval (if (buffer-file-name)
		   (abbreviate-file-name (buffer-file-name))
		 "%b"))))

(setq-default indent-tabs-mode nil)   ;; don't use tabs to indent
(setq-default tab-width 8)            ;; but maintain correct appearance
(setq require-final-newline t)        ;; Newline at the end of the file, always

;; revert buffers automatically when underlying files are changed externally
(global-auto-revert-mode t)

;; Ensure we're using UTF-8 always
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)

;; configure package repository
(require 'package)
(setq package-enable-at-startup nil)
(setq package-archives '(("org" . "http://orgmode.org/elpa/")
			 ("gnu" . "http://elpa.gnu.org/packages/")
			 ("melpa" . "https://melpa.org/packages/")))
(package-initialize)

;; install use-package if we dont have it
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)

;; Evil mode
(use-package evil
  :ensure t
  :config
  (evil-mode 1))

(use-package paren
  :config
  (show-paren-mode +1))

(use-package elec-pair
  :config
  (electric-pair-mode +1))

(use-package hl-line
  :config
  (global-hl-line-mode +1))

;; Better integration with macOS shell
(use-package exec-path-from-shell
  :ensure t
  :config
  (when (memq window-system '(mac ns x))
    (exec-path-from-shell-initialize)
    (exec-path-from-shell-copy-env "GOPATH")))

;; Enable magit
(use-package magit
  :ensure t
  :bind (("C-x g" . magit-status)))

;; Support Extra Github Functions
(use-package forge
  :ensure t
  :after magit)

;; Proper Theme
(use-package doom-themes
  :ensure t
  :config
  (load-theme 'doom-nord-light t)
  (doom-themes-org-config))

;; optional, provides snippets for method signature completion
(use-package yasnippet
  :ensure t
  :commands yas-minor-mode
  :hook (go-mode . yas-minor-mode))

;; Enable language server protocol support
(use-package lsp-mode
  :ensure t
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
  :ensure t
  :commands lsp-ui-mode
  :hook (lsp-mode-hook . lsp-ui-mode)
  :config
  (setq lsp-ui-doc-enable nil
        lsp-ui-peek-enable t
        lsp-ui-sideline-enable t
        lsp-ui-imenu-enable t
        lsp-ui-flycheck-enable t)
  :init)

;; Company mode is a standard completion package that works well with lsp-mode.
(use-package company
  :ensure t
  :config
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 1)
  (setq company-tooltop-align-annotations t))

;; optional package to get the error squiggles as you edit
(use-package flycheck
  :ensure t)

;; company-lsp integrates company mode completion with lsp-mode.
;; completion-at-point also works out of the box but doesn't support snippets.
(use-package company-lsp
  :ensure t
  :after company
  :commands company-lsp
  :config
  (push 'company-lsp company-backends))

;; Enable Golang Support
(use-package go-mode
  :ensure t
  :bind (
         ;; If you want to switch existing go-mode bindings to use lsp-mode/gopls instead
         ;; uncomment the following lines
         ;; ("C-c C-j" . lsp-find-definition)
         ;; ("C-c C-d" . lsp-describe-thing-at-point)
         )
  :hook ((go-mode . lsp-deferred)
         (before-save . lsp-format-buffer)
         (before-save . lsp-organize-imports)))
  
;; Fancy titlebar for macOS
(add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
(add-to-list 'default-frame-alist '(ns-appearance . darl))
(setq ns-use-proxy-icon nil)
(setq frame-title-format nil)

(provide 'init)

;;; init.el ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (lsp-mode doom-themes evil exec-path-from-shell ))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
