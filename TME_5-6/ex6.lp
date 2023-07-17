#const ne = 2.
#const ns = 2.
#const nj = ns*2.

#hide equipe/1.
#hide jour/1.

equipe(1..ne).
jour(1..nj).

% -----------------------------------------------------------------------------------------------------------------------------
% ---------- Toutes les équipes affrontent toutes les autres équipes (une fois à domicile et une fois à l'extérieur) ---------- 
% -----------------------------------------------------------------------------------------------------------------------------

% Une équipe ne joue jamais contre elle-même.
:- match(J,E,E), jour(J), equipe(E).

% Une équipe joue ne-1 matchs à domicile (contre toutes les autres équipes)
(ne-1){match(J,E1,E2):jour(J):equipe(E2)}(ne-1) :- equipe(E1).

% Une équipe joue ne-1 matchs à l'extérieur (contre toutes les autres équipes)
(ne-1){match(J,E2,E1):jour(J):equipe(E2)}(ne-1) :- equipe(E1).


% --------------------------------------------------------------------------------------------------------------------------
% ---------- Toutes les équipes s'affrontent exactement deux fois (une fois à domicile et une fois à l'extérieur) ---------- 
% --------------------------------------------------------------------------------------------------------------------------

% Si une équipe joue un match à domicile contre une équipe, elle jouera un match à l'extérieur contre cette même équipe.
1{match(J2,E2,E1) : jour(J2)}1 :- match(J1,E1,E2), equipe(E1;E2), jour(J1).


% ----------------------------------------------------------------
% ---------- Une équipe joue au plus un match par jour -----------
% ----------------------------------------------------------------

:- match(J,E1,E2), match(J,E3,E1), equipe(E1;E2;E3), jour(J).
:- match(J,E1,E2), match(J,E1,E3), equipe(E1;E2;E3), E2!=E3, jour(J).
:- match(J,E2,E1), match(J,E3,E1), equipe(E1;E2;E3), E2!=E3, jour(J).

% --------------------------------
% ---------- Résultats -----------
% --------------------------------

% Nos solutions se présentent sous la forme match(J,E1,E2) où :
%	- J est le jour du match
%	- E1 est l'équipe qui joue à domicile
%	- E2 est l'équipe qui joue à l'extérieur
%	
% Par exemple, pour deux équipes et 2 semaines, on trouve : 
% Answer: 1
% match(1,2,1) match(4,1,2) 
% Answer: 2
% match(2,2,1) match(4,1,2) 
% Answer: 3
% match(3,2,1) match(4,1,2) 
% Answer: 4
% match(1,2,1) match(3,1,2) 
% Answer: 5
% match(2,2,1) match(3,1,2) 
% Answer: 6
% match(4,2,1) match(3,1,2) 
% Answer: 7
% match(1,2,1) match(2,1,2) 
% Answer: 8
% match(3,2,1) match(2,1,2) 
% Answer: 9
% match(4,2,1) match(2,1,2) 
% Answer: 10
% match(2,2,1) match(1,1,2) 
% Answer: 11
% match(3,2,1) match(1,1,2) 
% Answer: 12
% match(4,2,1) match(1,1,2) 
% 
% Ce résultat est cohérent puisque pour deux équipes il faudra jouer deux matchs et qu'il y a en tout 6 combinaisons de jours. 
