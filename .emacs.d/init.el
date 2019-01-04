;;; package --- summary
;;; Commentary:
(require 'package)
;;; Code:
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)
(load-theme 'base16-tomorrow-night t)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(initial-buffer-choice "~/code")
 '(package-selected-packages
   (quote
    (exec-path-from-shell flycheck terraform-mode base16-theme ansible magit go-mode)))
 '(setq custom-safe-themes t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(electric-pair-mode 1)
(exec-path-from-shell-initialize)
(global-flycheck-mode)
(provide 'init)
;;; init.el ends here
