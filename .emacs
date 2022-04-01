
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

;;remove stupid ~ files
(defun remove-tilde ()
  "Remove dumb tilde files"
  (with-temp-buffer)
  (shell-command (concat "cd " default-directory " ; rm *~"))
  (shell-command "rm .*~")
  )

;;make ~ files autodelete
(defun full-quit ()
  "Remove tilde files and quit"
  (interactive)
  (remove-tilde)
  (save-buffers-kill-emacs)
  )

;;fix text-mode tab behavior
(add-hook 'text-mode-hook
          (lambda ()
            (define-key text-mode-map "\t" 'tab-to-tab-stop)))

;;C = control, M = meta, S = shift
;;Keybind resetting in progress
(defvar nc-keymap (make-sparse-keymap) "Keymap for stuff")
(define-key nc-keymap (kbd "C-d") 'Control-X-prefix)
(define-key nc-keymap (kbd "C-e") 'mode-specific-command-prefix)
(define-key nc-keymap (kbd "<home>") 'menu-bar-open)
(define-key nc-keymap (kbd "C-c") 'copy-region-as-kill)
(define-key nc-keymap (kbd "C-x") 'kill-region)
(define-key nc-keymap (kbd "C-v") 'yank)
(define-key nc-keymap (kbd "C-z") 'undo)
(define-key nc-keymap (kbd "C-q") 'full-quit)
(define-key nc-keymap (kbd "C-a") 'saveas)
(define-key nc-keymap (kbd "C-s") 'save-buffer)
;; These two can be switched -- regex search doesn't highlight smh
(define-key nc-keymap (kbd "C-f") 'isearch-forward)
(define-key nc-keymap (kbd "C-S-f") 're-search-forward)
(define-key nc-keymap (kbd "M-f") 'query-replace)
(define-key nc-keymap (kbd "C-o") 'find-file)
(define-key nc-keymap (kbd "C-n")'switch-to-buffer) 
(define-key nc-keymap (kbd "M-q") 'delete-window)
(define-key nc-keymap (kbd "M-d") 'split-window-horizontally)
(define-key nc-keymap (kbd "M-a") 'split-window-vertically)
(define-key nc-keymap (kbd "M-s") 'other-window)
(define-key nc-keymap (kbd "<C-right>") 'next-buffer)
(define-key nc-keymap (kbd "<C-left>") 'previous-buffer)
;these are reversed for some reason
(define-key nc-keymap (kbd "<C-down>") 'scroll-up)
(define-key nc-keymap (kbd "<C-up>") 'scroll-down)
(define-key nc-keymap (kbd "<M-right>") 'enlarge-window-horizontally)
(define-key nc-keymap (kbd "<M-left>") 'shrink-window-horizontally)
(define-key nc-keymap (kbd "<M-v>") 'viper-mode)
(define-key nc-keymap (kbd "<M-b>") 'viper-go-away)
;;acme-type stuff here
(define-key nc-keymap (kbd "<C-down-mouse-1>") 'copy-region-as-kill)
(define-key nc-keymap (kbd "<C-down-mouse-2>") 'yank)
(define-key nc-keymap (kbd "<C-down-mouse-3>") 'kill-region)
;;(define-key nc-keymap (kbd "<C-mouse-1>") 'copy-region-as-kill)
;;(define-key nc-keymap (kbd "<C-mouse-2>") 'yank)
;;(define-key nc-keymap (kbd "<C-mouse-3>") 'kill-region)


(define-minor-mode nckey-mode
  "Use a halfway-decent keymap, btfo Stallman"
  :global t
  :init-value t
  :lighter " NCSOFT"
  :keymap nc-keymap  
)
(add-to-list 'emulation-mode-map-alists
             `((nckey-mode . ,nc-keymap)))
(provide 'nckey-mode)

;;load general snippets
(load "~/.emacs.d/general")

;;Overwrite when region selected
(delete-selection-mode)
