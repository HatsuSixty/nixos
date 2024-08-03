;;; remove annoying warnings

(setq warning-minimum-level :emergency)

;;; make emacs stop asking about themes

(setq custom-safe-themes t)

;;; simplify GUI & appearance

(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)
(column-number-mode 1)
(show-paren-mode 1)
(setq display-line-numbers-type 'relative)
(setq inhibit-startup-screen t)

(when (version<= "26.0.50" emacs-version)
  (global-display-line-numbers-mode))

(add-to-list 'default-frame-alist '(font . "Iosevka Nerd Font Mono 14"))

;;; packages

(setq package-list '(;;; lsp
                     lsp-mode
                     lsp-ui
                     flycheck
                     company
                     lsp-treemacs
                     helm-lsp
                     lsp-ivy
                     dap-mode

                     ;;; useful packages
                     multiple-cursors
                     yasnippet-snippets
                     yasnippet
                     magit
                     whitespace-cleanup-mode
                     astyle
                     elcord
                     evil

                     ;;; language modes
                     gdscript-mode
                     yaml-mode
                     nasm-mode
                     rust-mode
                     markdown-mode
                     lua-mode
                     csharp-mode
                     go-mode
                     rainbow-mode
                     cmake-mode
                     nim-mode
                     meson-mode
                     typescript-mode
                     nix-mode

                     ;;; themes
                     doom-themes
                     gruber-darker-theme
                     ))

(require 'package)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("melpa" . "http://melpa.org/packages/")))
(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

;;; evil

(require 'evil)
;(evil-mode 1)
(evil-ex-define-cmd "q[uit]" 'kill-current-buffer)
(setq evil-undo-system 'undo-redo)

;;; elcord

(require 'elcord)
(elcord-mode)

;;; autoload files

(add-to-list 'load-path
             (concat user-emacs-directory (file-name-as-directory "lisp")))
(mapc 'load (file-expand-wildcards
             (concat user-emacs-directory (file-name-as-directory "lisp") "*.el")))

;;; setup themes

(add-to-list 'custom-theme-load-path
             (concat user-emacs-directory (file-name-as-directory "themes")))

;;;; tabs and spaces

(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)

;;;; c-mode

;;(add-to-list 'auto-mode-alist '("\\.[hc]\\(pp\\)?\\'" . simpc-mode))

(add-hook 'c-mode-hook (lambda ()
                         (interactive)
                         (c-toggle-comment-style -1)
                         (local-set-key (kbd "C-c C-f") 'clang-format-buffer)))

(setq-default c-basic-offset 4
              c-default-style '((java-mode . "java")
                                (awk-mode . "awk")
                                (other . "bsd")))

(require 'simpc-mode)

(add-hook 'simpc-mode-hook
          (lambda ()
            (interactive)
            (setq-local fill-paragraph-function 'astyle-buffer)
            (local-set-key (kbd "C-c C-f") 'astyle-region)))

;;; whitespace

(require 'whitespace)

(defconst USE-WHITESPACE 1)

(defun rc/set-up-whitespace-handling ()
  (interactive)
  (whitespace-mode USE-WHITESPACE)
  (whitespace-cleanup-mode))

(add-hook 'prog-mode-hook 'rc/set-up-whitespace-handling)

(setq whitespace-style
      (quote
       (face tabs spaces trailing space-before-tab newline indentation empty space-after-tab space-mark tab-mark)))

;;; yasnippets

(require 'yasnippet)
(yas-global-mode 1)

;;; multiple cursors

(require 'multiple-cursors)

(setq mc/always-run-for-all t)

(global-set-key (kbd "C-x RET RET") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

;;; company mode

(require 'company)

(global-company-mode)

(add-hook 'tuareg-mode-hook
          (lambda ()
            (interactive)
            (company-mode 0)))

;;; lsp-mode

;;(setq lsp-ui-doc-enable t)
(setq lsp-ui-doc-enable nil)
(setq lsp-ui-doc-show-with-cursor t)
(setq lsp-ui-doc-position 'bottom)

(setq-default lsp-keymap-prefix "C-c l")

(require 'lsp-mode)
(add-hook 'prog-mode-hook #'lsp-deferred)

;;; keybindings

;; duplicate line

(defun duplicate-line()
  (interactive)
  (move-beginning-of-line 1)
  (kill-line)
  (yank)
  (open-line 1)
  (next-line 1)
  (yank))

(global-set-key (kbd "C-d") 'duplicate-line)

;; compile

(global-set-key (kbd "C-c c") 'compile)

;; terminal

(global-set-key (kbd "C-`") (lambda()
                              (interactive)
                              (split-window-below)
                              (other-window 1)
                              (term "/bin/zsh")))

;;; nasm mode

(require 'nasm-mode)
(add-to-list 'auto-mode-alist '("\\.asm?\\'" . nasm-mode))

;;; editorconfig

(require 'editorconfig)
(editorconfig-mode 1)

(defun editorconfig-exists ()
  (interactive)
  (eval-and-compile (require 'editorconfig-core))
  (let ((result nil))
    (setq result (editorconfig-core-get-nearest-editorconfig
                  default-directory))
    (unless (eq result nil)
      (setq result t))
    result))

(add-hook 'prog-mode-hook
          (lambda ()
            (add-hook 'before-save-hook
                      (lambda()
                        (interactive)
                        (unless (or (eq major-mode 'makefile-gmake-mode)
                                    (eq major-mode 'sh-mode)
                                    (eq major-mode 'markdown-mode)
                                    (eq major-mode 'conf-space-mode)
                                    (eq major-mode 'fundamental-mode)
                                    (eq major-mode 'rust-mode)
                                    (eq major-mode 'meson-mode)
                                    (not (editorconfig-exists)))
                          (editorconfig-format-buffer))))))

;;; dired

(setq dired-listing-switches "-lah --group-directories-first")
