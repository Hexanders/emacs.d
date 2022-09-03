;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
;; Tell emacs where is your personal elisp lib dir
(add-to-list 'load-path "~/.emacs.d/lisp/")

(load "tabbar-tweak")			;tabbar config for tabs like in browser
;; (package-initialize)			;some older version og emacs requer this for (require 'use-package)

(define-key global-map (kbd "C-+") 'text-scale-increase) ;; increase/decrease font size
(define-key global-map (kbd "C--") 'text-scale-decrease)

(load "latex_config")	  
(load "python_config") 

(setq-default ispell-program-name "aspell") ;; aspell is better as ispell but call it still ispell :) ;; commend out this line if not installed or install aspell

(setq speck-engine (quote Hunspell)) ;; spellchecker
(setq speck-hunspell-language-options
      (quote (("de" utf-8 nil t nil)
	      ("en" utf-8 nil nil nil)
	      ("ru" koi8-r nil nil nil))))


(setq inhibit-startup-message t 	;;turn off message 
      visible-bell t			;;visual  
      )

(tool-bar-mode -1)			;;remove controll bar
(scroll-bar-mode -1)			;;remove scroll bar
(global-display-line-numbers-mode 1)	;;add line numbers to the screen
(hl-line-mode 1)			;;highlight whole line
(blink-cursor-mode 1)


(load-theme 'modus-vivendi t)		;;dark theme

(set-face-attribute 'default nil :height 135) ;;set font size to heigth/10 pt


;; load  packages
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))

;; save the autosave files in a different directory altogether by setting the variable auto-save-file-name-transforms
(setq auto-save-file-name-transforms
      `((".*" ,(concat user-emacs-directory "auto-save/") t)))
;;save backup files in a different directory set the variable backup-directory-alist, the following will save backup files inside backups folder in the user-emacs-directory
(setq backup-directory-alist
      `(("." . ,(expand-file-name
                 (concat user-emacs-directory "backups")))))




(defun sudo-edit (&optional arg) ;; http://emacsredux.com/blog/2013/04/21/edit-files-as-root/
  "Edit currently visited file as root.

With a prefix ARG prompt for a file to visit.
Will also prompt for a file to visit if current
buffer is not visiting a file."
  (interactive "P")
  (if (or arg (not buffer-file-name))
      (find-file (concat "/sudo:root@localhost:"
                         (ido-read-file-name "Find file(as root): ")))
    (find-alternate-file (concat "/sudo:root@localhost:" buffer-file-name))))


;;from hier some stuff wich was added by packag-list-packag
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(tabbar lsp-java lsp-ltex lsp-mode lsp-python-ms lsp-ui auctex zotelo zotero))
 '(tabbar-separator '(0.5))
 '(warning-suppress-log-types '((comp)))
 '(warning-suppress-types '((auto-save))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
