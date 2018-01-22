(require 'package)

(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))

;;---------------------------------------------------------------
;; use-package
;;---------------------------------------------------------------
(setq package-enable-at-startup nil)
(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
	(python-mode htmlize org-capture flycheck-rtags company-rtags helm-rtags rtags company flycheck irony jbeans-theme jbeans helm markdown-mode use-package evil-visual-mark-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

;;---------------------------------------------------------------
;; evil-mode
;;---------------------------------------------------------------
(use-package evil
  :ensure t
  :init
  (setq evil-want-C-u-scroll t)
  :config
  (evil-mode t))

;;---------------------------------------------------------------
;; jellybeans theme
;;---------------------------------------------------------------
(use-package jbeans-theme
  :ensure t
  :config
  (load-theme 'jbeans t))

;;---------------------------------------------------------------
;; helm 
;;---------------------------------------------------------------
(use-package helm
  :ensure t
  :init
  (global-set-key (kbd "M-x") #'helm-M-x)
  (global-set-key (kbd "C-x r b") #'helm-filtered-bookmarks)
  (global-set-key (kbd "C-x C-f") #'helm-find-files)
  :config
  (helm-mode 1))

(use-package python-mode
  :ensure t)
(use-package markdown-mode
  :ensure t)
(use-package flycheck
  :ensure t)
(use-package company
  :ensure t)
(use-package rtags
  :ensure t)
(use-package helm-rtags
  :ensure t)
(use-package company-rtags
  :ensure t)
(use-package flycheck-rtags
  :ensure t)
;;---------------------------------------------------------------
;; org mode
;;---------------------------------------------------------------
(use-package org
  :ensure t)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)
(setq org-agenda-files (list "~/org/test.org"))

;; C-c c for capture
(define-key global-map "\C-cc" 'org-capture)
;; Force UTF-8
(setq org-export-coding-system 'utf-8)
;; notes file
(setq org-default-notes-file (concat org-directory "~/org/notes.org"))

;;---------------------------------------------------------------
;; tabs
;;---------------------------------------------------------------
(setq-default tab-width 4)

;; Used this as a guide for c/c++ niceties in emacs
;; https://vxlabs.com/2016/04/11/step-by-step-guide-to-c-navigation-and-completion-with-emacs-and-the-clang-based-rtags/

;;---------------------------------------------------------------
;; rtags
;;---------------------------------------------------------------
;; rtags only checking
(defun setup-flycheck-rtags ()
  (interactive)
  (flycheck-select-checker 'rtags)
  ;; RTags creates more accurate overlays.
  (setq-local flycheck-highlighting-mode nil)
  (setq-local flycheck-check-syntax-automatically nil))

;; only run this if rtags is installed
(when (require 'rtags nil :noerror)
  (define-key c-mode-base-map (kbd "M-.")
    (function rtags-find-symbol-at-point))
  (define-key c-mode-base-map (kbd "M-,")
    (function rtags-find-references-at-point))
  ;; install standard rtags keybindings. Do M-. on the symbol below to
  ;; jump to definition and see the keybindings.
  (rtags-enable-standard-keybindings)
  ;; comment this out if you don't have or don't use helm
  (setq rtags-use-helm t)
  ;; company completion setup
  (setq rtags-autostart-diagnostics t)
  (rtags-diagnostics)
  (setq rtags-completions-enabled t)
  (push 'company-rtags company-backends)
  (global-company-mode)
  (define-key c-mode-base-map (kbd "<C-tab>") (function company-complete))
  ;; use rtags flycheck mode -- clang warnings shown inline
  (require 'flycheck-rtags)
  ;; c-mode-common-hook is also called by c++-mode
  (add-hook 'c-mode-common-hook #'setup-flycheck-rtags))
