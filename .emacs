;; hide emacs warning for enter key
;; (global-set-key (kbd "<key-4660>") 'ignore)

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

;; themes
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["black" "#d55e00" "#009e73" "#f8ec59" "#0072b2" "#cc79a7" "#56b4e9" "white"])
 '(column-number-mode t)
 '(custom-enabled-themes (quote (monokai)))
 '(custom-safe-themes
   (quote
    ("0d3fb10835e185b4b350b1bd902ca452e795b9e9fc7f6e8a5eebb9d146f9beff" default)))
 '(display-battery-mode t)
 '(safe-local-variable-values (quote ((TeX-master . t))))
 '(tool-bar-mode nil))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; battery status
(if (eq system-type 'darwin)
    (display-battery-mode 1))

;; init window size
(add-to-list 'default-frame-alist '(height . 45))
(add-to-list 'default-frame-alist '(width . 100))

;; ido mode
(require 'ido)
(ido-mode t)
(ido-everywhere 1)
(setq ido-enable-flex-matching t)
(if (eq system-type 'darwin)
    (setq ido-save-directory-list-file "/Users/tan/ido.last"))
(if (eq system-type 'gnu/linux)
    (setq ido-save-directory-list-file "/home/tan/.emacs.d/ido.last"))

;; ido-ubiquitous
(if (eq system-type 'darwin)
    (add-to-list 'load-path "/Users/tan/.emacs.d/elpa/ido-ubiquitous-20151005.2131"))
(require 'ido-ubiquitous)
(ido-ubiquitous-mode t)


;; MELPA
(require 'package)
;; (add-to-list 'package-archives
;; 	     '("marmalade" . "http://marmalade-repo.org/packages/") t)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)

;; store all backup and autosave files in the tmp dir
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; y-or-n instead of yes-or-no
(defalias 'yes-or-no-p 'y-or-n-p)

;; smex
;; (require 'smex)
;; (smex-initialize)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
;; This is your old M-x.
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;; uniquify
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

;; openwith
(if (eq system-type 'darwin)
    (add-to-list 'load-path "/Users/tan/.emacs.d/elpa/openwith-20120531.1436"))
(if (eq system-type 'gnu/linux)
    (add-to-list 'load-path "/home/tan/.emacs.d/elpa/openwith-20120531.1436"))
(require 'openwith)
(setq openwith-associations
      (list
      '("\\.pdf\\'" "open" (file))
      '("\\.ppt\\'" "open" (file))
      '("\\.pptx\\'" "open" (file))
      '("\\.doc\\'" "open" (file))
      '("\\.docx\\'" "open" (file))      
      ))
(openwith-mode t)

;; add texbin to PATH and exec-path
(if (eq system-type 'darwin)
    (progn
      (setenv "PATH" (concat (getenv "PATH") ":/Library/TeX/texbin"))
      (setq exec-path (append exec-path '("/Library/TeX/texbin")))))

;; add ispell to PATH and exec-path
(if (eq system-type 'darwin)
    (progn
      (setenv "PATH" (concat (getenv "PATH") ":/usr/local/bin"))
      (setq exec-path (append exec-path '("/usr/local/bin")))))

;; configs from better-defaults
(show-paren-mode 1)
(setq-default indent-tabs-mode nil)

(global-set-key (kbd "M-/") 'hippie-expand)
(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key (kbd "M-z") 'zap-up-to-char)

(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)
(global-set-key (kbd "C-M-s") 'isearch-forward)
(global-set-key (kbd "C-M-r") 'isearch-backward)

(setq x-select-enable-clipboard t
      x-select-enable-primary t
      save-interprogram-paste-before-kill t
      apropos-do-all t
      mouse-yank-at-point t
      require-final-newline t
      load-prefer-newer t
      ediff-window-setup-function 'ediff-setup-windows-plain)

;; autosave before compiling LaTeX files
(setq TeX-save-query nil)

;; auto newline and hungry delete for cc-mode
(add-hook 'c-mode-common-hook
          (lambda () (c-toggle-auto-hungry-state 1)))

;; autopair
(if (eq system-type 'darwin)
    (add-to-list 'load-path "/Users/tan/.emacs.d/elpa/autopair-20140825.427"))
(if (eq system-type 'gnu/linux)
    (add-to-list 'load-path "/home/tan/.emacs.d/elpa/autopair-20140825.427"))
(require 'autopair)
(autopair-global-mode 1)
(setq autopair-autowrap t)

;; cc-mode style
(setq-default c-basic-offset 4 c-default-style "linux")

;; move between windows
(global-set-key (kbd "M-]") 'other-window)
(global-set-key (kbd "M-[") 'prev-window)

(defun prev-window ()
  (interactive)
  (other-window -1))

;; company mode
(if (eq system-type 'darwin)
    (add-to-list 'load-path "/Users/tan/.emacs.d/elpa/company-20151103.230"))
(if (eq system-type 'gnu/linux)
    (add-to-list 'load-path "/home/tan/.emacs.d/elpa/company-20151023.1754"))
(require 'company)
(add-hook 'after-init-hook 'global-company-mode)
(if (eq system-type 'darwin)
    (setq company-backends (delete 'company-semantic company-backends)))

;; add company-complete to c-mode-base-map
(require 'cc-mode)
(define-key c-mode-base-map [(tab)] 'company-complete)
(define-key c-mode-base-map (kbd "RET") 'newline-and-indent)

;; magit command
(global-set-key (kbd "C-x g") 'magit-status)

;; tramp
(setq tramp-default-method "ssh")

;; company for AUCTEX
;; (add-to-list 'load-path "/Users/tan/.emacs.d/elpa/company-auctex-20150620.1421")
;; (require 'company-auctex)
;; (company-auctex-init)

;; ido-highlight-mode
(add-to-list 'load-path "/Users/tan/.emacs.d/elpa/idle-highlight-mode-20120920.948")
(require 'idle-highlight-mode)
(defun highlight-mode-hook ()
  (make-local-variable 'column-number-mode)
  (column-number-mode t)
  (if window-system (hl-line-mode t))
  (idle-highlight-mode t))
(add-hook 'prog-mode-hook 'highlight-mode-hook)
