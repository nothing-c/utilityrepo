;; Function to open a given buffer (preferably HTML) in EWW

(defun preview-buf ()
  "Preview HTML buffer in EWW"
  (interactive)
  (eww-open-file (buffer-name)))
