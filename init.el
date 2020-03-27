;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Appearance Setup
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(display-time-mode t)
 '(evil-search-module (quote evil-search))
 '(package-selected-packages
   (quote
    (nlinum-relative evil-org-agenda evil-surround use-package elpy linum-relative evil-collection evil-org org evil-escape evil racket-mode helm helm-descbinds helm-swoop markdown-mode)))
 '(scroll-bar-mode (quote right))
 '(show-paren-mode t)
 '(speedbar-show-unknown-files t)
 '(text-mode-hook (quote (turn-on-auto-fill text-mode-hook-identify)))
 '(tool-bar-mode nil))
'(tooltip-mode nil)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "black" :foreground "white" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 83 :width normal :foundry "unknown" :family "DejaVu Sans Mono"))))
 '(background "blue")
 '(font-lock-builtin-face ((((class color) (background dark)) (:foreground "Turquoise"))))
 '(font-lock-comment-face ((t (:foreground "MediumAquamarine"))))
 '(font-lock-constant-face ((((class color) (background dark)) (:bold t :foreground "DarkOrchid"))))
 '(font-lock-doc-string-face ((t (:foreground "green2"))))
 '(font-lock-function-name-face ((t (:foreground "SkyBlue"))))
 '(font-lock-keyword-face ((t (:bold t :foreground "CornflowerBlue"))))
 '(font-lock-preprocessor-face ((t (:italic nil :foreground "CornFlowerBlue"))))
 '(font-lock-reference-face ((t (:foreground "DodgerBlue"))))
 '(font-lock-string-face ((t (:foreground "LimeGreen"))))
 '(font-lock-type-face ((t (:foreground "#9290ff"))))
 '(font-lock-variable-name-face ((t (:foreground "PaleGreen"))))
 '(font-lock-warning-face ((((class color) (background dark)) (:foreground "yellow" :background "red"))))
 '(highlight ((t (:background "CornflowerBlue"))))
 '(list-mode-item-selected ((t (:background "gold"))))
 '(makefile-space-face ((t (:background "wheat"))))
 '(mode-line ((t (:background "Navy"))))
 '(paren-match ((t (:background "darkseagreen4"))))
 '(region ((t (:background "DarkSlateBlue"))))
 '(show-paren-match ((t (:foreground "black" :background "wheat"))))
 '(show-paren-mismatch ((((class color)) (:foreground "white" :background "red"))))
 '(speedbar-button-face ((((class color) (background dark)) (:foreground "green4"))))
 '(speedbar-directory-face ((((class color) (background dark)) (:foreground "khaki"))))
 '(speedbar-file-face ((((class color) (background dark)) (:foreground "cyan"))))
 '(speedbar-tag-face ((((class color) (background dark)) (:foreground "Springgreen"))))
 '(vhdl-speedbar-architecture-selected-face ((((class color) (background dark)) (:underline t :foreground "Blue"))))
 '(vhdl-speedbar-entity-face ((((class color) (background dark)) (:foreground "darkGreen"))))
 '(vhdl-speedbar-entity-selected-face ((((class color) (background dark)) (:underline t :foreground "darkGreen"))))
 '(vhdl-speedbar-package-face ((((class color) (background dark)) (:foreground "black"))))
 '(vhdl-speedbar-package-selected-face ((((class color) (background dark)) (:underline t :foreground "black"))))
 '(widget-field ((((class grayscale color) (background light)) (:background "DarkBlue")))))

