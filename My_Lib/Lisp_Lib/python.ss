(define (range x)
 (define (from a)
  (if (> a x) 
   '()
   (cons a (from (+ a 1)))))
 (from 1))