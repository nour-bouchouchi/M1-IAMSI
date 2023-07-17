import math
import numpy as np
import os

########################
###### Exercice 2 ######
########################

"""
Question 1
Il y a n_j * n_e (n_e - 1) variables propositionnelles.
En effet, chaque jour il peut y avoir n_e (n_e - 1) matchs possibles puisqu'il y a n_e équipes à domicile qui peuvent jouer contre les (n_e - 1) autres équipes qui joueront donc à l'extérieur.
"""


"""
Question 2
"""
def codage(ne, nj, j, x, y):
	return j*ne**2 + x*ne + y + 1


"""
Question 3
"""
def decodage(k,ne):
	k = k-1 #pour que le reste soit bien entre 0 et ne-1
	j = k // (ne**2) 
	x = ( k % ne**2 ) // ne # k%(ne**2) = x*ne + y 
	y = ( k % ne ) # k%ne = y
	return (j,x,y)

# On teste la fonction :
k = codage(2,2,1,0,1)
(j,x,y)=decodage(k,2)
#print(j)
#print(x)
#print(y)





########################
###### Exercice 3 ######
########################

"""
Question 1
"""
def min_une_vraie(liste):
	liste.append(0)
	return liste
	
def max_une_vraie(liste):
	res = []
	for i in range(len(liste)) :
		reste = liste[(i+1):]
		for j in reste : 
			res.append(-liste[i])
			res.append(-j)
			res.append(0)
	return res

#print(max_une_vraie([1,2,3,4,5]))

"""
Question 2
"""

"""
1. Pour un jour j donné, une équipe x donnée et une équipe adverse y quelconque, on aura au plus un 'codage(ne, nj, j, x, y)' qui sera vrai.
De même pour j et y fixés et x quelconque.
"""

"""
2.
"""
def encoderC1(ne,nj):
	res = []
	#Pour un jour donné...
	for j in range(nj): 
		#chaque equipe ne peut jouer qu'une fois
		for e in range(ne):
			liste_match_avec_e = []
			for adv in range(ne):
				if adv!=e : 
					liste_match_avec_e.append(codage(ne,nj,j,e,adv))
					liste_match_avec_e.append(codage(ne,nj,j,adv,e))
			res.extend(max_une_vraie(liste_match_avec_e))
	return res

# print(encoderC1(3,4))

