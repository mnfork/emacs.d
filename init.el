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
    (linum-relative evil-collection evil-org org evil-escape evil racket-mode helm helm-descbinds helm-swoop markdown-mode)))
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
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/"))
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Helm  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'helm)
(require 'helm-config)

;; make helm-find-files the default for finding files with the standard keybinding
(global-set-key (kbd "C-x C-f") 'helm-find-files)

;; The default "C-x c" is quite close to "C-x C-c", which quits Emacs.
;; Changed to "C-c h". Note: We must set "C-c h" globally, because we
;; cannot change `helm-command-prefix-key' once `helm-config' is loaded.
(global-set-key (kbd "C-c h") 'helm-command-prefix)
(global-unset-key (kbd "C-x c"))

(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to run persistent action
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB work in terminal
(define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z

(when (executable-find "curl")
  (setq helm-google-suggest-use-curl-p t))

(setq helm-split-window-in-side-p           t ; open helm buffer inside current window, not occupy whole other window
      helm-move-to-line-cycle-in-source     t ; move to end or beginning of source when reaching top or bottom of source.
      helm-ff-search-library-in-sexp        t ; search for library in `require' and `declare-function' sexp.
      helm-scroll-amount                    8 ; scroll 8 lines other window using M-<next>/M-<prior>
      helm-ff-file-name-history-use-recentf t
      helm-echo-input-in-header-line t)

(defun spacemacs//helm-hide-minibuffer-maybe ()
  "Hide minibuffer in Helm session if we use the header line as input field."
  (when (with-helm-buffer helm-echo-input-in-header-line)
    (let ((ov (make-overlay (point-min) (point-max) nil nil t)))
      (overlay-put ov 'window (selected-window))
      (overlay-put ov 'face
                   (let ((bg-color (face-background 'default nil)))
                     `(:background ,bg-color :foreground ,bg-color)))
      (setq-local cursor-type nil))))


(add-hook 'helm-minibuffer-set-up-hook
          'spacemacs//helm-hide-minibuffer-maybe)

(setq helm-autoresize-max-height 0)
(setq helm-autoresize-min-height 20)
(helm-autoresize-mode 1)

(helm-mode 1)


(require 'helm-descbinds)
(helm-descbinds-mode)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Speedbar
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'sr-speedbar)
(setq speedbar-use-images nil)
(global-set-key [f8] 'sr-speedbar-toggle)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Evil Mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'evil)
;; start evil mode
(evil-mode 1)
;; allow the cursor to behave more like emacs cursor
(setq evil-move-beyond-eol t)
(setq evil-move-cursor-back nil)
;; use the evil search mode
(setq evil-search-module 'evil-search)

;; enable evil-escape (exit insert mode with fd)
(require 'evil-escape)
(evil-escape-mode)
(setq-default evil-escape-key-sequence "fd")

;; evil-collection for helm
;; this has some error related to
;; https://github.com/emacs-evil/evil-collection/issues/60
;; (evil-collection-init 'helm)

;; Relative line numbers
(require 'linum-relative)
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Org Mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'org)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)
(setq org-agenda-files (list "/mnt/workspace/wiki/tasks.org"))
(require 'evil-org)
(add-hook 'org-mode-hook 'evil-org-mode)
(evil-org-set-key-theme '(navigation insert textobjects
                                     additional calendar todo heading))
(require 'evil-org-agenda)
(evil-org-agenda-set-keys)

(setq org-use-fast-todo-selection t)

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



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Spelling
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; save a new word to personal dictionary without asking
(setq ispell-silently-savep t)
;; auto start flyspell for tex documents
(add-hook 'LaTeX-mode-hook 'flyspell-mode)
;; auto start flyspell for org documents
(add-hook 'org-mode-hook 'flyspell-mode)
;; auto start flyspell for markdown documents
(add-hook 'markdown-mode-hook 'flyspell-mode)
