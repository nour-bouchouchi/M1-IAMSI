%-------------------------------------------------------%
%-------------- Représentation des objets --------------%
%-------------------------------------------------------%

#const last_time = 12.

#hide cargaison/1.
#hide avion/1.
#hide aeroport/1.
#hide time/1.
#hide holds/2.
#hide -holds/2.

%------------------------------------------------------%
%-------------- Représentation des états --------------%
%------------------------------------------------------%

cargaison(c1;c2;c3).
avion(a1;a2).
aeroport(teg;cdg;bar).
time(0..last_time).

holds(situe(c1,teg),0).
holds(situe(c2,teg),0).
holds(situe(c3,teg),0).
holds(situe(a1,teg),0).
holds(situe(a2,teg),0).
holds(vide(a1),0).
holds(vide(a2),0).

%---------------------------------------------------%
%-------------- Représentation du but --------------%
%---------------------------------------------------%

:- not holds(situe(c1,bar),last_time).
:- not holds(situe(c2,bar),last_time).
:- not holds(situe(c3,bar),last_time).
:- not holds(situe(a1,cdg),last_time).
:- not holds(situe(a2,cdg),last_time).

%-------------------------------------------------------%
%-------------- Programmation des actions --------------%
%-------------------------------------------------------%

%-------------- Préconditions --------------%
:- action(charger(C,A,L),T), not holds(vide(A),T), cargaison(C), avion(A), aeroport(L), time(T), T<last_time.
:- action(charger(C,A,L),T), not holds(situe(C,L),T), cargaison(C), avion(A), aeroport(L), time(T), T<last_time.
:- action(charger(C,A,L),T), not holds(situe(A,L),T), cargaison(C), avion(A), aeroport(L), time(T), T<last_time.

:- action(decharger(C,A,L),T), not holds(dans(C,A),T), cargaison(C), avion(A), aeroport(L), time(T), T<last_time.
:- action(decharger(C,A,L),T), not holds(situe(A,L),T), cargaison(C), avion(A), aeroport(L), time(T), T<last_time.

:- action(voler(A,L1,L2),T), not holds(situe(A,L1),T), avion(A), aeroport(L1;L2), time(T), T<last_time.


%-------------- Add --------------%

holds(dans(C,A),T+1) :- action(charger(C,A,L),T), time(T+1), T+1<last_time.

holds(vide(A),T+1) :- action(decharger(C,A,L),T), time(T+1).
holds(situe(C,L),T+1) :- action(decharger(C,A,L),T), time(T+1).

holds(situe(A,L2),T+1) :- action(voler(A,L1,L2),T), time(T+1).

%-------------- Del --------------%

- holds(vide(A),T+1) :- action(charger(C,A,L),T), time(T+1).
- holds(situe(C,L),T+1) :- action(charger(C,A,L),T), time(T+1).

- holds(dans(C,A),T+1) :- action(decharger(C,A,L),T), time(T+1).

- holds(situe(A,L1),T+1) :- action(voler(A,L1,L2),T), time(T+1).


%-------------------------------------------------------%
%----------------------- Inertie -----------------------%
%-------------------------------------------------------%

holds(vide(A),T+1) :- holds(vide(A),T), not -holds(vide(A),T+1), avion(A), time(T;T+1), T<last_time.
-holds(vide(A),T+1) :- -holds(vide(A),T), not holds(vide(A),T+1), avion(A), time(T;T+1), T<last_time.

holds(situe(C,L),T+1) :- holds(situe(C,L),T), not -holds(situe(C,L),T+1), cargaison(C), aeroport(L), time(T;T+1), T<last_time.
-holds(situe(C,L),T+1) :- -holds(situe(C,L),T), not holds(situe(C,L),T+1), cargaison(C), aeroport(L), time(T;T+1), T<last_time.

holds(situe(A,L),T+1) :- holds(situe(A,L),T), not -holds(situe(A,L),T+1), avion(A), aeroport(L), time(T;T+1), T<last_time.
-holds(situe(A,L),T+1) :- -holds(situe(A,L),T), not holds(situe(A,L),T+1), avion(A), aeroport(L), time(T;T+1), T<last_time.

holds(dans(C,A),T+1) :- holds(dans(C,A),T), not -holds(dans(C,A),T+1), cargaison(C), avion(A), time(T;T+1), T<last_time.
-holds(dans(C,A),T+1) :- -holds(dans(C,A),T), not holds(dans(C,A),T+1), cargaison(C), avion(A), time(T;T+1), T<last_time.

%-------------------------------------------------------%
%--------------------- Contraintes ---------------------%
%-------------------------------------------------------%

:- holds(situe(A,L1),T), holds(situe(A,L2),T), L1 != L2, avion(A), aeroport(L1;L2), time(T).
:- holds(dans(C,A1),T), holds(dans(C,A2),T), A1 != A2, avion(A1;A2), cargaison(C), time(T).

%-------------------------------------------------------%
%--------------------- Génération ----------------------%
%-------------------------------------------------------%

1{action(charger(C,A,L),T) : cargaison(C) : avion(A) : aeroport(L) , 
action(decharger(C,A,L),T) : cargaison(C) : avion(A) : aeroport(L) ,
action(voler(A,L1,L2),T) : avion(A) : aeroport(L1;L2)}1 
:- time(T), T<last_time. 



%-------------------------------------------------------%
%--- Test 1 : en 2 étapes un avion vole de teg à cdg ---%
%-------------------------------------------------------%

%Answer: 1
%action(voler(a1,teg,cdg),1) action(charger(c3,a1,teg),0) 
%Answer: 2
%action(voler(a1,teg,cdg),1) action(charger(c2,a1,teg),0) 
%Answer: 3
%action(voler(a1,teg,cdg),1) action(charger(c1,a1,teg),0) 
%Answer: 4
%action(voler(a1,teg,cdg),1) action(charger(c3,a2,teg),0) 
%Answer: 5
%action(voler(a1,teg,cdg),1) action(charger(c2,a2,teg),0) 
%Answer: 6
%action(voler(a1,teg,cdg),1) action(charger(c1,a2,teg),0) 
%Answer: 7
%action(voler(a1,bar,cdg),1) action(voler(a1,teg,bar),0) 
%Answer: 8
%action(charger(c3,a2,teg),1) action(voler(a1,teg,cdg),0) 
%Answer: 9
%action(charger(c2,a2,teg),1) action(voler(a1,teg,cdg),0) 
%Answer: 10
%action(charger(c1,a2,teg),1) action(voler(a1,teg,cdg),0) 
%Answer: 11
%action(voler(a2,teg,bar),1) action(voler(a1,teg,cdg),0) 
%Answer: 12
%action(voler(a2,teg,cdg),1) action(voler(a1,teg,cdg),0) 
%Answer: 13
%action(voler(a1,teg,cdg),1) action(voler(a2,teg,bar),0) 
%Answer: 14
%action(voler(a1,teg,cdg),1) action(voler(a2,teg,cdg),0) 
%SATISFIABLE

%Models      : 14    
%Time        : 0.000
%  Prepare   : 0.000
%  Prepro.   : 0.000
%  Solving   : 0.000


%-------------------------------------------------------%
%---------- Test 2 : le problème de l'énoncé -----------%
%-------------------------------------------------------%


%Models      : 5940  
%Time        : 0.800
%  Prepare   : 0.060
%  Prepro.   : 0.000
%  Solving   : 0.740