"""
3. On a une contrainte par jour et par équipe (chaque équipe ne peut pas jouer plus d'un match par jour) soit 4*3=12 contraintes ici.
   En effet :  pour tout jour j appartenant à [0, n_j-1], pour toute équipe e appartenant à [0,n_e-1] : card( {(j,e,adv) | adv appartient à [0,n_e-1], adv!=e} ) + card( {(j,adv,e | adv appartient à [0,n_e-1], adv!=e} ) <= 1
   On a au total 72 clauses.

   On note (x,y) un match entre les équipes x et y (avec x et y le numéro de l'équipe) :
[
-2, -4,                le jour 0 il ne peut pas y avoir un match (0,1) et un match (1,0) en même temps 
-2, -3,                le jour 0 il ne peut pas y avoir un match (0,1) et un match (0,2) en même temps 
-2, -7,                le jour 0 il ne peut pas y avoir un match (0,1) et un match (2,0) en même temps 
-4, -3,                le jour 0 il ne peut pas y avoir un match (1,0) et un match (0,2) en même temps 
-4, -7,                le jour 0 il ne peut pas y avoir un match (1,0) et un match (2,0) en même temps 
-3, -7,                le jour 0 il ne peut pas y avoir un match (0,2) et un match (2,0) en même temps 
-4, -2,                le jour 0 il ne peut pas y avoir un match (1,0) et un match (0,1) en même temps 
-4, -6,                le jour 0 il ne peut pas y avoir un match (1,0) et un match (1,2) en même temps 
-4, -8,                le jour 0 il ne peut pas y avoir un match (1,0) et un match (2,1) en même temps 
-2, -6,                le jour 0 il ne peut pas y avoir un match (0,1) et un match (1,2) en même temps 
-2, -8,                le jour 0 il ne peut pas y avoir un match (0,1) et un match (2,1) en même temps 
-6, -8,                le jour 0 il ne peut pas y avoir un match (1,2) et un match (2,1) en même temps 
-7, -3,                le jour 0 il ne peut pas y avoir un match (2,0) et un match (0,2) en même temps 
-7, -8,                le jour 0 il ne peut pas y avoir un match (2,0) et un match (2,1) en même temps 
-7, -6,                le jour 0 il ne peut pas y avoir un match (2,0) et un match (1,2) en même temps 
-3, -8,                le jour 0 il ne peut pas y avoir un match (0,2) et un match (2,1) en même temps 
-3, -6,                le jour 0 il ne peut pas y avoir un match (0,2) et un match (1,2) en même temps 
-8, -6,                le jour 0 il ne peut pas y avoir un match (2,1) et un match (1,2) en même temps 
-11, -13,              idem pour le jour 1...
-11, -12,                
-11, -16,               
-13, -12,                 
-13, -16,                 
-12, -16,                 
-13, -11,                 
-13, -15,                 
-13, -17,                 
-11, -15,                 
-11, -17,                 
-15, -17,                 
-16, -12,                 
-16, -17,                 
-16, -15,                 
-12, -17,                 
-12, -15,                 
-17, -15,                 
-20, -22,                 idem pour le jour 2...
-20, -21,                 
-20, -25,                 
-22, -21,                 
-22, -25,                 
-21, -25,                 
-22, -20,                 
-22, -24,                 
-22, -26,                 
-20, -24,                 
-20, -26,                 
-24, -26,                 
-25, -21,                 
-25, -26,                 
-25, -24,                 
-21, -26,                 
-21, -24,                 
-26, -24,                 
-29, -31,                 idem pour le jour 3...
-29, -30,          
-29, -34,         
-31, -30,     
-31, -34,        
-30, -34,                
-31, -29,             
-31, -33,            
-31, -35,        
-29, -33,         
-29, -35,        
-33, -35,               
-34, -30,            
-34, -35,               
-34, -33,                 
-30, -35,                 
-30, -33,               
-35, -33                
]
"""

"""
4. Pour chaque couple d'équipe (x,y) , parmi tous les jours possibles, il faut qu'il y ait exactement un match (maximum une fois et minimum une fois) entre ces deux équipes (dans ce sens).
   Ainsi : pour toute équipe e1 appartenant à [0, n_e-1], pour toute équipe e2 appartenant à [0,n_e-1] telle que e1!=e2 : card( {(j,e1,e2) | j appartient à [0,n_j-1]} ) == 1 
                                                                                                                      et  card( {(j,e2,e1) | j appartient à [0,n_j-1]} ) == 1
"""

"""
5.
"""
def encoderC2(ne,nj):
	res = []
	for x in range(ne):
		for y in range(ne):
			if x!=y : 
				tmp = [codage(ne, nj, j, x, y) for j in range(nj)] #tous les match (x,y) possibles (les nj jours)
				res.extend(max_une_vraie(tmp))
				res.extend(min_une_vraie(tmp))
	return res

