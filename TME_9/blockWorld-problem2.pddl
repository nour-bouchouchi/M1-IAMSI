(define (problem blockProblem)
  (:domain blockWorld)
  (:objects A B C D E F - block)
  (:init (ontable A)
         (on B A)
         (on C B)
         (on D C)
         (on E D)
         (on F E)
         (clear F)
         (handempty))
  (:goal (and (ontable F)
         (on A B) 
         (on B C) 
         (on C D)
         (on D E)
         (on E F)
         (clear A) 
         (handempty))))