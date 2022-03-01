;;General elisp snippets and functions that don't need their own file
(defun ncirc ()
  "async irc function"
  ()
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
