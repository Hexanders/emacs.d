(setq inhibit-startup-message t 	;;turn off message 
      visible-bell t			;;visual  
      )

(tool-bar-mode -1)			;;remove controll bar
(scroll-bar-mode -1)			;;remove scroll bar
(global-display-line-numbers-mode 1)	;;add line numbers to the screen
(hl-line-mode 1)			;;highlight whole line
(blink-cursor-mode 1)


(load-theme 'modus-vivendi t)		;;dark theme

(set-face-attribute 'default nil :height 120) ;;set font size to 12pt so

