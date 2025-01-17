(defun nc-intern (x)
  "Intern a string s as run-x"
  (intern (concat "run-" x)))

(defvar nc-assoc
  '(("excel" . "C:\\Program Files\\Microsoft Office\\root\\Office16\\EXCEL.EXE")
    ("word" . "C:\\Program Files\\Microsoft Office\\root\\Office16\\WINWORD.EXE")
    ))

(defun nc-make-fn (x)
  "Make a function to run an external command from alist"
  `(defun ,(nc-intern (car x)) ,'() (interactive) (async-shell-command ,(cdr x))))

(defmacro nc-externals (fnassoc)
  "From alist fnassoc, make each into an Elisp command to run that command as an async external process"
  `(mapc (lambda (x) (eval (nc-make-fn x))) ,fnassoc))
