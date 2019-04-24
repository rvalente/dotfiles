;;; init.el --- my basic emacs setup for sane defaults

;; Copyright 2019 Ronald Valente

;; Author: Ronald Valente
;; Version: 0.1.0
;; Created: 2019-04-04

;;; Commentary:

;; The idea here is to set a minimum number of options to improve the
;; initial ergonomics of Emacs, at least for my personal usage.

;;; Code:

;; configure package repository
(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

;; install use-package if we dont have it
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; enable use-package for auto installation
(eval-when-compile
  (require 'use-package))

;; enable use-package auto-install globally
(require 'use-package-ensure)
(setq use-package-always-ensure t)

;; ensure we have system packages as well
(use-package use-package-ensure-system-package
  :ensure t)

(use-package yaml-mode)
(use-package writegood-mode)

(use-package terraform-mode
  :init
  (add-hook 'terraform-mode-hook #'terraform-format-on-save-mode))

;; markdown mode with support for markdownlint via flycheck
(use-package markdown-mode
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.md.html\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))

(use-package json-mode)
(use-package htmlize)
(use-package elpy)
(use-package base16-theme
  :init (load-theme 'base16-tomorrow-night t))

;; setup magit and forge
(use-package magit)
(use-package forge
	     :after magit)

;; use flycheck globally
(use-package flycheck
	     :init (global-flycheck-mode))

;; we need support for $PATH
(use-package exec-path-from-shell
	     :if (memq window-system '(mac ns x))
	     :config
	     (exec-path-from-shell-initialize))

(setq inhibit-startup-message t)      ;; hide the startup message
(global-linum-mode t)                 ;; enable line numbers globally
(electric-pair-mode 1)                ;; enable minor mode to insert matching delimiters
(global-auto-revert-mode t)           ;; auto-refresh with changes on disk
(setq ring-bell-function 'ignore)     ;; disable bell
(tool-bar-mode -1)                    ;; disable tool bar
(scroll-bar-mode -1)                  ;; disable scroll bar
(menu-bar-mode -1)                    ;; disable menu bar
(save-place-mode 1)                   ;; return to the last place we were in the file
(show-paren-mode t)                   ;; show matching parens
(setq make-backup-files nil)          ;; dont make backup files
(setq tab-width 2                     ;; tabs should be 2 spaces
      indent-tabs-mode nil)           ;; disable tabs
(setq column-number-mode t)           ;; display the column and line number

;; Scratch by Default, Enable org-mode
(setq initial-scratch-message nil
      initial-major-mode 'org-mode)

;; Never Save Trailing Whitespace
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Require new line at the end of every file
(setq require-final-newline t)

;;; org-mode settings
(setq org-log-done t
      org-enforce-todo-dependencies t
      org-todo-keywords '((sequence "TODO" "IN-PROGRESS" "WAITING" "|" "DONE" "CANCELED"))
      org-todo-keyword-faces '(("IN-PROGRESS" . (:foreground "blue" :weight bold))
			       ("BLOCKED" . (:foreground "red" :weight bold))))

(setq org-agenda-files '("~/org"))

(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)

(add-hook 'org-mode-hook
          (lambda ()
            (flyspell-mode)))
(add-hook 'org-mode-hook
          (lambda ()
            (writegood-mode)))

;;; Enable org-babel languages
(require 'ob)
(org-babel-do-load-languages
 'org-babel-load-languages
 '((shell . t)
   (ruby . t)
   (python . t)
   (java . t)
   (groovy . t)
   (sql . t)
   (org . t)
   (C . t)))

;;; Enable Ido Everywhere
(setq confirm-nonexistent-file-or-buffer nil)
(setq ido-create-new-buffer 'always)
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

;;; flyspell
(setq flyspell-issue-welcome-flag nil)
(if (eq system-type 'darwin)
    (setq-default ispell-program-name "/usr/local/bin/aspell")
  (setq-default ispell-program-name "/usr/bin/aspell"))
(setq-default ispell-list-command "list")

;;; conf-mode
(add-to-list 'auto-mode-alist '("\\.gitconfig$" . conf-mode))

;;; Yaml
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
(add-to-list 'auto-mode-alist '("\\.yaml$" . yaml-mode))

;;; Markdown
(add-hook 'markdown-mode-hook 'writegood-mode)

(provide 'init)

;;; init.el ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (exec-path-from-shell flycheck forge magit base16-theme elpy htmlize json-mode markdown-mode writegood-mode yaml-mode use-package-ensure-system-package use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
