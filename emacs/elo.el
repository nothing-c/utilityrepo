(defun elo-update (elo epts apts)
  "Determine the new Elo score according to points scored (1 = win, 0 = loss, 0.5 = draw)"
  (+ elo (* 32 (- apts epts))))		; K = 32, for now. Increase if too insensitive

(defun elo-predict (elo1 elo2)
  "Determine the elo1's expected score for a competition b/w elo1 & elo2"
  (/ 1.0 (+ 1.0 (expt 10.0 (/ (- elo2 elo1) 400.0)))))

(defmacro beats (x y)
  "X beats Y"
  `(setf ,x (elo-update ,x (elo-predict ,x ,y) 1))
  `(setf ,y (elo-update ,y (elo-predict ,y ,x) 0)))

(defmacro tie (x y)
  `(setf ,x (elo-update ,x (elo-predict ,x ,y) 0.5))
  `(setf ,y (elo-update ,y (elo-predict ,y ,x) 0.5)))

(defun pairs (x y)
  (if (eq x '())
      '()
    (cons (cons (car x) (car y)) (pairs (cdr x) (cdr y)))))

;; Starting Elo: 1000 (nice and round)
(defmacro init-elos (media &rest body)
"Bulk of the Elo work goes here"
  `(let ,(mapcar (lambda (x) `(,x 1000)) media)
     ,@body
     (cons (list ,@media)
	   (quote ,(list media))))) ; Tricky lil bastard

(defmacro eloize (media &rest body)
"With a list of 'matches' between things, determine the Elo scores"
  `(let ((outs (init-elos ,media ,@body)))
    (pairs (cadr outs) (car outs))))

;; (eloize (foo bar baz)
;; 	   (beats foo bar)
;; 	   (beats bar baz)
;; 	   (tie foo baz)
;; 	   (beats bar foo))		; yup!

(defun versus (t1 t2)
  "For a pre-defined Elo score DB *db*, compare the teams & return the expected winner"
  (if (> (cdr (assoc t1 *db*)) (cdr (assoc t2 *db*)))
      t1
    t2))
