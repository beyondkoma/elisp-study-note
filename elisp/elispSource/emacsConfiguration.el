
;; defcustom
(defcustom text-mode-hook nil
       "Normal hook run when entering Text mode and many related modes."
       :type 'hook
       :options '(turn-on-auto-fill flyspell-mode)
       :group 'data)

  ;;; Text mode and Auto Fill mode
     ;; The next two lines put Emacs into Text mode
     ;; and Auto Fill mode, and are for writers who
     ;; want to start writing prose rather than code.
     (setq-default major-mode 'text-mode)
     (add-hook 'text-mode-hook 'turn-on-auto-fill)

