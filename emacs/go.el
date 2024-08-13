;; Assorted golang utility functions
(fset 'go-import
   (kmacro-lambda-form [?\M-< ?\C-s ?i ?m ?p ?o ?r ?t return ?\C-\M-f ?\C-k ?\C-e return] 0 "%d"))
;; runs as M-x go-i

(defun go-boiler ()
  (interactive)
  (insert (concat "package main\n\n" "import (\n\n)\n\n" "func main() {\n\n\}")))
;; runs as m-x go-b

(defun go-err ()
  (interactive)
  (insert "; if e!=nil { panic(e) }"))
