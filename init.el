;; Package Setup
(setq package-archives '(("melpa" . "http://melpa.org/packages/")
                         ("gnu" . "http://elpa.gnu.org/packages/")))
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(when (cl-find-if-not #'package-installed-p package-selected-packages)
  (package-refresh-contents)
  (mapc #'package-install package-selected-packages))

;; use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)

;; remove UI
(setq inhibit-startup-screen t)
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

;; Line Number Mode
(if (version<= "26.0.50" emacs-version)
    (global-display-line-numbers-mode)
  (global-linum-mode 1))

;; Column Number Mode
(column-number-mode 1)

;; Alarm Bell
(setq ring-bell-function 'ignore)


;; Place auto-save files into system's temporary file
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; y for yes
(fset 'yes-or-no-p 'y-or-n-p)

;; kill current buffer
(global-set-key (kbd "C-x k") 'kill-this-buffer)

;; CC Mode
(require 'cc-mode)
(setq-default c-basic-offset 4)
(setq c-default-style "linux")

(use-package doom-themes
  :ensure t
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'doom-rouge t)
  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))

;; hide minor modes from mode line
(use-package diminish
  :ensure t)

(use-package smartparens
  :ensure t
  :diminish smartparens-mode
  :config
  (progn
    (require 'smartparens-config)
    (smartparens-global-mode 1)
    (show-paren-mode t)))

;; autocomplete
(use-package company
  :ensure t
  :diminish company-mode
  :config
  (Add-hook 'after-init-hook #'global-company-mode))

;; syntax checking 
(use-package flycheck
  :ensure t
  :diminish flycheck-mode
  :config
  (add-hook 'after-init-hook #'global-flycheck-mode))

;; Yasnippit
(use-package yasnippet
  :defer 2
  :config
  (yas-global-mode 1))
(use-package yasnippet-snippets
  :defer)

;; emacs server
(require 'server)
(if (not (server-running-p)) (server-start))


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("e2c926ced58e48afc87f4415af9b7f7b58e62ec792659fcb626e8cba674d2065" "84d2f9eeb3f82d619ca4bfffe5f157282f4779732f48a5ac1484d94d5ff5b279" default))
 '(package-selected-packages
   '(diminish zoom zenburn-theme yasnippet-snippets which-key use-package smartparens smart-mode-line-powerline-theme molokai-theme magit lsp-ui lsp-python-ms lsp-ivy latex-preview-pane iedit ido-completing-read+ go-mode flycheck exotica-theme exec-path-from-shell dap-mode counsel company)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
