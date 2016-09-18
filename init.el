;; install packages
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)

(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents))

(defvar myPackages
  '(async
    auctex
    autopair
    better-defaults
    company
    company-auctex
    dash
    dired+
    epl
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
    projectile
    rainbow-identifiers
    seq
    smooth-scrolling
    with-editor
    yasnippet))

(mapc #'(lambda (package)
          (unless (package-installed-p package)
            (package-install package)))
      myPackages)

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

;; add texbin to PATH and exec-path
(if (eq system-type 'darwin)
    (progn
      (setenv "PATH" (concat (getenv "PATH") ":/Library/TeX/texbin"))
      (setq exec-path (append exec-path '("/Library/TeX/texbin")))))

;; add /usr/local/bin to PATH and exec-path
(if (eq system-type 'darwin)
    (progn
      (setenv "PATH" (concat (getenv "PATH") ":/usr/local/bin"))
      (setq exec-path (append exec-path '("/usr/local/bin")))))

;; show matching parenthesis
(show-paren-mode 1)

;; disable tab for indent
(setq-default indent-tabs-mode nil)

;; move between windows
(global-set-key (kbd "M-]") 'other-window)
(global-set-key (kbd "M-[") 'prev-window)

(defun prev-window ()
  (interactive)
  (other-window -1))

;; tramp
(setq tramp-default-method "ssh")

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

;; aspell on Windows
(if (eq system-type 'windows-nt)
    (progn
      (add-to-list 'exec-path "c:/Program Files (x86)/Aspell/bin/")
      (setq ispell-program-name "aspell")
      (setq ispell-personal-dictionary "c:/Users/Tan/Documents/aspell6-en/")
      (require 'ispell)
      (add-hook 'LaTeX-mode-hook 'flyspell-mode)))

;; directly enable flyspell for LaTeX-mode on OS X
(if (eq system-type 'darwin)
    (progn
      (add-hook 'LaTeX-mode-hook 'flyspell-mode)))

;; magit
(global-set-key (kbd "C-x g") 'magit-status)
(global-set-key (kbd "C-x M-g") 'magit-dispatch-popup)

;; flyspell for Markdown
(add-hook 'Markdown-mode-hook 'flyspell-mode)

;; autopair
(require 'autopair)
(autopair-global-mode 1)
(setq autopair-autowrap t)

;; rainbow identifier mode
(add-hook 'prog-mode-hook 'rainbow-identifiers-mode)

;; dired+
(require 'dired+)
(setq dired-dwim-target t)

;; tramp
(require 'tramp)
(setq tramp-default-method "ssh")

;; flycheck
(global-flycheck-mode)

;; tramp
(require 'tramp)
(setq tramp-default-method "ssh")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (dired+ smooth-scrolling rainbow-identifiers projectile pcache material-theme markdown-mode magit logito helm flycheck company-auctex better-defaults autopair))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
