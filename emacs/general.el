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
  (with-output-to-temp-buffer "*status*"
    (print (shell-command-to-string "date"))
    (print (battery))
    (print (concat "Uptime: " (emacs-uptime)))
    (print (emacs-version))))

(defun html-nc ()
  (interactive)
  (insert (concat "<!DOCTYPE html>\n<style>body {background-color: #262625;color: white; font-family: arial; font-size: 120%}p,h1,h2 {color: white; font-family: arial; font-size: 120%}a:link {color: #d468d4}a:visited {color: #d69fd6}</style>\n" "<title>\n</title>\n" "<h1>\n</h1>\n" "<body>\n<p>\n</p></body>\n</html>\n")))

(defun g-re-rep ()
  "Fast global regex replace"
  (interactive)
  (let ((re (read-string "Regex: ")) (rep (read-string "Replacement: ")))
    (while (re-search-forward re '() 1) ;;no error msg
      (replace-match rep))))
(defun google ()
  "Quick google function (you will need to substitute spaces with '+'"
  (interactive)
  (let ((search (read-string "Google:")))
    (eww (concat "https://www.google.com/search?&q=" search))))

(defun preview-buf ()
  "Preview HTML buffer in EWW"
  (interactive)
  (eww-open-file (buffer-name)))

(defun gopher ()
  "Nab gopher sites from Emacs"
  (interactive)
  (let ((serv (read-string "Server:")) (dir (read-string "Directory:")))
    (open-network-stream "goph" "*gopher*" serv 70)
    (process-send-string "goph" (concat dir "\n."))))

(defun hoogle ()
  "Quick Haskell hoogle (will need to substitute spaces with '+')"
  (interactive)
  (let ((search (read-string "Hoogle:")))
    (eww (concat "https://hoogle.haskell.org/?hoogle=" search))))

(defun me () "Eshell in new frame" (interactive) (select-frame (make-frame)) (eshell "N"))

(defun prep-space () "Open VC-mode and Dired for a folder in separate frames, creating the folder and initializing Git if it doesn't exist. Relative pathing used, repo is assumed to be initialized if the folder exists."
       (interactive)
       (let ((d (read-string "Dir: ")))
	 (cond ((file-directory-p d) (dired-other-frame d) (other-frame-prefix) (vc-dir "."))
	       (t (make-directory d) (eshell-command (concat "git init")) (dired-other-frame d) (other-frame-prefix) (vc-dir ".")))))
