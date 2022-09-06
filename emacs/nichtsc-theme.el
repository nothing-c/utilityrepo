;; -*- lexical-binding:t -*-
(deftheme nichtsc
  "Nothing-C's personal theme")

(custom-theme-set-faces
 'nichtsc
 '(cursor ((t (:background "#ac3333"))))
 '(default ((t (:background "#e8d9c6" :foreground "#af1e16" :bold f))))
 '(font-lock-builtin-face ((t (:foreground "#590f00" :bold t))))
 '(font-lock-string-face ((t (:foreground "#007a00" :bold f))))
 '(font-lock-constant-face ((t (:foreground "#590f00"  :bold f))))
 '(font-lock-type-face ((t (:foreground "#590f00"  :bold f))))
 '(font-lock-function-name-face ((t (:foreground "#960000" :bold t))))
 '(font-lock-variable-name-face ((t (:foreground "#7a4436" :bold t))))
 '(mode-line ((t (:background "#af1e16" :foreground "#fae4c8"))))
 '(highlight ((t (:background "#b7524d"))))
 '(region ((t (:background "#ccb2b1"))))
 '(hl-line ((t (:background "#e0d0bb"))))
 '(hl-paren-face ((t (:weight bold))) t)
 '(ido-first-match ((t (:foreground "#007a00" :bold t))))
 '(show-paren-match ((t (:background "#93c47d"))))
 '(show-paren-mismatch ((t (:background "#8e7cc3"))))
 )

(provide-theme 'nichtsc)
