#hide pos/1.
pos(0..8).
numero(1..9).

1{case(I,J,C):numero(C)}1 :- pos(I), pos(J).

%contrainte sur les lignes
:- case(I,J,C), case(I,J2,C), J!=J2, pos(I;J2;J), numero(C).

%contrainte sur les colonnes
:- case(I,J,C), case(I2,J,C), I!=I2, pos(I;I2;J), numero(C).

%contrainte sur les carres

carre(I1,J1,I2,J2) :- I1/3==I2/3, J1/3==J2/3, pos(I1;I2;J1;J2).
:- case(I1,J1,C), case(I2,J2,C), carre(I1,J1,I2,J2), I1!=I2, J1!=J2, numero(C), pos(I1;I2;J1;J2).
