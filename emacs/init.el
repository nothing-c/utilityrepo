(package-initialize)

(custom-set-variables
 '(ansi-color-names-vector
   ["black" "#d55e00" "#009e73" "#f8ec59" "#0072b2" "#cc79a7" "#56b4e9" "white"])
 '(custom-enabled-themes '(nichtsc))
 '(custom-safe-themes
   '("7034f9c4f90d6d56b85bf4037c076a884c1bead8f841f1cdf66c6d39b62c9b1a" default))
 '(inhibit-startup-screen t)
 '(send-mail-function (quote mailclient-send-it)))
(custom-set-faces
 )

;; Set to default position
(set-frame-position (selected-frame) 469 150)

;; set to decent size
(add-to-list 'default-frame-alist '(width  . 80))
(add-to-list 'default-frame-alist '(height . 50))

;;Change this file path based on what pic/file you want on startup
(setq initial-buffer-choice "")
(setq tab-always-indent '())
(setq default-tab-width 4)
(setq indent-line-function 'tab-to-tab-stop)
(setq mouse-autoselect-window t)
;;fix dired mode
(setq dired-kill-when-opening-new-dired-buffer t)
;;let dired use 'a'
(put 'dired-find-alternate-file 'disabled nil)
;;fundamental mode sucks
(setq-default major-mode 'text-mode)
;; use ido-mode
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(setq ido-create-new-buffer 'always)
(setq ido-enable-flex-matching t)
(ido-mode 1)
(setq-default buffer-file-coding-system 'utf-8-unix)
(global-hl-line-mode 1)
(add-to-list 'load-path "~/.emacs.d/")

;;THE FUNCTION ZONE WOOOO
(defun esh-buf ()
  "Quick eshell buffer"
  (interactive)
  (split-window-vertically)
	(eshell))

(defun new-esh ()
  "Open new eshell instance"
  (interactive)
  (eshell 'N))

(defun text-tab ()
  "Do some proper tabbing in text=mode"
  (interactive)
  (insert "    "))

;;fix text-mode tab behavior
(add-hook 'text-mode-hook
          (lambda ()
            (define-key text-mode-map "\t" 'text-tab)
	    (electric-indent-local-mode 0)))

;; Make lines truncate
;;NOTE: add this to the mode you're in if you need to
(add-hook 'org-mode-hook
	  (lambda ()
	    (toggle-truncate-lines)))

;;(add-hook 'html-mode-hook
;;	  (lambda ()
;;	    (html-nc)))

;; Cut/copy/paste
(provide 'cua-mode)
;; Note: for cua-mode, if you need to use a command on some text, use C-S-x or C-S-c
(cua-mode)

;;Overwrite when region selected
(delete-selection-mode)

;; Keybinds
;; General usage
(global-set-key (kbd "<home>") 'menu-bar-open)
(global-set-key (kbd "M-s") 'query-replace)
(global-set-key (kbd "M-q") 'suspend-frame)
(global-set-key (kbd "M-[") 'scroll-down)
(global-set-key (kbd "M-]") 'scroll-up)

;; Extra functionality
(global-set-key (kbd "C-x t") 'esh-buf)
(global-set-key (kbd "C-S-e") 'new-esh)
(global-set-key (kbd "C-x c") 'calc)

;; Special movement minor mode
;; Like vi, but C-hjkl
(defvar mv-map (make-sparse-keymap) "Special movement keymap")
(define-key mv-map (kbd "C-h") 'backward-char)
(define-key mv-map (kbd "C-k") 'previous-line)
(define-key mv-map (kbd "C-j") 'next-line)
(define-key mv-map (kbd "C-l") 'forward-char)
(define-key mv-map (kbd "M-k") 'kill-line)
(define-key mv-map (kbd "M-l") 'forward-word)
(define-key mv-map (kbd "M-h") 'backward-word)
(define-key mv-map (kbd "M-o") 'find-file-other-frame) ;;C-x 5 0 to close
;; sexp lisp movement
(define-key mv-map (kbd "C-M-l") 'forward-sexp)
(define-key mv-map (kbd "C-M-h") 'backward-sexp)
(define-key mv-map (kbd "C-M-j") 'down-list)
(define-key mv-map (kbd "C-M-k") 'backward-up-list)
(define-key mv-map (kbd "C-S-M-k") 'kill-sexp)
(define-minor-mode mv-mode
  "Vi-type movement with control keys"
  :global t
  :init-value t
  :lighter " mv"
  :keymap mv-map
  )
(add-to-list 'emulation-mode-map-alists
	     `((mv-mode . ,mv-map)))
(provide 'mv-mode)

;;load general snippets
(load "~/.emacs.d/general.el")

;; Load custom theme
(load-theme 'nichtsc t)

;; Deal with big ol' lines
(global-so-long-mode)

;; Precise scroll
(pixel-scroll-mode)

;;hide backups
(setq backup-directory-alist `(("." . "~/autosaves")))

;; optimize gc from https://akrl.sdf.org/#orgc15a10d
(defmacro k-time (&rest body)
  "Measure and return the time it takes evaluating BODY."
  `(let ((time (current-time)))
     ,@body
     (float-time (time-since time))))

;; Set garbage collection threshold to 1GB.
(setq gc-cons-threshold #x40000000)

;; When idle for 15sec run the GC no matter what.
(defvar k-gc-timer
  (run-with-idle-timer 15 t
                       (lambda ()
                         (message "Garbage Collector has run for %.06fsec"
                                  (k-time (garbage-collect))))))

(tool-bar-mode -1)
(menu-bar-mode -1)
(appt-activate 1) ;; allow for appt notifications
(setq ring-bell-function 'ignore)
(load-file "~/.emacs.d/pod-mode.el")
(require 'pod-mode)

(global-set-key (kbd "C-c n") 'rand-buf)
(global-set-key (kbd "M-/") 'hippie-expand)
(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key (kbd "C-S-s") 'occur)
(require 'org)
(setq org-startup-with-inline-images t) ;; Render
(setq org-image-actual-width '())
(load-file "~/.emacs.d/neomgr.el")
(load-file "~/.emacs.d/notes.el")
(init-notes)
(global-prettify-symbols-mode)
(load-file "~/.emacs.d/external-cmds.el")
(nc-externals nc-assoc)
(setq org-pretty-entities t)
(put 'downcase-region 'disabled nil)
(setq inferior-lisp-program "sbcl.exe --noinform")
(fset 'anki-cloze-def
   (kmacro-lambda-form [?\{ ?\{ ?c ?1 ?: ?: ?\C-s ?: return ?\C-h ?\} ?\} ?\C-l ?\C-l ?\{ ?\{ ?c ?2 ?: ?: ?\C-e ?\} ?\} ?\C-l] 0 "%d"))
(fset 'anki-cloze-list
      (kmacro-lambda-form [?\C-l ?\C-l ?\{ ?\{ ?c ?1 ?: ?: ?\C-e ?\} ?\} ?\C-l] 0 "%d"))
(defun cloze-region ()
  "Make a region an Anki cloze"
  (interactive)
  (let ((pt (region-beginning)))
    (goto-char (region-end))
    (insert "}}")
    (goto-char pt)
    (insert "{{")))
(setq enable-recursive-minibuffers t)
(global-set-key (kbd "C-c C-x C-c") 'compile)
(fset 'rotate-windows
      (kmacro-lambda-form [?\C-x ?r ?  ?0 ?\C-x ?o ?\C-x ?1 ?\C-x ?3 ?\C-x ?r ?j ?0] 0 "%d"))
(global-set-key (kbd "<mouse-2>") 'cua-paste)
(load-file "~/.emacs.d/acme-mode.el")
(setq-default major-mode 'org-mode)