;; set font size
(set-face-attribute 'default nil :height 120)

;; set font face
(set-frame-font "monospace" nil t)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; General Behavior
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; remove annoying splash screen
(setq inhibit-splash-screen t)

;; Don't make me type out 'yes' and 'no'
(fset 'yes-or-no-p 'y-or-n-p)

;; goto line
(global-set-key "\M-g" 'goto-line)

;; no more dinging
(setq visible-bell 1)

;; disable M-TAB
(put 'lisp-complete-symbol 'disabled t)

(setq-default indent-tabs-mode nil)

;; The original value is "\f\\|[      ]*$", so we add the bullets (-), (+), and (*).
;; There is no need for "^" as the regexp is matched at the beginning of line.
(setq paragraph-start "\f\\|[ \t]*$\\|[ \t]*[-+*] ")

;; set default column width
(setq-default fill-column 79)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Browser
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; set default browser to emacs browser
(setq browse-url-browser-function 'eww-browse-url)

;; set the wrappoing for buffers
(setq shr-width 80)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Package Manager
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'package)
;; (add-to-list 'package-archives
;;              '("melpa-stable" . "https://stable.melpa.org/packages/"))
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; bootstrap use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile
  (require 'use-package))
(require 'bind-key)
(setq use-package-always-ensure t)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Helm  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package helm
  :bind (
         ("M-x" . helm-M-x)
         ("C-x C-f" . helm-find-files)
         ("M-y" . helm-show-kill-ring)
         :map helm-map
         ("<tab>" . helm-execute-persistent-action) ; rebind tab to run
                                                    ; persistent action
         ("C-i" . helm-execute-persistent-action) ; make TAB work in terminal
         ("C-z" . helm-select-action) ; list actions using C-z
         )
  :init
  ;; The default "C-x c" is quite close to "C-x C-c", which quits Emacs.
  ;; Changed to "C-c h". Note: We must set "C-c h" globally, because we
  ;; cannot change `helm-command-prefix-key' once `helm-config' is loaded.
  (setq helm-command-prefix-key "C-c h")
  :config
  (when (executable-find "curl")
    (setq helm-google-suggest-use-curl-p t))

  (setq helm-split-window-in-side-p           t ; open helm buffer inside
                                                ; current window, not occupy
                                                ; whole other window
        helm-move-to-line-cycle-in-source     t ; move to end or beginning of
                                                ; source when reaching top or
                                                ; bottom of source.
        helm-ff-search-library-in-sexp        t ; search for library in
                                                ; `require' and
                                                ; `declare-function' sexp.
        helm-scroll-amount                    8 ; scroll 8 lines other window
                                                ; using M-<next>/M-<prior>
        helm-ff-file-name-history-use-recentf t
        helm-echo-input-in-header-line t)
  
  (setq helm-autoresize-max-height 0)
  (setq helm-autoresize-min-height 20)
  (helm-autoresize-mode 1)

  (helm-mode 1)
)

(use-package helm-descbinds
  :after helm
  :demand t
  :config
  (helm-descbinds-mode)
)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Speedbar
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package sr-speedbar
  :bind (
         ("<f8>" . sr-speedbar-toggle)
         )
  :config
  (setq speedbar-use-images nil)
)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Evil Mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package evil
  :demand t
  :init
  (setq evil-move-beyond-eol t)
  (setq evil-move-cursor-back nil)
  (setq evil-search-module 'evil-search)
  :config
  (evil-mode 1)
)

(use-package evil-escape
  :after evil
  :demand t
  :init
  (setq-default evil-escape-key-sequence "fd")
  :config
  (evil-escape-mode)
)

(use-package evil-surround
  :after evil
  :demand t
  :config
  (global-evil-surround-mode 1)
)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Relative line numbers
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package nlinum-relative
  :demand t
  :config
  (setq nlinum-relative-redisplay-delay 0)
  (setq nlinum-relative-current-symbol "")
  (setq nlinum-relative-offset 0)
  (nlinum-relative-setup-evil)
  (global-nlinum-relative-mode)
)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Org Mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package org
  :bind (
         ("C-c l" . org-store-link)
         ("C-c a" . org-agenda)
         )
  :init
  (setq org-log-done t)
  (setq org-agenda-files (list "/mnt/workspace/wiki/tasks.org"))
  (setq org-use-fast-todo-selection t)
  :config
  (setq org-todo-keywords
        '((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d)")
          (sequence "WAITING(w@/!)" "INACTIVE(i)" "|" "CANCELLED(c@/!)" "MEETING")))

  ;; Custom colors for the keywords
  (setq org-todo-keyword-faces
        '(("TODO" :foreground "red" :weight bold)
          ("NEXT" :foreground "blue" :weight bold)
          ("DONE" :foreground "forest green" :weight bold)
          ("WAITING" :foreground "orange" :weight bold)
          ("INACTIVE" :foreground "magenta" :weight bold)
          ("CANCELLED" :foreground "forest green" :weight bold)
          ("MEETING" :foreground "forest green" :weight bold)))
  
  (defun air-org-skip-subtree-if-priority (priority)
    "Skip an agenda subtree if it has a priority of PRIORITY.

     PRIORITY may be one of the characters ?A, ?B, or ?C."
    (let ((subtree-end (save-excursion (org-end-of-subtree t)))
          (pri-value (* 1000 (- org-lowest-priority priority)))
          (pri-current (org-get-priority (thing-at-point 'line t))))
      (if (= pri-value pri-current)
          subtree-end
        nil)))

  (setq org-agenda-time-grid
        (quote
         ((daily today)
          (0600 800 1000 1200 1400 1600 1800)
          "......"
          "----------------")))

  (setq org-agenda-custom-commands
        '(("c" "Tiered agenda view"
           ((tags "PRIORITY=\"A\""
                  ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
                   (org-agenda-overriding-header "High-priority unfinished tasks:")))
            (agenda "")
            (alltodo ""
                     ((org-agenda-skip-function
                       '(or (air-org-skip-subtree-if-priority ?A)
                            (org-agenda-skip-if nil '(scheduled deadline))))
                      (org-agenda-overriding-header "Unscheduled Items")))))))
)

(use-package evil-org
  :after org
  :hook org-mode
  :config
  (evil-org-set-key-theme '(navigation insert textobjects
                                       additional calendar todo heading))
  (require 'evil-org-agenda)
  (evil-org-agenda-set-keys)
)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Spelling
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package flyspell
  :hook (
         (prog-mode . flyspell-prog-mode)
         (text-mode . flyspell-mode)
         )
  :init
  ;; save a new word to personal dictionary without asking
  (setq ispell-silently-savep t)
)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Python
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; enable elpy
;; (elpy-enable)

;; activate flyspell for Python buffers
(add-hook 'python-mode-hook
          (lambda ()
            (flyspell-prog-mode)
            ))

;; activate Hideshow for Python buffers and bind C-c h to toggle block
(add-hook 'python-mode-hook
          (lambda ()
            (hs-minor-mode)
            (define-key python-mode-map "\C-ch" 'hs-toggle-hiding)
            ))

;; files ending in ".pyx" should be python-mode
(add-to-list 'auto-mode-alist '("\\.pyx\\'" . python-mode))
