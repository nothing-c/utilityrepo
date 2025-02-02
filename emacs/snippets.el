;;(compose foo bar baz x) -> (foo (bar (baz x))) (i.e., foo . bar . baz x)
(defun compose (x) (if (= (length x) 2) x (list (car x) (compose (cdr x)))))
(defmacro comp (x) (compose x))

;;(comp (print car '(2 3 1))) ;; -> 2
;;(compose '(1 2 3 4)) ;; -> (1 (2 (3 4)))

;; https://rogerhub.com/~r/final/formula.pdf
;;current grade desired grade exam weight
(defun f (c d w) (/ (- d (* c (- 1 w))) w))

;; Arithmetic if
(defun arif (expr neg zero pos)
    "Arithmetic IF, like in FORTRAN"
            (cond ((= 0 expr) zero)
                  ((< 0 expr) pos)
                  ((> 0 expr) neg)))

;; so I want
;; (map x (map y (map z l)))

;; to be
;; (nest l x y z)
;; If I put the list at the beginning, then it's not a super big deal
(defun nest-maps (initial fns)
  "Nest mapping functions (easier than doing it manually)"
  (if (eq (length fns) 1)
	  (mapcar (car fns) initial)
    (mapcar (car fns) (nest-maps initial (cdr fns)))))

;; (defun add-one (x)
;;   (+ x 1))

;; (nest-maps '(1 2 3) '(add-one add-one))	; => (3 4 5)

(defmacro nest (initial &rest fns)
  "Nest a set of functions within a set of MAPCARs; e.g. (nest l x y z) -> (map x (map y (map z l)))"
  (cons 'list (nest-maps initial fns)))

(defun binary-ops (x)
  (if (= (length x) 1)
      (car x)
    (list (nth 1 x) (car x) (binary-ops (cddr x)))))

(binary-ops '(1 + 2 + 3 - 5))		; darkriver-style (what I want)
(binary-ops '(5 - 3 + 2 + 1))		; APL-style

(defmacro binop (&rest x)
  (binary-ops x))

;; (binop 1 + 2 + 3 - 5)
