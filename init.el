;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
;; Tell emacs where is your personal elisp lib dir
;; (server-start)				;starting emacs server in oreder to connect to it if it is allready opend

(add-to-list 'load-path "~/.emacs.d/lisp/")

(setq byte-compile-warnings '(cl-functions)) ;evoid "Package cl is deprecated" worning

(load-theme 'modus-vivendi t)		;;dark theme
;; (load-theme 'badwolf t)		;;dark theme
(set-face-attribute 'default nil :height 135) ;;set font size to heigth/10 pt

;; (require 'init-web-mode)
(require 'package) 

(setq pacakge-archives '(("melpa" . "https://melpa.org/packages/")
			 ("elpa" : "https://elpa.gnu.org/packages/")))

(unless package-archive-contents
  (package-refresh-contents))
(unless (package-installed-p 'use-package)
  (package-install 'use-package))


(show-paren-mode t)
(setq show-paren-style 'expression)

(require 'use-package)
    (use-package vertico			;fuzzy finder
      :ensure t
      :bind (:map vertico-map
		 ("C-j" . vertico-next)
		 ("C-k" . vertico-previous)
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

   (use-package marginalia		;file metadata how crated and wenn and so one 
     :after vertico
     :ensure t 
     :custom
     (marginalia-annotators '(marginalia-annotators-heavy marginalia-annotators-light nil))
     :init
     (marginalia-mode))
      






(load "tabbar-tweak")			;tabbar config for tabs like in browser
;; (package-initialize)			;some older version og emacs requer this for (require 'use-package)
(load "latex_config")	  
(load "python_config")

(add-to-list 'load-path			;load yasnippets
              "~/.emacs.d/plugins/yasnippet")
(require 'yasnippet)
(yas-global-mode 1)
;; redefine the Yasnippet expansion key instead in order to not interfere with outocomplete
;; https://emacs.stackexchange.com/questions/9670/yasnippet-not-working-with-auto-complete-mode
(define-key yas-minor-mode-map (kbd "<tab>") nil)
(define-key yas-minor-mode-map (kbd "TAB") nil)
(define-key yas-minor-mode-map (kbd "<C-tab>") 'yas-expand)

;; ;;; use popup menu for yas-choose-value
;; (require 'popup)

;; ;; add some shotcuts in popup menu mode
;; (define-key popup-menu-keymap (kbd "M-n") 'popup-next)
;; (define-key popup-menu-keymap (kbd "TAB") 'popup-next)
;; (define-key popup-menu-keymap (kbd "<C-tab>") 'popup-next)
;; (define-key popup-menu-keymap (kbd "<backtab>") 'popup-previous)
;; (define-key popup-menu-keymap (kbd "M-p") 'popup-previous)

(defun yas-popup-isearch-prompt (prompt choices &optional display-fn)
  (when (featurep 'popup)
    (popup-menu*
     (mapcar
      (lambda (choice)
        (popup-make-item
         (or (and display-fn (funcall display-fn choice))
             choice)
         :value choice))
      choices)
     :prompt prompt
     ;; start isearch mode immediately
     :isearch t
     )))

(setq yas-prompt-functions '(yas-popup-isearch-prompt yas-maybe-ido-prompt yas-completing-prompt yas-no-prompt))
;;;;;;;

(define-key global-map (kbd "C-+") 'text-scale-increase) ;; increase/decrease font size
(define-key global-map (kbd "C--") 'text-scale-decrease)


(setq-default ispell-program-name "aspell") ;; aspell is better as ispell but call it still ispell :) ;; commend out this line if not installed or install aspell



(defun comment-line-or-region ()
  "Comment or uncomment the current line or region."
  (interactive)
  (if (use-region-p)
      (comment-or-uncomment-region (region-beginning) (region-end))
    (save-excursion
      (comment-or-uncomment-region
       (line-beginning-position)
       (line-end-position)))))

(global-set-key (kbd "C-c ,") 'comment-line-or-region)

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
(setq display-line-numbers 'relative)  	;;relative line numbers
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



(require 'auto-complete-latex)
(setq ac-modes (append ac-modes '(foo-mode)))
(add-hook 'foo-mode-hook 'ac-l-setup)

;; use easy citation
(use-package citar
  :bind (("C-c b" . citar-insert-citation)
         :map minibuffer-local-map
         ("M-b" . citar-insert-preset))
  :custom
  (citar-bibliography '("~/Documents/DigiLab-Backup/BACKUP/PHD_theses/bibliography.bib")))

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

(ac-set-trigger-key "TAB")
(ac-set-trigger-key "<tab>")

;; Jump to next punctuation  in Text like .,;: and so on
(defvar punctuation-regex nil "A regex string for the purpose of moving cursor to a punctuation.")
;; (setq punctuation-regex "[\\!\?\"\.'#$%&*+,/:;<=>@^`|~]+")
;; (setq punctuation-regex "[\\!\?\\.,/:;]")
(setq punctuation-regex "[\\!\?\\.]") 


(defun forward-punct (&optional n)
;;   "Move cursor to the next occurrence of punctuation.
;; The list of punctuations to jump to is defined by `xah-punctuation-regex'

;; URL `http://xahlee.info/emacs/emacs/emacs_jump_to_punctuations.html'
;; Version 2017-06-26"
  (interactive "p")
  (re-search-forward punctuation-regex nil t n))

(global-set-key "\M--" 'forward-punct)

(defun backward-punct (&optional n)
;;   "Move cursor to the previous occurrence of punctuation.
;; See `forward-punct'

;; URL `http://xahlee.info/emacs/emacs/emacs_jump_to_punctuations.html'
;; Version 2017-06-26"
  (interactive "p")
  (re-search-backward punctuation-regex nil t n))
(global-set-key "\M-." 'backward-punct)

;;from hier some stuff wich was added by packag-list-packag
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(swiper helm-descbinds multiple-cursors popup undo-tree web-mode magit badwolf-theme citar marginalia use-package vertico yasnippet-snippets ac-math tabbar lsp-java lsp-ltex lsp-mode lsp-python-ms lsp-ui auctex))
 '(tabbar-separator '(0.5))
 '(warning-suppress-log-types '((comp)))
 '(warning-suppress-types
   '((auto-save)
     (auto-save)
     (auto-save)
     (auto-save)
     (auto-save)))
 '(xref-after-return-hook nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
;; ## added by OPAM user-setup for emacs / base ## 56ab50dc8996d2bb95e7856a6eddb17b ## you can edit, but keep this line
(require 'opam-user-setup "~/.emacs.d/opam-user-setup.el")
;; ## end of OPAM user-setup addition for emacs / base ## keep this line
