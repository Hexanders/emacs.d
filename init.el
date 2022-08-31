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

;;from hier some stuff wich was added by packag-list-packag

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(auctex zotelo zotero))
 '(warning-suppress-log-types '((comp))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
