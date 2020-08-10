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

;; Start - Keep Use Package At the Top
;; Safer Way to Check Packages
;; https://glyph.twistedmatrix.com/2015/11/editor-malware.html
(require 'package)
(setq package-archives
      '(("gnu" . "https://elpa.gnu.org/packages/")
        ("melpa-stable" . "https://stable.melpa.org/packages/")
        ("melpa" . "https://melpa.org/packages/"))
      tls-checktrust t
      tls-program '("gnutls-cli --x509cafile %t -p %p %h")
      gnutls-verify-error t)

(package-initialize)

(setq use-package-always-ensure nil)

(unless (require 'use-package nil t)
  (if (not (yes-or-no-p (concat "Refresh packages, install use-package and"
                                " other packages used by init file? ")))
      (error "you need to install use-package first")
    (package-refresh-contents)
    (package-install 'use-package)
    (require 'use-package)
    (setq use-package-always-ensure t)))

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
(setq show-trailing-whitespace t)             ;; display trailing whitespace
(setq require-final-newline t)                ;; Newline at the end of the file, always
(setq-default tab-width 4
              indent-tabs-mode nil)           ;; Use spaces instead of tabs, tabs are 4 spaces
(setq initial-major-mode 'org-mode)           ;; Set scratch buffer to be org-mode


;; revert buffers automatically when underlying files are changed externally
(global-auto-revert-mode t)

;; Fancy titlebar for macOS
;; Removes the dark gray titlebar from macOS window
(add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
(add-to-list 'default-frame-alist '(ns-appearance . darl))
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

;; Better package browser
(use-package paradox
  :ensure t
  :config
  (paradox-enable))

;; Better integration with macOS shell
(use-package exec-path-from-shell
  :ensure t
  :config
  (when (memq window-system '(mac ns x))
    (exec-path-from-shell-initialize)
    (exec-path-from-shell-copy-env "GOPATH")))

;; hide minor modes to keep modeline clean
(use-package diminish
  :ensure t)

;; Install Doom Themes
(use-package doom-themes
  :ensure t
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'doom-one-light t)
  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  ;; Enable custom treemacs theme
  (setq doom-themes-treemacs-theme "doom-colors") ; use the colorful treemacs theme
  (doom-themes-treemacs-config)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))

(use-package paren
  :config
  (show-paren-mode t))

;; completion using ivy
(use-package ivy
  :ensure t
  :diminish (ivy-mode)
  :bind (("C-x b" . ivy-switch-buffer))
  :config
  (ivy-mode t)
  (setq ivy-use-virtual-buffers t)
  (setq ivy-display-style 'fancy))

;; collection of ivy enhanced versions of common emacs commands
(use-package counsel
  :ensure t
  :bind (("M-x" . counsel-M-x)))

;; Remove Odd Undo Binding
(global-unset-key (kbd "C-/"))

;; enhanced version of isearch
(use-package swiper
  :ensure t
  :bind (("C-/" . counsel-grep-or-swiper)))

;; menu for ivy
(use-package ivy-hydra
  :ensure t)

;; ansible support
(use-package ansible
  :ensure t
  :init
  (add-hook 'yaml-mode-hook '(lambda () (ansible 1))))

;; smart parens for better matching paren workflow
(use-package smartparens
  :ensure t
  :diminish smartparens-mode
  :config
  (progn
    (require 'smartparens-config)
    (smartparens-global-mode 1)
    (show-paren-mode t)))

(use-package expand-region
  :ensure t
  :bind ("M-m" . er/expand-region))

(use-package which-key
  :ensure t
  :diminish which-key-mode
  :config
  (which-key-mode +1)
  (add-hook 'after-init-hook 'which-key-mode))

(use-package elec-pair
  :config
  (electric-pair-mode t))

(use-package hl-line
  :config
  (global-hl-line-mode t))

(use-package magit
  :ensure t
  :bind (("C-x g" . magit-status)
         ("C-x M-g" . magit-dispatch)))

(use-package projectile
  :ensure t
  :config
  (define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
  (setq projectile-project-search-path '("~/code/"))
  (projectile-mode +1))

(use-package treemacs
  :ensure t
  :bind
  (:map global-map
        ("C-<f8>" . treemacs-select-window)
        ([f8]     . treemacs))
  :config
  (setq treemacs-is-never-other-window t))

(use-package treemacs-projectile
  :after treemacs projectile
  :ensure t)

(use-package treemacs-magit
  :after treemacs magit
  :ensure t)

;; Setup whitespace cleanup
(add-hook 'before-save-hook 'whitespace-cleanup)

;; Have a much more intelligent deletion of whitespace before words
(use-package smart-hungry-delete
  :ensure t
  :bind (("<backspace>" . smart-hungry-delete-backward-char)
                 ("C-d" . smart-hungry-delete-forward-char))
  :defer nil ;; dont defer so we can add our functions to hooks
  :config (smart-hungry-delete-add-default-hooks)
  )

;; Docker support
(use-package dockerfile-mode
  :ensure t
  :mode  (("\\Dockerfile\\'" . dockerfile-mode)))

;; Enable YAML Support
(use-package yaml-mode
  :ensure t
  :mode (("\\.yml\\'" . yaml-mode)
         ("\\.yaml\\'" . yaml-mode)))

;; Create a dedicated backup directory
(setq
 backup-directory-alist '(("." . "~/.emacs.d/backups"))
 delete-old-versions -1
 version-control t
 vc-make-backup-files t
 backup-by-copying t)

;; Enable language server protocol support
;; https://github.com/golang/tools/blob/master/gopls/doc/emacs.md
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
        lsp-ui-flycheck-enable t
        lsp-gopls-staticcheck t
        lsp-eldoc-render-all t
        lsp-gopls-complete-unimported t)
  :init
  (add-hook 'after-init-hook #'global-company-mode))

;; Company mode is a standard completion package that works well with lsp-mode.
(use-package company
  :ensure t
  :config
  ;; Optionally enable completion-as-you-type behavior.
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 1)
  (setq company-tooltop-align-annotations t))

;; company-lsp integrates company mode completion with lsp-mode.
;; completion-at-point also works out of the box but doesn't support snippets.
(use-package company-lsp
  :ensure t
  :after company
  :commands company-lsp
  :config
  (push 'company-lsp company-backends))

;; Optional - provides snippet support.
(use-package yasnippet
  :ensure t
  :commands yas-minor-mode
  :hook (go-mode . yas-minor-mode))

;; Enable Golang Support
(use-package go-mode
  :ensure t
  :hook ((go-mode . lsp-deferred)
         (before-save . lsp-format-buffer)
         (before-save . lsp-organize-imports)))

(use-package sql-indent
  :ensure t)

;; Setup web-mode for gohtml and html
(use-package web-mode
  :ensure t
  :config
  (add-to-list 'auto-mode-alist '("\\.gohtml\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.xml?\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
  (setq web-mode-engines-alist
        '(("go" . "\\.gohtml\\'")))
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-code-indent-offset 2))

;; Ensure that you install all-the-icons font
;; M-x all-the-icons-install-fonts
(use-package all-the-icons
  :ensure t)

;; Better modeline using doom-modeline
(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1))

;; fzf is a fuzzy file finder which is very quick.
(use-package fzf
  :ensure t)

(use-package rainbow-mode
  :ensure t
  :config
  (setq rainbow-x-colors nil)
  (add-hook 'prog-mode-hook 'rainbow-mode))

;; rg support
(use-package deadgrep
  :ensure t)

;; Support going to the last change in the buffer
(use-package goto-last-change
  :ensure t
  :bind (("C-;" . goto-last-change)))

;; use and enable writegood-mode
(use-package writegood-mode
  :ensure t
  :config
  (add-hook 'markdown-mode-hook 'writegood-mode))

;; Setup markdown-mode for the best markdown experience
(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))

;; Setup flycheck syntax checking
(use-package flycheck
  :ensure t
  :init (global-flycheck-mode)
  :config
  (add-hook 'after-init-hook 'global-flycheck-mode)
  (setq-default flycheck-highlighting-mode 'lines)
  ;; Define fringe indicator / warning levels
    (define-fringe-bitmap 'flycheck-fringe-bitmap-ball
      (vector #b00000000
              #b00000000
              #b00000000
              #b00000000
              #b00000000
              #b00000000
              #b00000000
              #b00011100
              #b00111110
              #b00111110
              #b00111110
              #b00011100
              #b00000000
              #b00000000
              #b00000000
              #b00000000
              #b00000000))
    (flycheck-define-error-level 'error
      :severity 2
      :overlay-category 'flycheck-error-overlay
      :fringe-bitmap 'flycheck-fringe-bitmap-ball
      :fringe-face 'flycplHeck-fringe-error)
    (flycheck-define-error-level 'warning
      :severity 1
      :overlay-category 'flycheck-warning-overlay
      :fringe-bitmap 'flycheck-fringe-bitmap-ball
      :fringe-face 'flycheck-fringe-warning)
    (flycheck-define-error-level 'info
      :severity 0
      :overlay-category 'flycheck-info-overlay
      :fringe-bitmap 'flycheck-fringe-bitmap-ball
      :fringe-face 'flycheck-fringe-info))

;; Setup Tabs for Window
(use-package centaur-tabs
  :ensure t
  :demand
  :config
  (centaur-tabs-mode t)
  (setq centaur-tabs-style "bar")
  :bind
  ("C-<prior>" . centaur-tabs-backward)
  ("C-<next>" . centaur-tabs-forward))

;; Org-mode Configuration
(require 'org)
(setq org-catch-invisible-edits 'error)
(setq org-return-follows-link t)
(setq org-src-preserve-indentation t)
(setq org-src-fontify-natively t)
(setq org-src-tab-acts-natively t)
(setq org-ellipsis " ▼")
(setq org-cycle-separator-lines 1)

;; Don't ask for confirmation on eval buffers
(setq org-confirm-babel-evaluate nil)

;; Support org-capture
(define-key global-map "\C-cc" 'org-capture)

;; All org mode files live in $HOME/org
(setq org-directory "~/org")
(setq org-agenda-files '("~/org/"))

(setq custom-file (concat user-emacs-directory "/custom.el"))
;;; init.el ends here
