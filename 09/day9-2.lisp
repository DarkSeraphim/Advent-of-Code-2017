(defun do_char (s c index depth score garbage)
    (cond
      ((char= c #\!) (setq index (+ index 1)))
      (garbage
        (if (char= c #\>)
            (setq garbage nil)
            (setq score (+ score 1))
        )
      )
      (t
       (cond
        ((char= c #\<) (setq garbage t))
        ((char= c #\{) 
          (setq depth (+ depth 1))
        )
        ((char= c #\}) (setq depth (- depth 1)))
      ))
    )
    (process s (+ index 1) depth score garbage)
  
)

(defun process (chars index depth score garbage)
  (if (< index (length chars))
    (do_char chars (char chars index) index depth score garbage)
    score
  )
)

(defun main ()
  (print (format nil "Garbage count is ~D" (process (read-line) 0 0 0 nil)))
  (terpri)
)
