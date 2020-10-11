;;; init.el --- my basic emacs setup for sane defaults

;; Time-stamp: <2020-10-10 12:36:59 rovalent>
;; Copyright 2020 Ronald Valente

;;; Commentary:

;; The idea here is to set a minimum number of options to improve the
;; initial ergonomics of Emacs, at least in my opinion for my usage.

;;; Code:

;; Always load newest byte code
(setq load-prefer-newer t)

;; reduce the frequency of garbage collection by making it happen on
;; each 50MB of allocated data (the default is on every 0.76MB)
(setq gc-cons-threshold 50000000)

;; warn when opening files bigger than 100MB
(setq large-file-warning-threshold 100000000)

;; Minimal UI right at startup
(scroll-bar-mode -1)                          ;; don't display scroll bar
(tool-bar-mode -1)                            ;; disable toolbar
(tooltip-mode -1)                             ;; disable tooltips
(menu-bar-mode -1)                            ;; disable menu bar
(setq inhibit-startup-message t)              ;; hide the startup message
(setq use-dialog-box nil)                     ;; ensure everything stays in the minibuffer
(setq-default cursor-type 'bar)               ;; use a bar instead of box

;; set initial and default frame size for emacs to be half the screen
(if (display-graphic-p)
    (progn
      (setq initial-frame-alist
	    '((tool-bar-lines . 0)
	      (width . 142) ; chars
	      (height . 73) ; lines
	      (left . 0)
	      (top . 0)))
      (setq default-frame-alist
	    '((tool-bar-lines . 0)
	      (width . 142)
	      (height . 73)
	      (left . 0)
	      (top . 0))))
  (progn
    (setq initial-frame-alist '((tool-bar-lines . 0)))
    (setq default-frame-alist '((tool-bar-lines . 0)))))

;; Setup package, use-package, and repositories
(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("melpa-stable" . "https://stable.melpa.org/packages/")
			 ("org" . "https://orgmode.org/elpa/")
			 ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)

;; Enable auto-update of packages
(use-package auto-package-update
  :ensure t
  :config
  (setq auto-package-update-delete-old-versions t)
  (setq auto-package-update-hide-results t)
  (auto-package-update-maybe))

;; Update environment from shell on macOS
(use-package exec-path-from-shell
  :if (memq window-system '(mac ns x))
  :ensure t
  :config
  (exec-path-from-shell-initialize))

;; Start Server
(ignore-errors (server-start))

;; Additional UI Changes and Themes
(use-package all-the-icons
  :ensure t)

(use-package doom-themes
  :ensure t
  :config
  (load-theme 'doom-one t)
  (doom-themes-visual-bell-config)
  (doom-themes-treemacs-config)
  (doom-themes-org-config))

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1))

;; Write backup files to own directory
(setq backup-directory-alist
      `(("." . ,(expand-file-name
                 (concat user-emacs-directory "backups")))))

;; Make backups of files, even when they're in version control
(setq vc-make-backup-files t    ; backup even if files are under version control
      backup-by-copying t       ; don't clobber symlinks
      delete-old-versions -1    ; don't remove any backups
      version-control t         ; enforce numeric backup versions
      )

;; Sane defaults
(setq echo-keystrokes 0.1)                    ;; Show keystrokes asap
(setq initial-scratch-message nil)            ;; Clean scratch buffer
(setq initial-major-mode 'org-mode)           ;; Set scratch buffer to be org-mode

(save-place-mode 1)                           ;; return to the last place we were in the file
(show-paren-mode t)                           ;; show matching parens
(electric-pair-mode)                          ;; insert a matching paren
(size-indication-mode t)                      ;; display the size of the buffer
(global-hl-line-mode t)                       ;; highlight the current line we're on
(global-auto-revert-mode t)                   ;; automatically revert buffer if changes are made outside of emacs
(blink-cursor-mode -1)                        ;; no need to blink the cursor

(column-number-mode)                          ;; track columns as well
(global-display-line-numbers-mode)            ;; Use the new native line number mode

(setq-default indent-tabs-mode nil)           ;; don't use tabs to indent
(setq-default tab-width 8)                    ;; but maintain correct appearance
(setq show-trailing-whitespace t)             ;; display trailing whitespace
(setq require-final-newline t)                ;; Newline at the end of the file, always
(delete-selection-mode t)                     ;; delete the selection with a keypress like every other editor

;; fancy title bar
(when (memq window-system '(mac ns))
  (add-to-list 'default-frame-alist '(ns-appearance . dark)) ; nil for dark text
  (add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
  (setq ns-use-proxy-icon nil))

;; improve scrolling on macOS
(setq mouse-wheel-scroll-amount (quote (0.01)))
(setq mouse-wheel-progressive-speed nil)

;; setup font with better retina support
(set-face-attribute 'default nil :font "Fira Code Retina 14")
(set-frame-font "Fira Code Retina 14")

;; Configure ~escape~ to exit out of a command sequence.
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; Remove odd undo binding, and prepare it for search with swiper
(global-unset-key (kbd "C-/"))

;; write to "Time-stamp: <>" as long as it is within the first 8 lines of the file
(add-hook 'before-save-hook 'time-stamp)

;; always remove trailing whitespace
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; enable y/n answers
(fset 'yes-or-no-p 'y-or-n-p)

;; remove the whole line when Ctrl-K is pressed, instead of emptying it
(setq kill-whole-line t)

;; start find-file at your home directory
(setq default-directory "~/")

(use-package ivy
  :ensure t
  :bind ("C-x b" . ivy-switch-buffer)
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  (setq ivy-display-style 'fancy))

;; collection of ivy enhanced versions of common emacs commands
(use-package counsel
  :ensure t
  :bind (("M-x" . counsel-M-x)))

;; enhanced version of isearch
(use-package swiper
  :ensure t
  :bind (("C-/" . counsel-grep-or-swiper)))

;; the best git support ever
(use-package magit
  :ensure t
  :bind (("C-x g" . magit-status)
         ("C-x M-g" . magit-dispatch)))

(use-package projectile
  :ensure t
  :diminish projectile-mode
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :config
  (projectile-mode +1)
  (setq projectile-project-search-path '("~/code/")))

(use-package treemacs
  :ensure t
  :after doom-themes
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

;; summary screen on open
(use-package dashboard
  :ensure t
  :init
  (setq dashboard-show-shortcuts    t
        dashboard-set-heading-icons t
        dashboard-set-file-icons    t
        dashboard-set-init-info     t
        dashboard-set-footer        nil)
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-items '((recents   . 10)
                          (agenda    . 5)
                          (projects  . 10))))

;; Enable go-mode
(use-package go-mode
  :ensure t
  :mode ("\\.go\\'" . go-mode))

;; Set up before-save hooks to format buffer and add/delete imports.
;; Make sure you don't have other gofmt/goimports hooks enabled.
(defun lsp-go-install-save-hooks ()
  (add-hook 'before-save-hook #'lsp-format-buffer t t)
  (add-hook 'before-save-hook #'lsp-organize-imports t t))
(add-hook 'go-mode-hook #'lsp-go-install-save-hooks)

;; Setup flycheck for syntax checking
(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))

;; company, the best auto completion support around
(use-package company
  :ensure t
  :hook (prog-mode . company-mode))

;; LSP mode for all the things
(use-package lsp-mode
  :ensure t
  :commands (lsp lsp-deferred)
  :hook ((go-mode . lsp-deferred)
         (lsp-mode . lsp-enable-which-key-integration))
  :config (progn
	    (setq lsp-auto-guess-root t)
	    (setq lsp-prefer-flymake nil))
  (lsp-register-custom-settings '(("gopls.completeUnimported" t t)
                                  ("gopls.staticcheck" t t))))

;; Set up before-save hooks to format buffer and add/delete imports.
;; Make sure you don't have other gofmt/goimports hooks enabled.
(defun lsp-go-install-save-hooks ()
  (add-hook 'before-save-hook #'lsp-format-buffer t t)
  (add-hook 'before-save-hook #'lsp-organize-imports t t))
(add-hook 'go-mode-hook #'lsp-go-install-save-hooks)

(use-package lsp-ui
  :ensure t
  :commands lsp-ui-mode
  :custom
  (lsp-ui-doc-delay 0.75)
  (lsp-ui-doc-max-height 200)
  :after lsp-mode)

(use-package lsp-ivy
  :ensure t
  :after (ivy lsp-mode))

(use-package company-lsp
  :ensure t
  :custom (company-lsp-enable-snippet t)
  :after (company lsp-mode))

;; Optional - provides snippet support.
(use-package yasnippet
  :ensure t
  :commands yas-minor-mode
  :hook (go-mode . yas-minor-mode))

(setq lsp-ui-doc-enable nil
      lsp-ui-peek-enable t
      lsp-ui-sideline-enable t
      lsp-ui-imenu-enable t
      lsp-ui-flycheck-enable t)

;; org mode configuration
(use-package org
  :ensure t
  :pin org
  :config
  (setq org-confirm-babel-evaluate nil)             ; don't prompt to run src blocks
  (setq org-src-fontify-natively t)                 ; syntax hilighting for src blocks
  (setq org-log-done t)                             ; default log time when todo is completed
  (setq org-ellipsis " ▼")                          ; fancy collapse of blocks
  (setq org-directory "~/Documents/org")            ; default org directory for files
  (setq org-startup-folded nil)                     ; by default display everything
  (setq org-default-notes-file (concat org-directory "notes.org"))
  (setq org-agenda-files '("~/Documents/org/")))    ; pull in agenda files

;; UTF-8 bullets for org mode
(use-package org-bullets
  :ensure t
  :hook (org-mode . org-bullets-mode))

;; org language support
(org-babel-do-load-languages
 'org-babel-load-languages
 '((C          . t)
   (sql        . t)
   (shell      . t)
   (sqlite     . t)
   (emacs-lisp . nil)))

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

;; Setup markdown-mode for the best markdown experience
(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))

(use-package yaml-mode
  :ensure t
  :mode (("\\.yml\\'" . yaml-mode)
         ("\\.yaml\\'" . yaml-mode)))

(use-package sql-indent
  :ensure t)

(use-package sql
  :after sql-indent
  :ensure t)

(use-package which-key
  :ensure t
  :config
  (which-key-mode))

;; even better paren detail for nested parens
(use-package rainbow-delimiters
  :ensure t
  :hook ((prog-mode . rainbow-delimiters-mode)))

;; keep init.el clean
(setq custom-file (concat user-emacs-directory "custom.el"))
(load custom-file 'noerror)

;;; init.el ends here
