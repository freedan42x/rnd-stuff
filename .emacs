(require 'package)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(desktop-path (quote (".")))
 '(desktop-restore-frames t)
 '(desktop-save-mode t)
 '(dired-mode-hook (quote (dired-hide-details-mode)))
 '(fill-column 80)
 '(fringe-mode 0 nil (fringe))
 '(indicate-buffer-boundaries (quote ((t . right) (top . left))))
 '(package-archives
   (quote
    (("gnu" . "http://elpa.gnu.org/packages/")
     ("melpa-stable" . "http://stable.melpa.org/packages/")
     ("melpa" . "http://melpa.org/packages/"))))
 '(package-selected-packages
   (quote
    (haskell-emacs dired-narrow w3m intero haskell-mode)))
 '(python-shell-interpreter "python3")
 '(tool-bar-mode nil))
(package-initialize)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#232629" :foreground "#eff0f1" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 113 :width normal :foundry "PfEd" :family "Liberation Mono"))))
 '(agda2-highlight-catchall-clause-face ((t (:background "dark slate gray"))))
 '(agda2-highlight-coverage-problem-face ((t (:background "dark goldenrod"))))
 '(agda2-highlight-datatype-face ((t (:foreground "deep sky blue"))))
 '(agda2-highlight-error-face ((t (:foreground "magenta"))))
 '(agda2-highlight-field-face ((t (:foreground "green yellow"))))
 '(agda2-highlight-function-face ((t (:foreground "deep sky blue"))))
 '(agda2-highlight-inductive-constructor-face ((t (:foreground "lawn green"))))
 '(agda2-highlight-keyword-face ((t (:foreground "dark orange"))))
 '(agda2-highlight-module-face ((t (:foreground "deep pink"))))
 '(agda2-highlight-number-face ((t (:foreground "aquamarine"))))
 '(agda2-highlight-postulate-face ((t (:foreground "medium turquoise"))))
 '(agda2-highlight-primitive-face ((t (:foreground "cadet blue"))))
 '(agda2-highlight-primitive-type-face ((t (:foreground "tomato"))))
 '(agda2-highlight-reachability-problem-face ((t (:background "dark olive green"))))
 '(agda2-highlight-record-face ((t (:foreground "cyan"))))
 '(agda2-highlight-string-face ((t (:foreground "lawn green"))))
 '(agda2-highlight-termination-problem-face ((t (:background "DodgerBlue4"))))
 '(agda2-highlight-unsolved-constraint-face ((t (:background "dark goldenrod"))))
 '(agda2-highlight-unsolved-meta-face ((t (:background "dark red"))))
 '(font-lock-comment-face ((t (:foreground "light coral")))))

(load-file (let ((coding-system-for-read 'utf-8))
             (shell-command-to-string "agda-mode locate")))

(global-set-key (kbd "C-z") 'undo)

(add-hook 'python-mode-hook
      (lambda ()
        (setq indent-tabs-mode nil)
        (setq tab-width 2)
        (setq python-indent-offset 2)))

(set-face-attribute 'default nil :height 180)

(add-to-list 'default-frame-alist '(fullscreen . maximized))