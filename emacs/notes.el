(defvar notes) ;; List of notes
(defvar notefile "~/.emacs.d/note-list.el") ;; Location to be saved in

(defun add-note (note)
  "Add a note with a timestamp to the big list of random notes. Format: (timestamp . content)"
  (interactive "sNote: ")
  (setq notes (cons (cons (current-time-string) note) notes))
  (find-file notefile) ;; Write output so it stays between sessions
  (erase-buffer)
  (insert (concat "(setq notes \n'" (prin1-to-string notes) ")"))
  (save-buffer)
  (kill-buffer)
  (message "Note saved"))

(defun list-notes ()
  "List all the notes currently in existence"
  (interactive)
  (with-output-to-temp-buffer "*notes*"
    (mapcar #'princ
	    (mapcar (lambda (x) (concat (car x) ": " (cdr x) "\n")) notes))))

(defun init-notes ()
  "Initialize notes from file (throw this in your init.el)"
  (if (f-exists-p notefile)
      (progn (load-file notefile) (message "Notefile loaded"))
    (progn
      (setq notes '()) ;; Avoid errors
      (message "No notefile found, proceeding accordingly"))))
