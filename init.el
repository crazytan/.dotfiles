;; install packages
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)

(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents))

(defvar myPackages
  '(ace-jump-mode
    ace-window
    async
    auctex
    autopair
    better-defaults
    company
    company-auctex
    dash
    dired+
    dockerfile-mode
    epl
    exec-path-from-shell
    flycheck
    git-commit
    helm
    helm-core
    let-alist
    logito
    magit
    magit-popup
    markdown-mode
    material-theme
    pcache
    pkg-info
    popup
    powerline
    projectile
    rainbow-identifiers
    seq
    smooth-scrolling
    terraform-mode
    with-editor
    yasnippet))

(mapc #'(lambda (package)
          (unless (package-installed-p package)
            (package-install package)))
      myPackages)

;; load machine specific config file
(let ((extra-config-file
       (concat user-emacs-directory "extra.el")))
  (if (file-readable-p extra-config-file)
      (load-file extra-config-file)
    ))

;; hide toolbar
(tool-bar-mode -1)

;; hide scroll bar
(scroll-bar-mode -1)

;; map command to meta
(if (eq system-type 'darwin)
    (progn
      (setq mac-option-key-is-meta nil)
      (setq mac-command-key-is-meta t)
      (setq mac-command-modifier 'meta)
      (setq mac-option-modifier nil)))

;; line and column number
(global-linum-mode t)
(setq line-number-mode t)
(setq column-number-mode t)

;; set tab size to 4
(setq-default tab-width 4)

;; make line number appear normal regardless of font size
(set-face-attribute 'linum nil :height 120)

;; battery status
(if (eq system-type 'darwin)
    (display-battery-mode 1))

;; init window size
(add-to-list 'default-frame-alist '(height . 45))
(add-to-list 'default-frame-alist '(width . 100))

;; store all backup and autosave files in the tmp dir
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; y-or-n instead of yes-or-no
(defalias 'yes-or-no-p 'y-or-n-p)

;; show matching parenthesis
(show-paren-mode 1)

;; disable tab for indent
(setq-default indent-tabs-mode nil)

;; material theme
(load-theme 'material t)

;; ibuffer
(global-set-key (kbd "C-x C-b") 'ibuffer)

;; smooth scrolling
(require 'smooth-scrolling)
(smooth-scrolling-mode 1)

;; helm
(require 'helm)
(require 'helm-config)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to run persistent action
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB works in terminal
(define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z
(setq helm-buffers-fuzzy-matching t)
(helm-mode 1)

;; projectile
;; (projectile-global-mode)

;; company
(add-hook 'after-init-hook 'global-company-mode)

;; company-auctex
(require 'company-auctex)
(company-auctex-init)

;; disable TeX-save-query
(setq TeX-save-query nil)

;; magit
(global-set-key (kbd "C-x g") 'magit-status)
(global-set-key (kbd "C-x M-g") 'magit-dispatch-popup)

;; enable flyspell for textmode but not log mode
(dolist (hook '(text-mode-hook))
  (add-hook hook (lambda () (flyspell-mode 1))))
(dolist (hook '(change-log-mode-hook log-edit-mode-hook))
  (add-hook hook (lambda () (flyspell-mode -1))))

;; autopair
(require 'autopair)
(autopair-global-mode 1)
(setq autopair-autowrap t)

;; rainbow identifier mode
(add-hook 'prog-mode-hook 'rainbow-identifiers-mode)

;; dired+
(require 'dired+)
(setq dired-dwim-target t)

;; flycheck
(global-flycheck-mode)

;; tramp
(require 'tramp)
(setq tramp-default-method "scp")

;; ace-jump
(require 'ace-jump-mode)
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)

;; ace-window
(global-set-key (kbd "M-[") 'ace-window)
(setq aw-scope 'frame)

;; org-mode
(global-set-key "\C-ca" 'org-agenda)

;; exec-path-from-shell
(when (memq window-system '(ns x))
  (exec-path-from-shell-initialize))

;; change default bell behavior
(setq visible-bell nil)
(setq ring-bell-function
      (lambda ()
        (invert-face 'mode-line)
        (run-with-timer 0.1 nil 'invert-face 'mode-line)))

;; better mode line
(require 'powerline)
(powerline-default-theme)

;; shortcut for terminal buffer
(defun visit-term-buffer ()
  "Create or visit a terminal buffer."
  (interactive)
  (if (not (get-buffer "*ansi-term*"))
      (progn
        (ansi-term (getenv "SHELL"))
        (switch-to-buffer "*ansi-term*"))
    (switch-to-buffer "*ansi-term*")))
(global-set-key (kbd "C-c t") 'visit-term-buffer)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("84d2f9eeb3f82d619ca4bfffe5f157282f4779732f48a5ac1484d94d5ff5b279" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" default)))
 '(package-selected-packages
   (quote
    (ace-window powerline helm-tramp exec-path-from-shell ace-jump-mode dired+ smooth-scrolling rainbow-identifiers projectile pcache material-theme markdown-mode magit logito helm flycheck company-auctex better-defaults autopair))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
