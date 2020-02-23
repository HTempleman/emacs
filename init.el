(setq exec-path (append exec-path '(
				    "/bin",
				    "~/.pyenv/shims",
				    "~/.nvm/versions/node/v10.16.3/bin"
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





;;Bootstrap use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile
  (require 'rg)
  (require 'use-package))

(setq use-package-always-ensure t)


;; Specify that packages should remain up-to-date.
(use-package auto-package-update
	    :config
	    (setq auto-package-update-delte-old-versions t)
	    (setq auto-package-update-hide-results t)
	    (auto-package-update-maybe))

(use-package restart-emacs)
	     
;; Look and Feel

(use-package all-the-icons)

(add-hook 'dired-mode-hook 'all-the-icons-dired-mode)

(use-package zenburn-theme
	     :config
	     (load-theme 'zenburn t))

(use-package dashboard
  :config
  (setq dashboard-banner-logo-title "Greetings Hunter.")
  (setq dashboard-startup-banner 3)
  (setq dashboard-set-heading-icons t)
  (setq dashbard-set-file-icons t)
  (setq dashboard-items '((recents . 5)
			  (bookmarks . 5)
			  (projects . 5)
			  (agenda . 5)
			  (registers . 5)))
  (setq dashboard-footer-icon (all-the-icons-octicon "dashboard"
						     :height 1.1
						     :v-adjust -0.05
						     :face 'font-lock-keyword-face))
  (dashboard-modify-heading-icons '((recents . "file-text")))
  (dashboard-setup-startup-hook))




;; lsp configuration
(use-package lsp-mode
  :hook ((
	  web-mode
	  python-mode
	  ) . lsp )
  :config
  (lsp-register-client
   (make-lsp-client :new-connection (lsp-stdio-connection '"pyls")
		    :major-modes '(python-mode)
		    :server-id 'pyls)
   )
  (lsp-register-client
   (make-lsp-client :new-connection (lsp-stdio-connection '("typescript-language-server" "--stdio"))
		    :major-modes '(web-mode typescript-mode)
		    :server-id 'typescript-language-server)
   )
  :commands lsp)

(use-package lsp-ui
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


;; language modes
(use-package markdown-mode)
(use-package rust-mode)
(use-package scad-mode)
(use-package csound-mode
  :mode (("\\.csd\\'" . csound-mode)
	 ("\\.orc\\'" . csound-mode)
	 ("\\.sco\\'" . csound-mode)
	 ("\\.udo\\'" . csound-mode))
  )

;; UX packages

(use-package evil
  :init
  (setq evil-want-C-u-scroll t)
  :config
  (evil-mode 1))

(use-package evil-escape
	     :config
	     (evil-escape-mode))

(use-package org-pomodoro
  :config
  (setq org-pomodoro-finished-sound "~/.emacs.d/audio/pomodoro_alarm.wav"))

(use-package helm
  :config
  (helm-mode 1))

(use-package helm-rg)

(use-package projectile
  :init
  (setq projectile-require-project-root nil)
  :config
  (projectile-mode 1))

(use-package helm-projectile
  :init
  (setq helm-projectile-fuzzy-match t)
  :config
  (helm-projectile-on))

(use-package ranger)

(use-package dumb-jump)
(use-package magit)
(use-package flycheck)

(use-package company
  :config
  (setq company-show-numbers t)
  (setq company-toolkit-align-annotations t)
  (setq company-tooltip-flip-when-above t)
  (global-company-mode))


(use-package web-mode
  :mode (("\\.tsx\\'" . web-mode)))


(use-package which-key
  :init
  (setq which-key-separator " ⇒ ")
  (setq which-key-prefix-prefix "+")
  (setq which-key-enable-extended-global-set-key t)
  :config
  (which-key-mode))



;; Keybindings

;; projectile
(global-set-key (kbd "\C-c p") 'nil)
(global-set-key (kbd "\C-c p p") 'helm-projectile-switch-project)
(global-set-key (kbd "\C-c p f") 'helm-projectile-find-file)

;; evil
(global-set-key (kbd "\C-x z") '("evil-mode" . evil-mode))

;; ranger
(global-set-key (kbd "\C-c r") 'ranger)

;; org
(global-set-key (kbd "\C-c o") 'nil)
(global-set-key (kbd "\C-c op") 'org-pomodoro)

;; toggle keybindings
(global-set-key (kbd "\C-c t") 'nil)
(global-set-key  (kbd "\C-c tn") 'display-line-numbers-mode)



(which-key-add-key-based-replacements
  "\C-c p" "projectile"
  "\C-c p p" "project switch"
  "\C-c p f" "file switch"
  "\C-c t" "toggle"
  "\C-c tn" "toggle line num"
  "\C-c o" "org"
  )







(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (all-the-icons-dired dashboard ranger zenburn-theme which-key web-mode vscode-icon use-package treemacs-projectile treemacs-magit treemacs-icons-dired treemacs-evil tide slime shackle scad-mode rust-mode rjsx-mode rg restart-emacs pyvenv pomidor pdf-tools org-pomodoro neotree lsp-ui helm-swoop helm-rg helm-projectile general fzf evil-magit evil-escape dumb-jump csound-mode company-quickhelp company-lsp ccls bug-hunter buffer-move borg auto-package-update all-the-icons))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
