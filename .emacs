(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["black" "#d55e00" "#009e73" "#f8ec59" "#0072b2" "#cc79a7" "#56b4e9" "white"])
 '(custom-enabled-themes (quote (tsdh-dark)))
 '(inhibit-startup-screen t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
;(setq initial-buffer-choice "~/Documents/programming/sig.txt")

(defvar autosave-dir (concat "~/.autosave" "/"))

;;C = control, M = meta, S = shift
;;Keybind resetting in progress
(global-set-key "\C-d" 'Control-X-prefix)
(global-set-key "\C-c" 'copy-region-as-kill)
(global-set-key "\C-x" 'kill-region)
(global-set-key "\C-v" 'yank)
(global-set-key "\C-z" 'undo)
(global-set-key "\C-q" 'save-buffers-kill-emacs)
(global-set-key "\C-a" 'write-named-file)
(global-set-key "\C-s" 'save-buffer)
(global-set-key "\C-f" 'isearch-forward)
(global-set-key "\M-f" 'query-replace)
(global-set-key "\C-o" 'find-file)
(global-set-key "\C-n" 'switch-to-buffer) 
(global-set-key "\M-q" 'delete-window)
(global-set-key "\M-d" 'split-window-vertically)
(global-set-key "\M-s" 'other-window)
(global-set-key (kbd "<C-right>") 'next-buffer)
(global-set-key (kbd "<C-left>") 'previous-buffer)
;;these are reversed for some reason
(global-set-key (kbd "<C-down>") 'scroll-up)
(global-set-key (kbd "<C-up>") 'scroll-down)
;;C-k is still kill line
;;C-l is still count lines

