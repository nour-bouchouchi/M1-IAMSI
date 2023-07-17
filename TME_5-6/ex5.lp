#hide maison/1.
#hide nationalite/1.
#hide boisson/1.
#hide cigarettes/1.
#hide animal/1.
#hide position/1.
#hide s/2.

maison(rouge;verte;blanche;jaune;bleue).
nationalite(britannique;suedois;danois;norvegien;allemand).
boisson(the;cafe;lait;biere;eau).
cigarettes(pall_mall;dunhill;blend;bluemaster;princess).
animal(chien;oiseaux;chats;chevaux;poissons).
position(1..5).


% ---------------- Les contraintes d'unicité ----------------

% Pour chaque position il n'y a qu'une seule maison associée, mais aussi qu'une seule nationalité, boisson, marque de cigarettes et un seul animal.
1 {s(M,P) : maison(M)} 1 :- position(P).
1 {s(N,P) : nationalite(N)} 1 :- position(P).
1 {s(B,P) : boisson(B)} 1 :- position(P).
1 {s(C,P) : cigarettes(C)} 1 :- position(P).
1 {s(A,P) : animal(A)} 1 :- position(P).

% Aucun d’entre eux ne possède le même animal qu’un autre, ne boit la même boisson ou ne fume la même marque de cigarettes.
:- s(M,P1), s(M,P2), P1!=P2, position(P1;P2), maison(M).
:- s(N,P1), s(N,P2), P1!=P2, position(P1;P2), nationalite(N).
:- s(B,P1), s(B,P2), P1!=P2, position(P1;P2), boisson(B).
:- s(C,P1), s(C,P2), P1!=P2, position(P1;P2), cigarettes(C).
:- s(A,P1), s(A,P2), P1!=P2, position(P1;P2), animal(A).


% ---------------- La liste des 15 contraintes ----------------

:- s(rouge,P1), s(britannique,P2), P1!=P2, position(P1;P2).
:- s(suedois,P1), s(chien,P2), P1!=P2, position(P1;P2).
:- s(danois,P1), s(the,P2), P1!=P2, position(P1;P2).
s(verte,P1) :- s(blanche,P2), P1==P2-1, position(P1;P2).
:- s(verte,P1), s(cafe,P2), P1!=P2, position(P1;P2).
:- s(pall_mall,P1), s(oiseaux,P2), P1!=P2, position(P1;P2).
:- s(jaune,P1), s(dunhill,P2), P1!=P2, position(P1;P2).
s(lait,3).
s(norvegien,1).
:- s(blend,P1), s(chats,P2), P1!=P2+1, P1!=P2-1, position(P1;P2).
:- s(chevaux,P1), s(dunhill,P2), P1!=P2+1, P1!=P2-1, position(P1;P2).
:- s(bluemaster,P1), s(biere,P2), P1!=P2, position(P1;P2).
:- s(allemand,P1), s(princess,P2), P1!=P2, position(P1;P2).
:- s(norvegien,P1), s(bleue,P2), P1!=P2+1, P1!=P2-1, position(P1;P2).
:- s(blend,P1), s(eau,P2), P1!=P2+1, P1!=P2-1, position(P1;P2).


% ---------------- L'unique solution trouvée ----------------

solution(P,M,N,B,C,A) :- s(M,P), s(N,P), s(B,P), s(C,P), s(A,P), maison(M), nationalite(N), boisson(B), cigarettes(C), animal(A).

% 1 jaune norvegien eau dunhill chats
% 2 bleue danois the blend chevaux
% 3 rouge britannique lait pall_mall oiseaux
% 4 verte allemand cafe princess poissons
% 5 blanche suedois biere bluemaster chien
