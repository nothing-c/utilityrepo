;; NCkey minor mode

;; Functions
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

(defun esh-buf ()
  "Quick eshell buffer"
  (interactive)
  (split-window-vertically)
	(eshell))

;;C = control, M = meta, S = shift
;;Keybind resetting in progress
;;Maybe use <double-mouse-(1,2,3)> for something?
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
(define-key nc-keymap (kbd "C-d v") 'viper-mode)
(define-key nc-keymap (kbd "C-d b") 'viper-go-away)
;;acme-type stuff here
(define-key nc-keymap (kbd "<C-down-mouse-1>") 'copy-region-as-kill)
(define-key nc-keymap (kbd "<C-down-mouse-2>") 'kill-region)
(define-key nc-keymap (kbd "<C-down-mouse-3>") 'yank)
;;don't use these, they don't work
;;(define-key nc-keymap (kbd "<C-mouse-1>") 'copy-region-as-kill)
;;(define-key nc-keymap (kbd "<C-mouse-2>") 'yank)
;;(define-key nc-keymap (kbd "<C-mouse-3>") 'kill-region)
;;c-d e[macs]
(define-key nc-keymap (kbd "C-d e") 'tmp-macs)
;;c-d t[erminal]
(define-key nc-keymap (kbd "C-d t") 'esh-buf)

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


