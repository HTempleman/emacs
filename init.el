;; This config was pulled very heavily from one conceived by Sanchayan
;; Maity. It is an attempt to take the nice parts from Spacemacs.


(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")
(require 'package)
(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
			 ("melpa" . "https://melpa.org/packages/")))
(package-initialize)


;; Enable auto-fill-mode
(auto-fill-mode)

;; Bootstrap use-package:
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile
  (require 'use-package))


;; Always download all packages if not already downloaded.
(setq use-package-always-ensure t)

;; Specify that packages should remain up-to-date.
(use-package auto-package-update
	    :ensure t
	    :config
	    (setq auto-package-update-delte-old-versions t)
	    (setq auto-package-update-hide-results t)
	    (auto-package-update-maybe))

(use-package restart-emacs
	     :ensure t)
	     
(use-package zenburn-theme
	     :ensure t
	     :config
	     (load-theme 'zenburn t))

(use-package evil
	     :ensure t
	     :config
	     (evil-mode 1))

(use-package evil-escape
	     :ensure t
	     :config
	     (evil-escape-mode))

(use-package fzf
	    :ensure t)

(use-package neotree
  :ensure t)

(use-package magit
  :defer t)
(use-package evil-magit
  :defer t)
  

(use-package which-key
  :ensure t
  :init
  (setq which-key-separator " ⇒ ")
  (setq which-key-prefix-prefix "+")
  (setq which-key-enable-extended-define-key t)
  :config
  (which-key-mode))



(use-package general
  :ensure t
  :init
  (setq general-override-states '(insert
				  emacs
				  hybrid
				  normal
				  visual
				  motion
				  operator
				  replace))
  :config
  (general-define-key
   :states '(normal visual insert emacs)
   :prefix "SPC"
   :non-normal-prefix "M-SPC"
   "TAB" '(switch-to-prev-buffer
	   :which-key "previous-buffer")


   ;; Bindings for file search and management.
   "f" '("files")
   "ff" '(fzf :which-key "fuzzy-file-search")
   "ft" '(neotree-toggle :which-key "neotree-toggle")
   "fF" '(find-file :which-key "emacs-find-file")
   "fL" '(load-file :which-key "load-file")

   ;; Bindings for window positioning.
   "w" '("window")
   "w/" '(split-window-right :which-key "split-window-right")
   "w-" '(split-window-below :which-key "split-window-below")
   "wm" '(delete-other-windows :which-key "maximize-window")
   "wd" '(delete-window :which-key "delete-current-window")
   "wh" '(windmove-left :which-key "select-left-window")
   "wl" '(windmove-right :which-key "select-right-window")
   "wk" '(windmove-up :which-key "select-upper-window")
   "wj" '(windmove-down :which-key "select-lower-window")

   ;; Bindings for Magit
   "g" '("magit")
   "gs" '(magit-status :which-key "status")
   "gi" '(magit-init :which-key "initialize-repo")
   "gc" '(magit-commit :which-key "commit")

   ;; Toggle keybindings
   "t" '("toggle")
   "tn" '(display-line-numbers-mode :which-key "line-numbers")
   )
 


  (general-def 'normal neotree-mode-map
    "l" 'neotree-enter
    "c" 'neotree-create-node
    "d" 'neotree-delete-node
    "a" 'neotree-hidden-file-toggle
    "K" 'neotree-select-up-node
    "J" 'neotree-select-down-node
    "R" 'neotree-change-root
    "h" 'neotree-collapse-all
    )
  )


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (evil-magit zenburn-theme which-key use-package restart-emacs neotree magit general fzf evil-escape evil auto-package-update))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
