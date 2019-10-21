;; This config was pulled very heavily from one conceived by Sanchayan
;; Maity. It is an attempt to take the nice parts from Spacemacs.


(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")
(require 'package)
(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
			 ("melpa" . "https://melpa.org/packages/")))
(package-initialize)


;; Enable auto-fill-mode
(setq-default auto-fill-function 'do-auto-fill)

;; Global Settings
(show-paren-mode 1)
(electric-pair-mode)
;; Get rid of cruft.
(menu-bar-mode -1)
(tool-bar-mode -1)
(toggle-scroll-bar -1)
(set-face-attribute 'default nil :height 130)


;; Set sudo shorcut
(setenv "sudo" "/sudo::")

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
	     :init
	     (setq evil-want-C-u-scroll t)
	     :config
	     (evil-mode 1)
	     )

(use-package rust-mode
  :ensure t
  :init)

(use-package evil-escape
	     :ensure t
	     :config
	     (evil-escape-mode))

(use-package js2-mode
  :ensure t)


(use-package typescript-mode
  :ensure t)

(use-package scad-mode
  :ensure t)

(use-package fzf
	    :ensure t)


(use-package async
  :ensure t)

(use-package helm
  :ensure t
  :init
  :config
  (helm-mode 1))

(use-package helm-rg
  :ensure t)

(use-package projectile
  :ensure t
  :init
  (setq projectile-require-project-root nil)
  :config
  (projectile-mode 1))

(use-package helm-projectile
  :ensure t
  :init
  (setq helm-projectile-fuzzy-match t)
  :config
  (helm-projectile-on))


(use-package all-the-icons
  :load-path "~/.emacs.d/git-packages/all-the-icons.el")


(use-package treemacs
  :ensure t
  :defer t
  :init
  (with-eval-after-load 'winum
    (define-key winum-keymap (kbd "M-0") #'treemacs-select-window))
  :config
  (progn
    (setq treemacs-collapse-dirs                 (if treemacs-python-executable 3 0)
          treemacs-deferred-git-apply-delay      0.5
          treemacs-display-in-side-window        t
          treemacs-eldoc-display                 t
          treemacs-file-event-delay              5000
          treemacs-file-follow-delay             0.2
          treemacs-follow-after-init             t
          treemacs-git-command-pipe              ""
          treemacs-goto-tag-strategy             'refetch-index
          treemacs-indentation                   2
          treemacs-indentation-string            " "
          treemacs-is-never-other-window         nil
          treemacs-max-git-entries               5000
          treemacs-missing-project-action        'ask
          treemacs-no-png-images                 nil
          treemacs-no-delete-other-windows       t
          treemacs-project-follow-cleanup        nil
          treemacs-persist-file                  (expand-file-name ".cache/treemacs-persist" user-emacs-directory)
          treemacs-position                      'left
          treemacs-recenter-distance             0.1
          treemacs-recenter-after-file-follow    nil
          treemacs-recenter-after-tag-follow     nil
          treemacs-recenter-after-project-jump   'always
          treemacs-recenter-after-project-expand 'on-distance
          treemacs-show-cursor                   nil
          treemacs-show-hidden-files             t
          treemacs-silent-filewatch              nil
          treemacs-silent-refresh                nil
          treemacs-sorting                       'alphabetic-desc
          treemacs-space-between-root-nodes      t
          treemacs-tag-follow-cleanup            t
          treemacs-tag-follow-delay              1.5
          treemacs-width                         35)

    ;; The default width and height of the icons is 22 pixels. If you are
    ;; using a Hi-DPI display, uncomment this to double the icon size.
    ;;(treemacs-resize-icons 44)

    (treemacs-follow-mode t)
    (treemacs-filewatch-mode t)
    (treemacs-fringe-indicator-mode t)
    (pcase (cons (not (null (executable-find "git")))
                 (not (null treemacs-python-executable)))
      (`(t . t)
       (treemacs-git-mode 'deferred))
      (`(t . _)
       (treemacs-git-mode 'simple))))
  :bind
  (:map global-map
        ("M-0"       . treemacs-select-window)
        ("C-x t 1"   . treemacs-delete-other-windows)
        ("C-x t t"   . treemacs)
        ("C-x t B"   . treemacs-bookmark)
        ("C-x t C-t" . treemacs-find-file)
        ("C-x t M-t" . treemacs-find-tag)))

(use-package treemacs-evil
  :after treemacs evil
  :ensure t)
(use-package treemacs-projectile
  :after treemacs projectile
  :ensure t)

(use-package treemacs-icons-dired
  :after treemacs dired
  :ensure t
  :config (treemacs-icons-dired-mode))

(use-package treemacs-magit
  :after treemacs magit
  :ensure t)

(use-package buffer-move
  :ensure t
  )

(use-package magit
  :defer t)
(use-package evil-magit
  :defer t)


(use-package flycheck
  :ensure t
  :config
  (add-hook 'typescript-mode-hook 'flycheck-mode))

;; Settings for React w/ Typescript
;; Greatly helped along by a config from one daniel-vu.

(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-h1-identifier-mode +1)
  (company-mode +1))

(use-package company
  :ensure t
  :config
  (setq company-show-numbers t)
  (setq company-toolkit-align-annotations t)
  (setq company-tooltip-flip-when-above t)
  (global-company-mode))

(use-package company-quickhelp
  :ensure t
  :init
  (company-quickhelp-mode 1)
  (use-package pos-tip
    :ensure t))


(use-package web-mode
  :ensure t
  :mode (("\\.html?\\'" . web-mode))
  :config
  (setq web-mode-markup-indent-offset 2
	web-mode-css-indent-offset 2
	web-mode-code-indent-offset 2
	web-mode-block-padding 2
	web-mode-comment-style 2

	web-mode-enable-css-colorization t
	web-mode-enable-auto-pairing t
	web-mode-enable-comment-keywords t
	web-mode-enable-current-element-highlight t
	)
  (flycheck-add-mode 'typescript-tslint 'web-mode))


(use-package rjsx-mode
  :ensure t
  :mode (("\\.tsx\\'" . rjsx-mode))
  :config
  (setq js-indent-level 2)
  (add-hook 'rjsx-mode-hook
	    (lambda ()
	      (when (string-equal "tsx" (file-name-extension buffer-file-name))
		(setup-tide-mode))))
  (flycheck-add-mode 'typescript-tslint 'rjsx-mode))

(use-package typescript-mode
  :ensure t
  :config
  (setq typescript-indent-level 2)
  (add-hook 'typescript-mode #'subword-mode))


(use-package tide
  :init
  :ensure t
  :after (typescript-mode company flycheck)
  :hook ((typescript-mode . tide-setup)
	 (typescript-mode . tid-h1-identifier-mode)
	 (before-save . tide-format-before-save)))
		   

;; Settings for which-key (Spacemacse emulation)

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
  :config
  (general-override-mode)
  (general-define-key
   :states '(normal treemacs)
   :keymaps 'override
   :prefix "SPC"
   :non-normal-prefix "SPC"


   "/" '(helm-projectile-rg
	 :which-key "ripgrep")

   ;; Bindings for projectile featurs.
   "p" '("projectile")
   "pf" '(helm-projectile-find-file-dwim-other-window
	  :which-key "find-files")
   "pp" '(helm-projectile-switch-project
	  :which-key "switch-project")

   ;; Bindings for file search and management.
   "f" '("files")
   "ff" '(helm-find-files :which-key "helm-file-search")
   "ft" '(treemacs :which-key "treemacs")
   "fF" '(find-file :which-key "emacs-find-file")
   "fL" '(load-file :which-key "load-file")
   "fa" '(treemacs-add-project-to-workspace :which-key "treemacs-add-project")
   "fw" '(treemacs-switch-workspace :which-key "treemacs-switch-workspace")
   "fC" '(treemacs-edit-workspaces :which-key "edit-workspace-config")


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
   "wH" '(buf-move-left :which-key "move-window-left")
   "wL" '(buf-move-right :which-key "move-window-right")
   "wK" '(buf-move-up :which-key "move-window-up")
   "wJ" '(buf-move-down :which-key "move-window-down")

   ;; Bindings for Magit
   "g" '("magit")
   "gs" '(magit-status :which-key "status")
   "gi" '(magit-init :which-key "initialize-repo")
   "gc" '(magit-commit :which-key "commit")
   "gC" '(magit-clone-regular :which-key "clone-regular")

   ;; Toggle keybindings
   "t" '("toggle")
   "tn" '(display-line-numbers-mode :which-key "line-numbers")
   "ta" '(auto-fill-mode :which-key "auto-fill")

   ;; Shell Keybindings
   "s" '("shell")
   "si" '(ansi-term :which-key "ansi-term")
   "ss" '(find-file "/sudo::" :which-key "sudo")

   ;; Buffer Keybindings
   "b" '("buffer")
   "bm" '(buffer-menu :which-key "list-buffers")
   )


 


  (general-def 'normal neotree-mode-map
    "l" 'neotree-enter
    "c" 'neotree-create-node
    "d" 'neotree-delete-node
    "a" 'neotree-hidden-file-toggle
    "K" 'neotree-select-up-node
    "J" 'neotree-select-down-node
    "R" 'neotree-change-root
    "r" 'neotree-rename-node
    "h" 'neotree-collapse-all
    "R" 'neotree-change-root
    )

  (general-def 'normal helm-map
    "C-j" 'helm-next-line)
  )

(evil-set-initial-state 'pdf-view-mode 'normal)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (helm rjsx-mode tide web-mode company-quickhelp company flycheck typescript-mode slime pdf-tools evil-magit zenburn-theme which-key use-package restart-emacs neotree magit general fzf evil-escape evil auto-package-update))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(pdf-tools-install)
