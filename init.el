;; This config was pulled very heavily from one conceived by Sanchayan
;; Maity. It is an attempt to take the nice parts from Spacemacs.
;; 'M-x bug-hunter-init-file' should be useful to you for locating
;; problems in the initialization file!

;; set exec path
(setq exec-path (append exec-path '(
				    "/bin",
				    "~/.pyenv/shims",
				    "~/.nvm/versions/node/v10.16.3/bin/"
				    )))

(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")
(require 'package)
(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
			 ("melpa" . "https://melpa.org/packages/")))
(package-initialize)

;; Tramp Settings
(setq tramp-default-method "ssh")


;; Enable auto-fill-mode
(setq-default auto-fill-function 'do-auto-fill)

;; Global Settings
(show-paren-mode 1)
(electric-pair-mode)
(global-eldoc-mode -1)
;; Get rid of cruft.
(menu-bar-mode -1)
(tool-bar-mode -1)
(toggle-scroll-bar -1)
(set-face-attribute 'default nil :height 130)
(setq use-dialog-box nil)

;; rg keybindings
(rg-enable-default-bindings)

;; Set sudo shorcut
(setenv "sudo" "/sudo::")

;; Bootstrap use-package:
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile
  (require 'rg)
  (require 'use-package))


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



;; lsp configuration
(use-package lsp-mode
  :hook ((
	  web-mode
	  python-mode
	  ) . lsp )
	:commands lsp)

(use-package lsp-ui
  :ensure t
  :commands lsp-ui-mode
  :config
  (setq lsp-ui-sideline-enable t)
  )
(use-package company-lsp :commands company-lsp)


(defvar lsp-language-id-configuration
  '(
    (web-mode . "web")
    (python-mode . "python")
    (typescript-mode . "typescript")
    ))

(use-package pyvenv
  :diminish
  :config
  (setq pyvenv-mode-line-indicator
	'(pyvenv-virtual-env-name ("[venv:" pyvenv-virtual-env-name "] ")))
  (pyvenv-mode +1))

(use-package evil
	     :ensure t
	     :init
	     (setq evil-want-C-u-scroll t)
	     :config
	     (evil-mode 1)
	     )



(use-package markdown-mode
  :ensure t
  :init)

(use-package python-mode
  :ensure t
  :init
  )
(use-package rust-mode
  :ensure t
  :init)

(use-package csound-mode
  :ensure t
  :mode (("\\.csd\\'" . csound-mode)
	 ("\\.orc\\'" . csound-mode)
	 ("\\.sco\\'" . csound-mode)
	 ("\\.udo\\'" . csound-mode))
  )

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


(use-package org-pomodoro
  :ensure t
  :config
  (setq org-pomodoro-finished-sound "~/.emacs.d/audio/pomodoro_alarm.wav")
  )

(use-package async
  :ensure t)

(use-package helm
  :ensure t
  :init
  :config
  (helm-mode 1))

(use-package helm-swoop
  :ensure t
  :config
  (setq helm-multi-swoop-edit-save t)
  (setq helm-swoop-split-with-multiple-windows nil)
  (setq helm-swoop-split-direction 'split-window-vertically)
  (setq helm-swoop-speed-or-color nil)
  (setq helm-swoop-move-to-line-cycle t)
  (setq helm-swoop-use-line-number-face t)
  (setq helm0swoop-use-fuzzy-match t)
  )

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

(use-package dumb-jump
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
  :mode (("\\.tsx\\'" . web-mode))
  )


(use-package rjsx-mode
  :ensure t
  :config
  (setq js-indent-level 2))

(use-package typescript-mode
  :ensure t
  :config
  (setq typescript-indent-level 2))


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
   :states '(normal motion treemacs)
   :keymaps 'override
   :prefix "SPC"
   :non-normal-prefix "SPC"


   "/" '(helm-projectile-rg
	 :which-key "ripgrep")

   ;; Bindings for projectile featurs.
   "p" '("projectile")
   "pf" '(helm-projectile-find-file :which-key "find-project-file")
   "pF" '(projectile-find-file-dwim-other-window
	  :which-key "jump-to-file")
   "pp" '(helm-projectile-switch-project
	  :which-key "switch-project")
   "pj" '(dumb-jump-go :which-key "dumb-jump-go")
   "pJ" '(dumb-jump-back :which-key "dumb-jump-back")
   "pg" '(projectile-grep :which-key "projectile-grep")

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


   ;; Helm keybindings
   "h" '("helm")
   "hs" '(helm-swoop-without-pre-input :which-key "helm-swoop")

   ;; Pomodoro keybindings
   "P" '("pomidor")
   "Pp" '(pomidor-stop :which-key "pomidors")

   ;; Shell Keybindings
   "s" '("shell")
   "si" '(ansi-term :which-key "ansi-term")
   "ss" '(find-file "/sudo::" :which-key "sudo")

   ;; Buffer Keybindings
   "b" '("buffer")
   "bm" '(switch-to-buffer :which-key "buffer-switch")
   "bf" '(helm-imenu-in-all-buffers :which-key "list-functions-from-all-buffers")
   "bh" '(previous-buffer :which-key "previous-buffer")
   "bl" '(next-buffer :which-key "next-buffer")

   ;; Bookmark Keybindings
   "l" '("bookmark")
   "ls" '(bookmark-set :which-key "set-bookmark")
   "ll" '(list-bookmark :which-key "list-bookmarks")
   "lj" '(bookmark-jump :which-key "jump-to-bookmark")

   )

  (general-define-key
   :states 'normal
   :keymaps 'pdf-view-mode-map
   "j" 'pdf-view-next-line-or-next-page
   "k" 'pdf-view-previous-line-or-previous-page
   "J" 'pdf-view-next-page-command
   "K" 'pdf-view-previous-page-command
   "P" 'pdf-view-goto-page
   "H" 'pdf-view-fit-height-to-window
   "W" 'pdf-view-fit-width-to-window
   "h" 'image-backward-hscroll
   "l" 'image-forward-hscroll
   "p" 'pdf-view-enlarge
   "n" 'pdf-view-shrink
   "r" 'image-scroll-right
   "F" 'pdf-occur
   "o" 'pdf-outline
   )
  )

(evil-set-initial-state 'pdf-view-mode 'normal)
(add-hook 'pdf-view-mode-hook
	  (lambda ()
	    (set (make-local-variable 'evil-normal-state-cursor) (list nil))))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (pyvenv lsp-ui lsp-mode shackle borg csound-mode helm-swoop bug-hunter helm rjsx-mode tide web-mode company-quickhelp company flycheck typescript-mode slime pdf-tools evil-magit zenburn-theme which-key use-package restart-emacs neotree magit general fzf evil-escape evil auto-package-update))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(pdf-tools-install)

