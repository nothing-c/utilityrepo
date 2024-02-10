;;(compose foo bar baz x) -> (foo (bar (baz x))) (i.e., foo . bar . baz x)
(defun compose (x) (if (= (length x) 2) x (list (car x) (compose (cdr x)))))
(defmacro comp (x) (compose x))

;;(comp (print car '(2 3 1))) ;; -> 2
;;(compose '(1 2 3 4)) ;; -> (1 (2 (3 4)))

;; https://rogerhub.com/~r/final/formula.pdf
;;current grade desired grade exam weight
(defun f (c d w) (/ (- d (* c (- 1 w))) w))