#print(encoderC2(3,4))


    
"""
6.Pour 3 équipes et 4 jours, on a 6 contraintes (car il y en tout 6 couples d'équipes (x,y) possibles et que ceux-ci ne doivent s'affronter qu'une fois).
  Au total, pour chaque contrainte on a 12 clauses permettant de traduire que pour chaque couple d'équipes (x,y) ceux-ci doivent s'affronter au moins une fois (une clause "min" : x affronte y au moins un jour du tournois) 
  ainsi qu'une clause permettant de traduire que chuaque couple d'équipe s'affonte au maximum 1 fois.
  Il y a donc au total 6*(12+1) = 78 clauses dans le cas présent. 

  [-2, -11, 0,               il y a un match (0,1) soit le jour 0 soit le jour 1 (pas les deux)
  -2, -20, 0,                il y a un match (0,1) soit le jour 0 soit le jour 2 (pas les deux)
  -2, -29, 0,                il y a un match (0,1) soit le jour 0 soit le jour 3 (pas les deux)
  -11, -2, 0,                il y a un match (0,1) soit le jour 1 soit le jour 0 (pas les deux)
  -11, -20, 0,               il y a un match (0,1) soit le jour 1 soit le jour 2 (pas les deux)
  -11, -29, 0,               il y a un match (0,1) soit le jour 1 soit le jour 3 (pas les deux)
  -20, -2, 0,                il y a un match (0,1) soit le jour 2 soit le jour 0 (pas les deux)
  -20, -11, 0,               il y a un match (0,1) soit le jour 2 soit le jour 1 (pas les deux)
  -20, -29, 0,               il y a un match (0,1) soit le jour 2 soit le jour 3 (pas les deux)
  -29, -2, 0,                il y a un match (0,1) soit le jour 3 soit le jour 0 (pas les deux)
  -29, -11, 0,               il y a un match (0,1) soit le jour 3 soit le jour 1 (pas les deux)
  -29, -20, 0,               il y a un match (0,1) soit le jour 3 soit le jour 2 (pas les deux)
  2, 11, 20, 29, 0,          il y a un match (0,1) au moins un des quatre jours (0, 1, 2 ou 3)
  -3, -12, 0,                idem pour un match (0,2)
  -3, -21, 0,                
  -3, -30, 0, 
  -12, -3, 0, 
  -12, -21, 0, 
  -12, -30, 0, 
  -21, -3, 0, 
  -21, -12, 0, 
  -21, -30, 0, 
  -30, -3, 0, 
  -30, -12, 0, 
  -30, -21, 0, 
  3, 12, 21, 30, 0, 
  -4, -13, 0,                idem pour un match (1,0)
  -4, -22, 0,  
  -4, -31, 0, 
  -13, -4, 0, 
  -13, -22, 0, 
  -13, -31, 0, 
  -22, -4, 0, 
  -22, -13, 0, 
  -22, -31, 0, 
  -31, -4, 0, 
  -31, -13, 0, 
  -31, -22, 0, 
  4, 13, 22, 31, 0, 
  -6, -15, 0,               idem pour un match (1,2)
  -6, -24, 0, 
  -6, -33, 0, 
  -15, -6, 0, 
  -15, -24, 0, 
  -15, -33, 0, 
  -24, -6, 0, 
  -24, -15, 0, 
  -24, -33, 0, 
  -33, -6, 0, 
  -33, -15, 0, 
  -33, -24, 0, 
  6, 15, 24, 33, 0, 
  -7, -16, 0,               idem pour un match (2,0)
  -7, -25, 0, 
  -7, -34, 0, 
  -16, -7, 0, 
  -16, -25, 0, 
  -16, -34, 0, 
  -25, -7, 0, 
  -25, -16, 0, 
  -25, -34, 0, 
  -34, -7, 0, 
  -34, -16, 0, 
  -34, -25, 0, 
  7, 16, 25, 34, 0, 
  -8, -17, 0,               idem pour un match (2,1)
  -8, -26, 0, 
  -8, -35, 0, 
  -17, -8, 0, 
  -17, -26, 0, 
  -17, -35, 0, 
  -26, -8, 0, 
  -26, -17, 0, 
  -26, -35, 0, 
  -35, -8, 0, 
  -35, -17, 0, 
  -35, -26, 0, 
  8, 17, 26, 35, 0]


"""

"""
7.
"""
def dico(ne,nj):
    """
    Permet de faire correspondre un nombre entre 1 et nb_var avec l'encodage effectué par la fonction encodage.
    """
    dico_res = dict() #dictionnaire : (val pour glucose,encodage)
    dico_res2 = dict() #dictionanire : (encodage, valeur pour glucose)
    nb_var = nj*ne*(ne-1)
    liste = [] #contiendra toutes les valeurs possibles d'encodage 
    for j in range(nj):
          for x in range(ne):
                for y in range(ne):
                    if x!=y :
                        liste.append(codage(ne,nj,j,x,y))
    dico_res = {i+1:liste[i] for i in range(len(liste))} #on fait correspondre un nombre entre 1 et nb_val à chaque valeur d'encodage 
    dico_res2 = {liste[i]:i+1 for i in range(len(liste))}
    dico_res_neg = {-i-1:-liste[i] for i in range(len(liste))} #on fait de même pour les nombres négatifs
    dico_res_neg2 = {-liste[i]:-i-1 for i in range(len(liste))}
    dico_res.update(dico_res_neg)
    dico_res2.update(dico_res_neg2)
    dico_res[0]=0
    dico_res2[0]=0
    return dico_res, dico_res2

