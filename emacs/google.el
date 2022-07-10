;; Google function for emacs
;; Yeah, it's not difficult, shut up

(defun google ()
  "Quick google function (you will need to substitute spaces with '+'"
  (interactive)
  (let ((search (read-string "Google:")))
    (eww (concat "https://www.google.com/search?&q=" search))))
