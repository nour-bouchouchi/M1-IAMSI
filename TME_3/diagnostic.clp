;;; IAMSI 2023 : séance TME 3
;;; diagnostic.clp

(defrule my_init
    (initial-fact)
=>
	(watch facts)
	(watch rules)
	
	(assert (taches_rouges patient))
	(assert (peu_boutons patient))
	(assert (sensation_froid patient))
	(assert (forte_fevre patient))
	(assert (yeux_douloureux patient))
	(assert (amygdales_rouges patient))
	(assert (peau_pele patient))
	(assert (peau_seche patient))
)



;eruption_cutanee

(defrule eruption_cutanee1
	(peu_boutons ?personne)
=>
	(assert (eruption_cutanee ?personne))
)

(defrule eruption_cutanee2
	(beaucoup_boutons ?personne)
=>
	(assert (eruption_cutanee ?personne))
)


;exanthème
(defrule exantheme1
	(eruption_cutanee ?personne)
=>
	(assert	(exantheme ?personne))
)

(defrule exantheme2
	(taches_rouges ?personne)
=>
	(assert (exantheme ?personne))
)

;febrile
(defrule febrile1
	(forte_fievre ?personne)
=>
	(assert (febrile ?personne))
)

(defrule febrile2
	(sensation_froid ?personne)
=>
	(assert (febrile ?personne))
)


;signe_suspect
(defrule signe_suspect
	(amygdales_rouges ?personne)
	(taches_rouges ?personne)
	(peau_pele ?personne)
=>
	(assert (signe_suspect ?personne))
)
	
;rougeole
(defrule rougeole1
	(febrile ?personne)
	(yeux_douloureux ?personne)
	(exantheme ?personne)
=>
	(assert (rougeole ?personne))
)

(defrule rougeole2
	(signe_suspect ?personne)
	(forte_fievre ?personne)
=>
	(assert (rougeole ?personne))
)

;not_rougeole

(defrule not_rougeole
	(peu_fievre ?personne)
	(peu_boutons ?personne)
=>
	(assert (not_rougeole ?personne))
)

(defrule not_rougeole2
	(declare (salience -1000))
	(not_rougeole ?personne)
=>
	(retract rougeole ?personne)
)

;douleur

(defrule douleur1
	(yeux_douloureux ?personne)
=>
	(assert (douleur ?personne))
)

(defrule douleur2
	(dos_douloureux ?personne)
=>
	(assert (douleur ?personne))
)

;grippe
(defrule grippe
	(dos_douloureux ?personne)
	(febrile ?personne)
=>	
	(assert (grippe ?personne))
)

;rubeole_et_varicelle
(defrule rubeole_varicelle
	(not_rougeole ?personne)
=>
	(assert (possible_rubeole ?personne))
	(assert (possible_varicelle ?personne))
)



;varicelle

(defrule varicelle
	(possible_varicelle ?personne)
	(fortes_demangeaisons ?personne)
	(pustules ?personne)
=>
	(assert (varicelle ?personne))
)

;rubeole
(defrule rubeole
	(possible_rubeole ?personne)
	(peau_seche ?personne)
	(inflammation_ganglions ?personne)
	(not(pustules ?personne))
	(not(sensation_froid ?personne))
=>
	(assert (rubeole ?personne))
)











