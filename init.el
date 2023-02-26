(require 'package)

(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)
(package-refresh-contents t)

(setq backup-directory-alist '(("." . "~/.config/emacs/backups/")))

(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(fringe-mode -1)

(setq inhibit-startup-screen t)

(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode 1)

(set-face-attribute 'default nil :height 130)

(load-theme 'doom-gruvbox t)

(require 'doom-modeline)
(doom-modeline-mode 1)

(global-set-key (kbd "C-:") #'other-window)
(global-set-key (kbd "C-;") #'previous-window-any-frame)

(show-paren-mode 1)
(electric-pair-mode 1)

(setq tab-stop-list '(2))

(add-hook 'text-mode-hook #'auto-fill-mode)

(setq evil-want-C-u-scroll t)
(setq evil-insert-state-cursor 'bar)
(setq evil-undo-system 'undo-redo)
(setq evil-kill-on-visual-paste nil)
(setq evil-want-keybinding nil)

(require 'evil)
(evil-mode 1)

(require 'evil-collection)
(evil-collection-init)

(evil-set-leader 'motion (kbd "<SPC>"))

(evil-global-set-key 'normal (kbd "gc") #'comment-line)
(evil-global-set-key 'motion (kbd "M-u") #'universal-argument)

(global-evil-surround-mode 1)

(require 'org-auto-tangle)

(add-hook 'org-mode-hook 'org-auto-tangle-mode)

(global-set-key (kbd "C-c a") #'org-agenda)
(global-set-key (kbd "C-c l") #'org-store-link)

(setq org-startup-indented t)
(setq org-startup-folded t)
(setq org-startup-with-inline-images t)
(setq org-image-actual-width nil)

(require 'org-bullets)
(add-hook 'org-mode-hook #'org-bullets-mode)

(setq org-agenda-files '("~/org/agenda/agenda.org"))
(setq org-todo-keywords
      '((sequence "PENDIENTE(p)" "EN ESPERA(e)" "|" "HECHO(h)" "CANCELADO(c)" "FALLADO(f)")))
(setq org-tag-alist
      '(("acción" . ?a)
        ("sesión" . ?s)
        ("expotec" . ?x)
        ("evento" . ?v)
        ("extracurricular" . ?e)))

(setq org-highlight-latex-and-related '(latex script entities))
(setq org-format-latex-options (plist-put org-format-latex-options :scale 1.8))
(setq org-startup-with-latex-preview t)

(add-hook 'org-mode-hook 'org-fragtog-mode)

(require 'evil-org)

(add-hook 'org-mode-hook 'evil-org-mode)
(evil-org-set-key-theme '(navigation insert textobjects additional calendar))

(global-tree-sitter-mode 1)
(add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode)

(add-hook 'prog-mode-hook 'eglot-ensure)

(yas-global-mode 1)

(setq company-minimum-prefix-length 1)

(global-company-mode 1)

(add-hook 'eglot-managed-mode-hook
          (lambda ()
            (add-to-list 'company-backends
                         '(company-capf :with company-yasnippet))))

(evil-define-key 'normal eglot-mode-map (kbd "gd") #'xref-find-definitions)
(evil-define-key 'normal eglot-mode-map (kbd "gr") #'xref-find-references)
(evil-define-key 'normal eglot-mode-map (kbd "<leader>n") #'eglot-rename)
(evil-define-key 'motion eglot-mode-map (kbd "<leader>a") #'eglot-code-actions)
(evil-define-key 'motion eglot-mode-map (kbd "<leader>b") #'eglot-format-buffer)
(evil-define-key 'motion eglot-mode-map (kbd "<leader>h") #'display-local-help)
(evil-define-key 'normal eglot-mode-map (kbd "<leader>[") #'flymake-goto-next-error)
(evil-define-key 'normal eglot-mode-map (kbd "<leader>]") #'flymake-goto-prev-error)

(setq ivy-wrap t)
(setq ivy-re-builders-alist '((t . ivy--regex-ignore-order)))
(setq ivy-initial-inputs-alist '((t . "")))

(counsel-mode 1)

(define-key ivy-minibuffer-map (kbd "C-u") #'ivy-scroll-down-command)
(define-key ivy-minibuffer-map (kbd "C-d") #'ivy-scroll-up-command)
(define-key ivy-minibuffer-map (kbd "C-i") #'ivy-insert-current)
(define-key ivy-minibuffer-map (kbd "C-<return>") #'ivy-call)

(evil-global-set-key 'motion (kbd "/") #'swiper)
