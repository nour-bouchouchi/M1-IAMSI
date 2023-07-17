(define (domain blockWorld)
  (:requirements :strips :typing)
  (:types block)
  (:predicates
    (on ?x - block ?y - block)
    (ontable ?x - block)
    (clear ?x - block)
    (handempty)
    (holding ?x - block))
  (:action pick-up
    ;;; action qui ramasse un bloc pose sur la table
    :parameters (?x - block)
    :precondition (and (clear ?x) (ontable ?x) (handempty))
    :effect (and (not (ontable ?x))
            (not (clear ?x))
            (not (handempty))
            (holding ?x)))
  (:action unstack
    ;;; action qui ramasse un bloc pose sur un autre
    :parameters (?x - block ?y - block)
    :precondition (and (clear ?x) (on ?x ?y) (handempty))
    :effect (and (not (on ?x ?y))
            (not (clear ?x))
            (not (handempty))
            (holding ?x)
            (clear ?y)))
  (:action put-down
    ;;; action qui pose un bloc sur la table
    :parameters (?x - block)
    :precondition (holding ?x)
    :effect (and (not (holding ?x))
            (clear ?x)
            (handempty)
            (ontable ?x)))
  (:action stack
    ;;; action qui pose un bloc sur un autre
    :parameters (?x - block ?y - block)
    :precondition (and (holding ?x) (clear ?y))
    :effect (and (not (holding ?x))
            (not (clear ?y))
            (clear ?x)
            (handempty)
            (on ?x ?y))))
