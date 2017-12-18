(defun do_char (s c index depth scores garbage)
    (cond
      ((char= c #\!) (setq index (+ index 1)))
      (garbage
        (when (char= c #\>)
            (setq garbage nil)
        )
      )
      (t
       (cond
        ((char= c #\<) (setq garbage t))
        ((char= c #\{) 
          (setq depth (+ depth 1))
          (setq scores (cons depth scores))
        )
        ((char= c #\}) (setq depth (- depth 1)))
      ))
    )
    (process s (+ index 1) depth scores garbage)
  
)

(defun process (chars index depth scores garbage)
  (if (< index (length chars))
    (do_char chars (char chars index) index depth scores garbage)
    scores
  )
)

(defun main ()
  (print (format nil "Score is ~D" (apply '+ (process (read-line) 0 0 '() nil))))
  (terpri)
)
