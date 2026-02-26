;;; init.el --- Emacs configuration -*- lexical-binding: t -*-
(message "* loading init.el")
(select-frame-set-input-focus (selected-frame))

;; Package setup
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

;; Bootstrap use-package (built-in on Emacs 29+, install otherwise)
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(setq use-package-always-ensure t)

;; OS type
(defvar ms-windows (eq system-type 'windows-nt) "MS Windows")
(defvar linux (eq system-type 'gnu/linux) "Linux")
(defvar mac-osx (eq system-type 'darwin) "OSX")

;; macOS-specific settings
(when mac-osx
  (set-frame-font "Monaco-24" nil t)
  (setenv "PATH" (concat (getenv "PATH") ":/Library/TeX/texbin")))

;;; --- General editor settings ---

(add-hook 'before-save-hook #'delete-trailing-whitespace)
(add-to-list 'default-frame-alist '(fullscreen . maximized))
(delete-selection-mode)

;; Emacs server
(use-package server
  :ensure nil
  :config
  (unless (server-running-p)
    (server-start)))

;;; --- Packages ---

(use-package which-key
  :config
  (which-key-mode))

(use-package org
  :ensure nil
  :hook ((text-mode . turn-on-auto-fill)
         (org-mode . turn-on-auto-fill))
  :bind (("C-c l" . org-store-link)
         ("C-c a" . org-agenda)
         ("C-c c" . org-capture))
  :custom
  (org-startup-indented t))

(use-package org-roam
  :after org)

(use-package eat)

(use-package tex
  :ensure auctex
  :hook ((LaTeX-mode . turn-on-reftex)
         (TeX-mode . electric-indent-mode))
  :custom
  (TeX-auto-save t)
  (TeX-parse-self t)
  (TeX-source-correlate-mode t)
  (TeX-source-correlate-start-server t)
  (reftex-plug-into-AUCTeX t)
  :config
  (setq-default TeX-master nil)
  (cond
   (linux
    (message "setting Okular as PDF viewer")
    (setq TeX-view-program-selection '((output-pdf "Okular"))))
   (mac-osx
    (message "setting Skim as PDF viewer")
    (setq TeX-view-program-selection '((output-pdf "Skim")))
    (setq TeX-view-program-list
          '(("Skim" "/Applications/Skim.app/Contents/SharedSupport/displayline %n %o %b"))))))

;;; --- Custom file ---

(setq custom-file "~/.emacs.d/emacs-custom.el")
(load custom-file)

;;; init.el ends here
