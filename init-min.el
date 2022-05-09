;; More minimal init.el, closer to stock emacs
;; Includes CUA mode for keeping context breakage low
(package-initialize)

(custom-set-variables
 '(ansi-color-names-vector
   ["black" "#d55e00" "#009e73" "#f8ec59" "#0072b2" "#cc79a7" "#56b4e9" "white"])
 '(custom-enabled-themes (quote (tsdh-dark)))
 '(inhibit-startup-screen t)
(custom-set-faces)

(setq initial-buffer-choice "~/")
(setq default-tab-width 4)
(setq tab-always-indent t)
(setq indent-line-function 'tab-to-tab-stop)
;; enable as necessary
;;(setq mouse-autoselect-window t)

;; functions
(defun esh-buf ()
  "Quick eshell buffer"
  (interactive)
  (split-window-vertically)
	(eshell))

;; hooks
(add-hook 'text-mode-hook
          (lambda ()
            (define-key text-mode-map "\t" 'tab-to-tab-stop)))

;; keymaps
(global-set-key (kbd "C-x t") 'esh-buf)
(global-set-key (kbd "C-x e") 'tmp-macs)
(global-set-key (kbd "<home>") 'menu-bar-open)
(global-set-key (kbd "<C-down-mouse-1>") 'copy-region-as-kill)
(global-set-key (kbd "<C-down-mouse-2>") 'kill-region)
(global-set-key (kbd "<C-down-mouse-3>") 'yank)

;; etc
(provide 'cua-mode)
(delete-selection-mode)

(load "~/.emacs.d/general")
