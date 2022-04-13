;;General elisp snippets and functions that don't need their own file
(defun ncirc ()
  "async irc function"
  (interactive)
  (start-process "irc" "irc" (erc))) ;;working uwu

;;working
(defun list-kills ()
  "List contents of kill ring"
  (interactive)
  (with-output-to-temp-buffer "killring"
  (setq k 0)
   (while (< k (length kill-ring))
     (setq i 0)
     (setq str "")
     (while (< i (length (nth k kill-ring)))
       (setq ch (byte-to-string (elt (nth k kill-ring) i)))
       (setq str (concat str ch))
       (setq i (+ i 1))
       )
     (print str)
     (setq k (+ k 1))))
  )

(defun expand ()
  "Create a new window, open eshell"
  (interactive)
  (if (window-system)
      ;;Double the size of the window
      (set-frame-width (selected-frame) 160))
    ;;create new window and switch
    (split-window-horizontally)
    (other-window 1)
    (eshell))

(defun retract ()
  "Delete second window, go back to standard width"
  (interactive)
  (if (window-system)
      (set-frame-width (selected-frame) 80))
  (delete-window))
