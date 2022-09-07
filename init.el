;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
;; Tell emacs where is your personal elisp lib dir
(server-start)				;starting emacs server in oreder to connect to it if it is allready opend
(add-to-list 'load-path "~/.emacs.d/lisp/")

(load-theme 'modus-vivendi t)		;;dark theme
(set-face-attribute 'default nil :height 135) ;;set font size to heigth/10 pt


(require 'package) 

(setq pacakge-archives '(("melpa" . "https://melpa.org/packages/")
			 ("elpa" : "https://elpa.gnu.org/packages/")))

(unless package-archive-contents
  (package-refresh-contents))
(unless (package-installed-p 'use-package)
  (package-install 'use-package))


(require 'use-package)
    (use-package vertico			;fuzzy finder
      :ensure t
      :bind (:map vertico-map
		 ("C-j" . vertico-next)
		 ("C-k" . verticop-previous)
		 ("C-f" . vertico-exit)
		 :map minibuffer-local-map
		 ("M-h" . backward-kill-word))
      :custom
      (vertico-cycle t)
      :init
      (vertico-mode))

   (use-package savehist		;just saves history of visited fiels
     :init
     (savehist-mode))

   (use-package marginalia		;file infos how crated and wenn and so one 
     :after vertico
     :ensure t 
     :custom
     (marginalia-annotators '(marginalia-annotators-heavy marginalia-annotators-light nil))
     :init
     (marginalia-mode))
      




(require 'auto-complete-latex)
(setq ac-modes (append ac-modes '(foo-mode)))
(add-hook 'foo-mode-hook 'ac-l-setup)


    
;; auto-complete setup, sequence is important
(require 'auto-complete)
(add-to-list 'ac-modes 'latex-mode) ; beware of using 'LaTeX-mode instead
(require 'ac-math) ; package should be installed first 
(defun my-ac-latex-mode () ; add ac-sources for latex
   (setq ac-sources
         (append '(ac-source-math-unicode
           ac-source-math-latex
           ac-source-latex-commands)
                 ac-sources)))
(add-hook 'LaTeX-mode-hook 'my-ac-latex-mode)
(setq ac-math-unicode-in-math-p t)
(ac-flyspell-workaround) ; fixes a known bug of delay due to flyspell (if it is there)
(add-to-list 'ac-modes 'org-mode) ; auto-complete for org-mode (optional)
(require 'auto-complete-config) ; should be after add-to-list 'ac-modes and hooks
(ac-config-default)
(setq ac-auto-start nil)            ; if t starts ac at startup automatically
(setq ac-auto-show-menu t)
(global-auto-complete-mode t)



(load "tabbar-tweak")			;tabbar config for tabs like in browser
;; (package-initialize)			;some older version og emacs requer this for (require 'use-package)
(load "latex_config")	  
(load "python_config")

;; (add-to-list 'load-path			;load yasnippets
;;               "~/.emacs.d/plugins/yasnippet")
;; (require 'yasnippet)
;; (yas-global-mode 1)


(define-key global-map (kbd "C-+") 'text-scale-increase) ;; increase/decrease font size
(define-key global-map (kbd "C--") 'text-scale-decrease)


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
   '(marginalia use-package vertico yasnippet-snippets ac-math tabbar lsp-java lsp-ltex lsp-mode lsp-python-ms lsp-ui auctex zotelo zotero))
 '(tabbar-separator '(0.5))
 '(warning-suppress-log-types '((comp)))
 '(warning-suppress-types
   '((auto-save)
     (auto-save)
     (auto-save)
     (auto-save)
     (auto-save))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
