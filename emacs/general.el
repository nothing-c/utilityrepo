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

(defun nab-file (filelist)
  "Helper function for open-dir"
  (find-file (car filelist))
  (nab-file (cdr filelist)))

(defun open-dir ()
  "Open the entire contents of a directory"
  (interactive)
  (setq dir (read-string "Dir: "))
  (setq files (directory-files dir))
  (nab-file files))

(defun tmp-macs ()
  "Spawn new emacs for possibly risky operations"
  (interactive)
  (with-temp-buffer)
  (shell-command "emacs &"))

(defun status ()
  "Emacs status report"
  (interactive)
  (insert (concat (shell-command-to-string "date") (battery) "\n" (emacs-uptime) "\n" (emacs-version) "\n")))

(defun html-nc ()
  (interactive)
  (insert (concat "<!DOCTYPE html>\n<style>body {background-color: #262625;color: white; font-family: arial; font-size: 120%}p,h1,h2 {color: white; font-family: arial; font-size: 120%}a:link {color: #d468d4}a:visited {color: #d69fd6}</style>\n" "<title>\n</title>\n" "<h1>\n</h1>\n" "<body>\n<p>\n</p></body>\n</html>\n")))

(defun g-re-rep ()
  "Fast global regex replace"
  (interactive)
  (let ((re (read-string "Regex: ")) (rep (read-string "Replacement: ")))
    (while (re-search-forward re)
      (replace-match rep))))
