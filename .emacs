(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (jedi powerline moe-theme omnisharp))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(require 'powerline)
(require 'moe-theme)
(moe-theme-set-color 'cyan)
(moe-dark)
(moe-theme-set-color 'purple)
(powerline-moe-theme)

(tool-bar-mode -1)

(set-face-attribute 'default nil :height 180)

(add-to-list 'default-frame-alist '(fullscreen . maximized))

(setq make-backup-files nil)
(setq inhibit-startup-screen t)
(setq moe-theme-highlight-buffer-id nil)
(setq moe-light-pure-white-background-in-terminal t)
(setq abbrev-file-name "~/.emacs.d/abbrev_defs")
(defun display-startup-echo-area-message () (message ""))

(global-display-line-numbers-mode)

(global-set-key (kbd "C-z") 'undo)
(global-set-key (kbd "C-x <C-up>") (lambda() (interactive)(find-file user-init-file)))
(global-set-key (kbd "C-c r") (lambda() (interactive)(load-file user-init-file)))

(add-hook 'python-mode-hook
  (lambda ()
    (setq indent-tabs-mode nil)
    (setq tab-width 2)
    (setq python-indent-offset 2)))

(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t) 
