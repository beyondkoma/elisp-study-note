

;; 'append-to-buffer
(defun append-to-buffer (buffer start end)
       "Append to specified buffer the text of the region.
     It is inserted into that buffer before its point.
     When calling from a program, give three arguments:
     BUFFER (or buffer name), START and END.
     START and END specify the portion of the current buffer to be copied."
       (interactive
        (list (read-buffer "Append to buffer: " (other-buffer
                                                 (current-buffer) t))
              (region-beginning) (region-end)))
       (let ((oldbuf (current-buffer)))
         (save-excursion
           (let* ((append-to (get-buffer-create buffer))
                  (windows (get-buffer-window-list append-to t t))
                  point)
             (set-buffer append-to)
             (setq point (point))
             (barf-if-buffer-read-only)
             (insert-buffer-substring oldbuf start end)
             (dolist (window windows)
               (when (= (window-point window) point)
                 (set-window-point window (point))))))))

;; 'insert-buffer
(defun insert-buffer (buffer)
       "Insert after point the contents of BUFFER.
     Puts mark after the inserted text.
     BUFFER may be a buffer or a buffer name."
       (interactive "*bInsert buffer: ")
       (or (bufferp buffer)
           (setq buffer (get-buffer buffer)))
       (let (start end newmark)
         (save-excursion
           (save-excursion
             (set-buffer buffer)
             (setq start (point-min) end (point-max)))
           (insert-buffer-substring buffer start end)
           (setq newmark (point)))
         (push-mark newmark)))


;; beginning-of-buffer
(defun beginning-of-buffer (&optional arg)
       "Move point to the beginning of the buffer;
     leave mark at previous position.
     With \\[universal-argument] prefix,
     do not set mark at previous position.
     With numeric arg N,
     put point N/10 of the way from the beginning.

     If the buffer is narrowed,
     this command uses the beginning and size
     of the accessible part of the buffer.

     Don't use this command in Lisp programs!
     \(goto-char (point-min)) is faster
     and avoids clobbering the mark."
       (interactive "P")
       (or (consp arg)
           (and transient-mark-mode mark-active)
           (push-mark))
       (let ((size (- (point-max) (point-min))))
         (goto-char (if (and arg (not (consp arg)))
                        (+ (point-min)
                           (if (> size 10000)
                               ;; Avoid overflow for large buffer sizes!
                               (* (prefix-numeric-value arg)
                                  (/ size 10))
                             (/ (+ 10 (* size (prefix-numeric-value arg)))
                                10)))
                      (point-min))))
       (if arg (forward-line 1)))

;; what-line
(defun what-line ()
       "Print the current line number (in the buffer) of point."
       (interactive)
       (save-restriction
         (widen)
         (save-excursion
           (beginning-of-line)
           (message "Line %d"
                    (1+ (count-lines 1 (point)))))))







