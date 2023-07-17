#const n=4.
#hide couleur/1.
#hide sommet/1.
#hide arete/2.


% --------------- Modélisation ---------------
couleur(1..n).
sommet(1..7).
arete(1,2).
arete(1,3).
arete(1,5).
arete(2,3).
arete(2,4).
arete(2,6).
arete(3,4).
arete(3,5).
arete(3,6).
arete(4,5).
arete(4,6).
arete(5,6).
arete(5,7).
arete(6,7).

% --------------- Contraintes ---------------
1 {coloration(S,C) : couleur(C)} 1 :- sommet(S).

:- arete(A,B), coloration(A,C1), coloration(B,C2), A!=B, C1==C2, couleur(C1;C2), sommet(A;B).

% --------------- Résultats ---------------
% Avec le graphe de l'énoncé et quatre couleurs, on trouve 96 possibilités de coloration du graphe graphe.
% Par exemple, on peut colorer le graphe de la manière suivante (le premier argument étant le sommet et le deuxième la couleur) 
% coloration(7,1) coloration(6,4) coloration(5,3) coloration(4,1) coloration(3,2) coloration(2,3) coloration(1,1)
% Si l'on ne considère que trois couleurs (n=3), nous ne trouvons pas de solution pour ce graphe.