#print(dico(3,4))

def encoder(ne,nj):
	c1 = encoderC1(ne,nj)
	c2 = encoderC2(ne,nj)
	c1.extend(c2)
	_,dico_corresp = dico(ne,nj) #récupère le dictionnaire (encodage, valeur pour glucose)
	res = [dico_corresp[i] for i in c1]
	with open("glucose-4.2.1/sources/simp/championnat.cnf", 'w') as file : #dans le repertoire contenant le fichier championnat.py il y a également le dossier glucose-4.2.1
		nb_var = nj*ne*(ne-1)
		nb_clauses = c1.count(0)
		s = "p cnf "+str(nb_var)+" "+str(nb_clauses)+"\n"
		file.write(s)
		res = [str(i) for i in res]
		res = ' '.join(res)
		file.write(res)
	return res

#encoder(3,4)


   
"""
Question 3

Il faut bien penser à ajouter au document la première ligne : p cnf nb_var nb_clauses.
Il faut également que les numeros des clauses soit de 1 à nb_var (ce que l'on fait grâce à la fonction modifier_liste).
En lançant glucose sur le fichier obtenu (avec la commande : ./glucose_static championnat.cnf > result.txt) on obtient par exemple: 
s UNSATISFIABLE
"""

"""
Question 4

Pour enregistrer le résultat on lance dans le terminal : ./glucose_static -model championnat.cnf > result.txt
"""

def lire_noms_equipes(path=False):
    """
    Permet de lire les noms des équipes sur un fichier contenant un nom par ligne.
    Retourne un dictionnaire faisant correspondre le numéro de la ligne avec le nom de l'équipe.
    """
    dico = dict()
    if path==False : 
        return dico
    noms = open(path).readlines()
    for i in range(len(noms)): 
          dico[i] = noms[i].replace("\n","")
    return dico
    
#lire_noms_equipes("noms_equipes.txt")


def decoder(path,ne,nj, path_name_equipes=False):

    solution = []
    unsat=False
    with open(path, 'r') as file : 
        lines = file.readlines()
        last_line = lines[-1] #on récupère la dernière ligne
        if(last_line.replace(' ','').replace('\n','') == "sUNSATISFIABLE"):
            unsat = True
        else : 
            solution = last_line.split()[1:] #on enlève le v
            solution = [int(i) for i in solution]
            dico_sol,_ = dico(ne,nj) #on récupère le dictionnaire (valeur pour glucose, encodage)
            solution = [dico_sol[i] for i in solution if i>0 ] #on modifie les nombres de la solution pour qu'elle corresponde avec l'encodage
            solution = [decodage(k,ne) for k in solution] 

    #Ecriture dans un fichier planning.txt
    with open('../../../planning.txt','w') as file : 
        file.write("Planning pour "+str(ne)+" équipes et "+str(nj)+" jours : ")
        if(unsat):
            file.write("Il n'y a pas de planning possible")
        else : 
            if path_name_equipes != False :
                noms_equipes = lire_noms_equipes(path_name_equipes) #récupère le nom des équipes
            else : 
                noms_equipes = dict()
            jour = 0 #on commence le jour 0 (correspond au premier jour de match)
            file.write("\n\nJour 1 :")
            for j,x,y in solution : 
                if j != jour : 
                    file.write("\n\nJour "+str(j+1))
                    jour = j
                file.write("\n- match entre l'équipe "+ str(noms_equipes.get(x,x)) +" et l'équipe "+str(noms_equipes.get(y,y)))
          
    #Affichage dans le terminal
    print("PLANNING DES MATCHS : \n")
    if(unsat):
        print("Il n'y a pas de planning possible")
        return False
    else : 
        if path_name_equipes != False :
            noms_equipes = lire_noms_equipes(path_name_equipes) #récupère le nom des équipes
        else : 
            noms_equipes = dict()
        jour = 0 #on commence le jour 0 (correspond au premier jour de match)
        print("Jour 1 :")
        for j,x,y in solution : 
            if j != jour : 
                print("\nJour ",j+1)
                jour = j
            print("- match entre l'équipe %s et l'équipe %s " % (noms_equipes.get(x,x),noms_equipes.get(y,y)))
        return True


