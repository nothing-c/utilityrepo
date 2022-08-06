(defun hoogle ()
  "Quick Haskell hoogle (will need to substitute spaces with '+')"
  (interactive)
  (let ((search (read-string "Hoogle:")))
    (eww (concat "https://hoogle.haskell.org/?hoogle=" search))))
