#const n=8.
#hide pos/1.

pos(1..n).

%question 1 : pour n=4 on a 256 modèles.
1{queen(I,J):pos(J)}1 :- pos(I).

%question 2 : pour n=4 il reste 24 modèles.
:- queen(I,J), queen(L,J), I!=L, pos(I;L;J).

%question 3 : pour n=4 il reste 2 modèles. 
%pour n=8 on trouve 92 modèles.
:- queen(I,J), queen(I2,J2), I!=I2, J!=J2, I-I2==J-J2, pos(I;J;I2;J2).
:- queen(I,J), queen(I2,J2), I!=I2, J!=J2, I2-I==J-J2, pos(I;J;I2;J2).

%question 4 :
queen(1,1).

%Answer: 1
%queen(1,1) queen(8,5) queen(7,2) queen(6,4) queen(5,7) queen(4,3) queen(3,8) queen(2,6)
%Answer: 2
%queen(1,1) queen(8,3) queen(7,5) queen(6,2) queen(5,8) queen(4,6) queen(3,4) queen(2,7)
%Answer: 3
%queen(1,1) queen(8,4) queen(7,2) queen(6,7) queen(5,3) queen(4,6) queen(3,8) queen(2,5)
%Answer: 4
%queen(1,1) queen(8,3) queen(7,6) queen(6,4) queen(5,2) queen(4,8) queen(3,5) queen(2,7) 

%question 5 : 
:- queen(4,4).

%Si on considère encore qu'il y a une reine en coordonnées (1,1) : 
%Answer: 1
%queen(1,1) queen(8,5) queen(7,2) queen(6,4) queen(5,7) queen(4,3) queen(3,8) queen(2,6)
%Answer: 2
%queen(1,1) queen(8,3) queen(7,5) queen(6,2) queen(5,8) queen(4,6) queen(3,4) queen(2,7)
%Answer: 3
%queen(1,1) queen(8,4) queen(7,2) queen(6,7) queen(5,3) queen(4,6) queen(3,8) queen(2,5)
%Answer: 4
%queen(1,1) queen(8,3) queen(7,6) queen(6,4) queen(5,2) queen(4,8) queen(3,5) queen(2,7) 

%Sinon on trouve 84 solutions