"""
Question 5
"""

#os.system("pip install timeout-decorator")
from timeout_decorator import timeout

@timeout(10)
def assemblage_final(ne,nj,path_name_equipes=False):
    cwd = os.path.abspath(os.getcwd())
    encoder(ne,nj) #génération du fichier championnat.cnf contenant toutes les clauses 
    os.chdir('glucose-4.2.1/sources/simp') #va dans le repertoire où se trouve le fichier .cnf
    os.system('./glucose_static -model championnat.cnf > result.txt') #on execute la commande permettant de lancer le solveur et de créer le fichier results.txt contenant le résultat
    res = ""
    if path_name_equipes==False :
        res = decoder("result.txt",ne,nj)
    else : 
        res = decoder("result.txt",ne,nj,"../../../"+path_name_equipes) 
    os.chdir(cwd)
    return res

#assemblage_final(3,4,"noms_equipes.txt")
assemblage_final(4,6,"noms_equipes.txt")


"""
Exercice 4

La fonction nous retourne le dictionnaire suivant : {3: 6, 4: 6, 5: 'None', 6: 'None', 7: 'None', 8: 'None', 9: 'None', 10: 'None'}
On en déduit que lorsque l'on a 3 équipe il faut au minimum 6 jours pour respecter les contraintes, que lorsque l'on a 4 équipes il en faut au minimum 6. Au delà, le solveur prend plus de 10 secondes à traiter le problème.
"""

def optimisation():
    d = dict()
    for nb_e in range(3,11):
        nb_j = 6
        try:
            while(not(assemblage_final(nb_e,nb_j))):
                nb_j+=1
            d[nb_e]=nb_j
        except:
            d[nb_e]="None"
    print(d)

#optimisation()


########################
###### Conclusion ######
########################
"""
Lors de ce projet nous avons organisé les fichiers de façon à ce que dans un même répertoire se trouve le dossier "glucose-4.2.1" ainsi que notre fichier "championnat.py".
Dans ce même répertoire peut se trouver un fichier "noms_equipes.txt" contenant un nom d'équipe par ligne 
(dans le cas où plus d'équipes participent au tournoi qu'il n'y a de noms d'équipe dans le fichier, alors les équipes sans nom seront appelées par un numéro).
Par la suite, la fonction encoder permet la génération d'un fichier "championnat.cnf" qui sera enregistré dans le répertoire glucose-4.2.1/sources/simp.
Un fichier contenant "result.txt" (contenant le résultat donné par le solveur glucose) sera ensuite créé dans ce même répertoire.
Enfin, le résultat (un planning ou une phrase précisant qu'il n'y pas de planning possible pour ces contraintes) s'affichera dans le terminal et un fichier "planning.txt" enregistrera 
le résultat obtenu dans le même répertoire que le fichier "championnat.py".

Dans le cas où l'on cherche à réaliser un planning pour 3 équipes sur 4 jours, on obtient UNSAT puisque 4 jours ne sont pas suffisants pour que les 3 équipes adverses se
rencontrent exactement une fois sans jouer plus d'une fois par jour. Il faut en effet au minimum 6 jours pour que 3 équipes puissent s'affonter. 
Néanmoins, lorsque l'on cherche à faire s'affronter par exemple 4 équipes sur 6 jours, on obtient bien un planning possible 
(il y en a plusieurs mais le solveur ne nous donne qu'un exemple satisfaisant l'ensemble des contraintes).
"""