;; Simple, easy gopher protocol fetcher
;; Note: do NOT use the gopher:// prefix, it is not necessary
(defun gopher ()
  "Nab gopher sites from Emacs"
  (interactive)
  (let ((serv (read-string "Server:")) (dir (read-string "Directory:")))
    (open-network-stream "goph" "*gopher*" serv 70)
    (process-send-string "goph" (concat dir "\n."))))
