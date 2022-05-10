
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["black" "#d55e00" "#009e73" "#f8ec59" "#0072b2" "#cc79a7" "#56b4e9" "white"])
 '(custom-enabled-themes (quote (tsdh-dark)))
 '(inhibit-startup-screen t)
 '(send-mail-function (quote mailclient-send-it)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;Change this file path based on what pic/file you want on startup
(setq initial-buffer-choice "")
(setq tab-always-indent '())
(setq default-tab-width 4)
(setq indent-line-function 'tab-to-tab-stop)
(setq mouse-autoselect-window t)
;;fix dired mode
(setq dired-kill-when-opening-new-dired-buffer t)

;;THE FUNCTION ZONE WOOOO
;;saveas func
(defun saveas ()
  "Save file as new name"
  (interactive)
  (let ((newname (read-string "Save as: "))
       (current (buffer-string)))
  (find-file newname)
  (insert current))
  (save-buffer)
  )

(defun esh-buf ()
  "Quick eshell buffer"
  (interactive)
  (split-window-vertically)
	(eshell))

(defun new-esh ()
  "Open new eshell instance"
  (interactive)
  (eshell 'N))

;;fix text-mode tab behavior
(add-hook 'text-mode-hook
          (lambda ()
            (define-key text-mode-map "\t" 'tab-to-tab-stop)))

;; Cut/copy/paste
(provide 'cua-mode)
;; Note: for cua-mode, if you need to use a command on some text, use C-S-x or C-S-c
(cua-mode)

;;Overwrite when region selected
(delete-selection-mode)

;; Keybinds
;; General usage
(global-set-key (kbd "<home>") 'menu-bar-open)
(global-set-key (kbd "<C-right>") 'next-buffer)
(global-set-key (kbd "<C-left>") 'previous-buffer)
(global-set-key (kbd "C-S-s") 're-search-forward)
(global-set-key (kbd "M-s") 'query-replace)
(global-set-key (kbd "M-q") 'suspend-frame)
;; Saveas is just C-x C-w lol

;; Extra functionality
(global-set-key (kbd "C-x t") 'esh-buf)
(global-set-key (kbd "C-x e") 'tmp-macs)
(global-set-key (kbd "C-x v") 'viper-mode)
(global-set-key (kbd "C-S-e") 'new-esh)

;; Lisp interaction mode
(define-key lisp-interaction-mode-map (kbd "C-e") 'eval-print-last-sexp)

;; Special movement minor mode
;; Like vi, but C-hjkl
(defvar mv-map (make-sparse-keymap) "Special movement keymap")
(define-key mv-map (kbd "C-h") 'backward-char)
(define-key mv-map (kbd "C-k") 'previous-line)
(define-key mv-map (kbd "C-j") 'next-line)
(define-key mv-map (kbd "C-l") 'forward-char)
(define-key mv-map (kbd "C-S-k") 'kill-line)
(define-key mv-map (kbd "C-S-l") 'forward-word)
(define-key mv-map (kbd "C-S-h") 'backward-word)
(define-key mv-map (kbd "M-h") 'beginning-of-line)
(define-key mv-map (kbd "M-l") 'end-of-line)

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
(load "~/.emacs.d/general")

;;Overwrite when region selected
(delete-selection-mode)

;;let dired use 'a'
(put 'dired-find-alternate-file 'disabled nil)

