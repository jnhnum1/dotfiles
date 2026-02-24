(message "* loading dotemacs")
(select-frame-set-input-focus (selected-frame))

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)
;; Adding MELPA repo of packages
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

(which-key-mode)
(require 'org)
(global-set-key (kbd "C-c l") #'org-store-link)
(global-set-key (kbd "C-c a") #'org-agenda)
(global-set-key (kbd "C-c c") #'org-capture)
(setq org-startup-indented t)

;; OS type
(defvar ms-windows (eq system-type 'windows-nt) "MS Windows")
(defvar linux (eq system-type 'gnu/linux) "Linux")
(defvar mac-osx (eq system-type 'darwin) "OSX")

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
  ;; setting font
  (set-frame-font "Monaco-24" nil t)
  ;; customizing path for LaTeX
  (setenv "PATH" (concat (getenv "PATH") ":/Library/TeX/texbin"))
  ;; option -b highlights the current line; option -g opens Skim in the background
  (message "setting Skim as PDF viewer")
  (setq TeX-view-program-selection '((output-pdf "Skim")))
  (setq TeX-view-program-list
	'(("Skim" "/Applications/Skim.app/Contents/SharedSupport/displayline %n %o %b")))  )
 )

;; use reftex
(require 'reftex)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(setq reftex-plug-into-AUCTeX t)

(add-hook 'TeX-mode-hook
	  (lambda ()
	    (progn
	      (turn-on-auto-fill)
	      (electric-indent-mode 1))))

;; configuring emacs
(message "* configuring Emacs")
(add-hook 'write-file-hooks 'delete-trailing-whitespace)
(add-to-list 'default-frame-alist '(fullscreen . maximized))
(delete-selection-mode)
;; (setq ring-bell-function 'ignore)

(load "~/.emacs.d/emacs-custom.el")
