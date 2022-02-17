;; Package Setup
(setq package-archives '(("melpa" . "http://melpa.org/packages/")
                         ("gnu" . "http://elpa.gnu.org/packages/")))
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(when (cl-find-if-not #'package-installed-p package-selected-packages)
  (package-refresh-contents)
  (mapc #'package-install package-selected-packages))

;; Bootstrap John Wigley's "use-package"
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)

;; remove UI 
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

;; Zenburn
(load-theme 'zenburn t)

;; Power Line
(require 'powerline)
(powerline-default-theme)

;; Iedit
(require 'iedit)

;; Ido
(ido-mode 1)
(ido-everywhere 1)

;; Ido Completing Read Plus
(require 'ido-completing-read+)
(ido-ubiquitous-mode 1)

;; Ivy
(ivy-mode)
(counsel-mode)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)
(setq search-default-mode #'char-fold-to-regexp)
;; (global-set-key "\C-s" 'swiper)


;; Company
(add-hook 'after-init-hook 'global-company-mode)
(setq company-idle-delay 0)
(setq company-minimum-prefix-length 1)
(setq company-show-numbers t)

;; Which Key
(which-key-mode)

;; YASnippet
(yas-global-mode 1)

(defvar my-company-point nil)
(advice-add 'company-complete-common
            :before (lambda () (setq my-company-point (point))))
(advice-add 'company-complete-common
            :after (lambda ()
  		     (when (equal my-company-point (point))
  		       (yas-expand))))

;; LSP
(add-hook 'c-mode-hook 'lsp)
(add-hook 'c++-mode-hook 'lsp)
(require 'lsp-python-ms)
(setq lsp-python-ms-auto-install-server t)
(add-hook 'python-mode-hook #'lsp)
(use-package lsp-python-ms
  :ensure t
  :init (setq lsp-python-ms-auto-install-server t)
  :hook (python-mode . (lambda ()
                         (require 'lsp-python-ms)
                         (lsp))))
(add-hook 'latex-mode-hook 'lsp)
(add-hook 'markdown-mode-hook 'lsp)
(setq lsp-clients-clangd-args
      '("--header-insertion=never"
        "--header-insertion-decorators=0"))
(with-eval-after-load 'lsp-mode
  (add-hook 'lsp-mode-hook #'lsp-enable-which-key-integration)
  (require 'dap-cpptools)
  (yas-global-mode))

;; Flycheck
(add-hook 'c-mode-hook #'flycheck-mode)
(add-hook 'c++-mode-hook #'flycheck-mode)
(add-hook 'python-mode-hook #'flycheck-mode)

;; Smartparens
(require 'smartparens-config)
(add-hook 'c-mode-hook #'smartparens-mode)
(add-hook 'c++-mode-hook #'smartparens-mode)
(add-hook 'emacs-lisp-mode-hook #'smartparens-mode)
(add-hook 'python-mode-hook #'smartparens-mode)

;; When you press RET, the curly braces automatically add another newline.
(sp-with-modes '(asm-mode c-mode c++-mode emacs-lisp-mode  python-mode)
  (sp-local-pair "{" nil :post-handlers '(("||\n[i]" "RET")))
  (sp-local-pair "/*" "*/" :post-handlers '(("| " "SPC") ("* ||\n[i]" "RET"))))
(setq sp-escape-quotes-after-insert nil)


;; Winner
(when (fboundp 'winner-mode)
  (winner-mode 1))

;; Alarm Bell
(setq ring-bell-function 'ignore)

;; Line Number Mode
(if (version<= "26.0.50" emacs-version)
    (global-display-line-numbers-mode)
  (global-linum-mode 1))

;; Column Number Mode
(column-number-mode 1)

;; Place auto-save files into system's temporary file
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; Org Mode
(eval-after-load "org"
  '(require 'ox-md nil t))

;; CC Mode
(require 'cc-mode)
(setq c-default-style "linux")


;; --------------------------------------------------------------------------------------

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("e6df46d5085fde0ad56a46ef69ebb388193080cc9819e2d6024c9c6e27388ba9" default))
 '(package-selected-packages
   '(zenburn-theme ido-completing-read+ iedit lsp-ivy lsp-ui latex-preview-pane powerline zoom lsp-python-ms dap-mode which-key magit go-mode exec-path-from-shell yasnippet-snippets yasnippet lsp-mode counsel ivy flycheck company smartparens)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
