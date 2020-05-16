(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

(load-theme 'gruber-darker t)

(tool-bar-mode 0)
(menu-bar-mode 0)
(toggle-scroll-bar -1)
(ido-mode 1)
(fringe-mode '(0 . 0))

(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)

(set-default-font "Ubuntu Mono-24")

(add-to-list 'default-frame-alist '(fullscreen . maximized))

(setq make-backup-files nil)
(setq inhibit-startup-screen t)
(setq python-indent-offset 2)
(setq haskell-stylish-on-save t)
(setq haskell-mode-stylish-haskell-path "brittany")
(setf (cdr (assq 'continuation fringe-indicator-alist))
      '(nil nil))
(defun display-startup-echo-area-message () (message ""))

(global-display-line-numbers-mode)

(load-file (let ((coding-system-for-read 'utf-8))
                (shell-command-to-string "agda-mode locate")))

(global-set-key (kbd "C-z") 'undo)
(global-set-key (kbd "C-x <C-up>") (lambda() (interactive)(find-file user-init-file)))
(global-set-key (kbd "C-c r") (lambda() (interactive)(load-file user-init-file)))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("89336ca71dae5068c165d932418a368a394848c3b8881b2f96807405d8c6b5b6" default)))
 '(package-selected-packages
   (quote
    (haskell-mode haskell-emacs gruber-darker-theme ## smex))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(font-lock-string-face ((t (:foreground "#73c936" :family "Black")))))
