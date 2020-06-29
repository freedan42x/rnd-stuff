(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t))
(package-initialize)

(load-theme 'minimal-black t)

(tool-bar-mode 0)
(menu-bar-mode 0)
(toggle-scroll-bar -1)
(ido-mode 1)
(fringe-mode '(0 . 0))

(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)

(set-default-font "Fira Code 14")
(global-fira-code-mode)

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
    (fira-code-mode pretty-mode quasi-monochrome-theme haskell-mode haskell-emacs gruber-darker-theme ## smex))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(agda2-highlight-catchall-clause-face ((t (:background "gray14"))))
 '(agda2-highlight-coinductive-constructor-face ((t (:foreground "#aaffcc"))))
 '(agda2-highlight-datatype-face ((t (:foreground "snow"))))
 '(agda2-highlight-field-face ((t (:foreground "white smoke"))))
 '(agda2-highlight-function-face ((t (:foreground "white smoke" :weight extra-bold))))
 '(agda2-highlight-inductive-constructor-face ((t (:foreground "light gray"))))
 '(agda2-highlight-keyword-face ((t (:weight extra-bold))))
 '(agda2-highlight-module-face ((t (:foreground "gray"))))
 '(agda2-highlight-number-face ((t (:foreground "gainsboro"))))
 '(agda2-highlight-postulate-face ((t (:foreground "gray"))))
 '(agda2-highlight-primitive-face ((t (:foreground "#CE4045"))))
 '(agda2-highlight-primitive-type-face ((t (:foreground "light gray"))))
 '(agda2-highlight-record-face ((t (:foreground "snow"))))
 '(agda2-highlight-string-face ((t (:foreground "#aaffff"))))
 '(agda2-highlight-unsolved-meta-face ((t (:background "gray14"))))
 '(font-lock-comment-face ((t (:foreground "#75715E"))))
 '(font-lock-string-face ((t (:foreground "#73c936" :family "Black"))))
 '(highlight ((t (:background "gray14")))))
