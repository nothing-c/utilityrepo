;;function to dump in files for compilation
(defun comp (c files)
  (if (eq '() files)
      '()
    (shell-command (concat c " " (car files)))
    (comp c (cdr files))))

;;ex: (comp "cc" '("foo.c" "bar.c"))
;; and now you don't have to go outside
;; you *could* use M-x compile, but that doesn't work for me 

