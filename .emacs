(message "* loading dotemacs")

(require 'org)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)
(add-hook 'org-mode-hook #'toggle-word-wrap)

;; OS type
(defvar ms-windows (eq system-type 'windows-nt) "MS Windows")
(defvar linux (eq system-type 'gnu/linux) "Linux")
(defvar mac-osx (eq system-type 'darwin) "OSX")

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)


;; Adding MELPA repo of packages
(add-to-list 'package-archives (cons "melpa" "https://melpa.org/packages/") t)

;; Auctex config
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)

(setq TeX-source-correlate-mode t)
(setq TeX-source-correlate-start-server t)
(server-start)

;; Set PDF viewer based on operating system
(cond
 (linux
  (message "setting Okular as PDF viewer")
  (setq TeX-view-program-selection '((output-pdf "Okular")))
  )

 (mac-osx
  ;; customizing path for LaTeX
  (setenv "PATH" (concat (getenv "PATH") ":/Library/TeX/texbin"))
  ;; customizing path for Coq
  (setenv "PATH" (concat (getenv "PATH") ":/Applications/CoqIDE_8.7.2.app/Contents/Resources/bin"))
  ;; option -b highlights the current line; option -g opens Skim in the background
  (message "setting Skim as PDF viewer")
  (setq TeX-view-program-selection '((output-pdf "Skim")))
  (setq TeX-view-program-list
	'(("Skim" "/Applications/Skim.app/Contents/SharedSupport/displayline %n %o %b")))
  )
 )

;; use reftex
(require 'reftex)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(setq reftex-plug-into-AUCTeX t)

(add-hook 'TeX-mode-hook
	  (lambda ()
	    (progn
	      (setq fill-column 80)
	      (turn-on-auto-fill)
	      (electric-indent-mode 1))))

;; configuring emacs
(message "* configuring Emacs")
(setq inhibit-splash-screen t)
(add-hook 'write-file-hooks 'delete-trailing-whitespace)
(add-to-list 'default-frame-alist '(fullscreen . maximized))
(delete-selection-mode)
(setq ring-bell-function 'ignore)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(mac-option-modifier 'meta)
 '(package-selected-packages '(auctex))
 '(safe-local-variable-values '((TeX-master . main))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
