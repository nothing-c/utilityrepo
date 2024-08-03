;; -*- lexical-binding:t -*-
(deftheme bernstein-schwarz
  "Nice monochrome theme")

(custom-theme-set-faces
 'bernstein-schwarz
 '(cursor ((t (:background "#e8a92c"))))
 '(default ((t (:background "#000000" :foreground "#e8a92c" :bold f))))
 '(font-lock-builtin-face ((t (:foreground "#e8a92c" :bold t))))
 '(font-lock-string-face ((t (:foreground "#e8a92c" :bold f))))
 '(font-lock-constant-face ((t (:foreground "#e8a92c"  :bold f))))
 '(font-lock-type-face ((t (:foreground "#e8a92c"  :bold f))))
 '(font-lock-function-name-face ((t (:foreground "#e8a92c" :bold t))))
 '(font-lock-variable-name-face ((t (:foreground "#e8a92c" :bold t))))
 '(font-lock-comment-face ((t (:foreground "#e8a92c"))))
 '(font-lock-keyword-face ((t (:foreground "#e8a92c"))))
 '(mode-line ((t (:background "#e8a92c" :foreground "#000000"))))
 '(hl-paren-face ((t (:weight bold))) t)
 '(ido-first-match ((t (:bold t :foreground "#e8a92c"))))
 '(mode-line-inactive ((t (:inherit mode-line))))
 '(highlight ((t (:background "#e8a92c"))))
 '(region ((t (:background "#e8c784" :foreground "#000000")))) ;;small compromise here so I can actually see what I'm doing
 '(hl-line ((t (:background "#e8a92c" :foreground "#000000"))))
 )

(provide-theme 'bernstein-schwarz)
