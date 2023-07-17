(define (domain planeWorld)
  (:requirements :strips :typing)
  (:types plane cargo airport)
  (:predicates
    (vide ?x - plane)
    (situeP ?x - plane ?y - airport)
    (situeC ?x - cargo ?y - airport)
    (dans ?x - cargo ?y - plane)
    )
  (:action charger
  ;;; action qui charge une cargaison x dans un avion y situé à l'aéroport z
  :parameters (?x - cargo ?y - plane ?z - airport)
  :precondition (and (vide ?y)
                (situeC ?x ?z)
                (situeP ?y ?z))
  :effect (and (dans ?x ?y)
          (not (vide ?y))
          (not (situeC ?x ?z)))
  )
  (:action decharger
  ;;; action qui decharge une cargaison x se trouvant dans un avion y à l'aéroport z
  :parameters (?x - cargo ?y - plane ?z - airport)
  :precondition (and (dans ?x ?y) 
                     (situeP ?y ?z))
  :effect (and (vide ?y)
          (situeC ?x ?z)
          (not (dans ?x ?y)))
  )
  (:action voler
  ;;; action qui fait voler un avion x de l'aéroport y à l'aéroport z
  :parameters (?x - plane ?y - airport ?z - airport)
  :precondition (situeP ?x ?y)
  :effect (and (situeP ?x ?z)
          (not (situeP ?x ?y)))
  )
)
