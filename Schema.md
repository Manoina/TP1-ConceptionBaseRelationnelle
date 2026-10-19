#                            **LEVEL 1**    
**SGBD**: Postgres

## **STEP 1: CARD**
* TABLE_SCHEMA
Plat(**id**, nom, prix)

_Trap response_: 
Type de **prix**: INT, parce que comme l'énoncé donne comme consigne, "Les montants sont en ariary, sans centimes: utiliser des entiers";
INT = entier. 
Je choisi **id** comme identifiant d'un plat au lieu du nom de plat à cause des variations de tailles(trop long...)


## **STEP 2: CATEGORIES**
* TABLE_SCHEMA
Plat(**id**, nom, prix, #categorie_id)
Categorie(**id**, libelle)

* _Trap_: "Pourquoi ne pas simplement ajouter une colonne categorie VARCHAR(50) dans la table Plat"

* _Response_: Parce que ça équivaut à laisser les utilisateurs écrires ceux qu'ils veulent dans le champ de texte.
Pour une catégorie qui est nommé "Plat Chinoise" par exemple, vue que les gens ne vont pas chercher comment on a écrit le nom du plat dans la base, donc l'utilisateur pourrait taper "Plat Sinoise" par exemple.
Quand le manager veut faire un recap des activités et voir par exemple les revenus grâce au Plat chinois, celle écrite avec Sinoise ne sera pas prise en compte, et le calcul ne sera pas exacte.

## **STEP 3: COMMANDS**
* TABLE_SCHEMA
Plat(**id**, nom, prix, #categorie_id)
Categorie(**id**, libelle)
Commande(**id**, nomCommande, dateCommande)
CommandePlat(**id**, **#commande_id**, **#plat_id**, quantite)

* _Trap_: "Où placez-vous la quantite"
* _Response_: Je le place dans CommandePlat, parce que c'est cette table qui décrit les détails de la commande effectué

## **STEP 4: ACCUSTOMED**
* TABLE_SCHEMA
Plat(**id**, nom, prix, #categorie_id)
Categorie(**id**, libelle)
Commande(**id**, nomCommande, dateCommande, #clientele_id)
CommandePlat(**id**, **#commande_id**, **#plat_id**, quantite)
Clientele(**id**, nom, prenom, email)

* _Trap_: " Votre clé étrangère est-elle 
NOT NULL
 ? Quelle jointure faut-il pour ne perdre aucune commande ?"
 * _Response_: La clé etrangère ne doit pas être contrainte NOT NULL parce que ce n'est pas tous les clients qui sont habitué de la gargotte, donc elle peut être vide.
 Pour ne perdre aucune commande, il faut utiliser **LEFT JOIN** comme jointure.

## **STEP 5: WAITERS & TABLES**
* TABLE_SCHEMA
Plat(**id**, nom, prix, #categorie_id)
Categorie(**id**, libelle)
Commande(**id**, nomCommande, dateCommande, #clientele_id)
CommandePlat(**id**, **#commande_id**, **#plat_id**, quantite)
Clientele(**id**, nom, prenom, email)
Serveurs(**id**, nom, prenom, contact)
Tables(**id**, numero)
TableCommandeServeur(**id**, **#commande_id**, **#table_id**, **#serveur_id**)

* _Trap_: " Une table de la salle et une commande sont deux choses différentes : expliquez pourquoi.
Pourquoi le nom 
table
 pose-t-il problème en SQL ?"
* _Response_: Une table contient plusieurs commandes, et une commande reçoit les différents plats pour les personnes qui commandent sur la même table.
Le nom table pose problème en SQL peut être parce que le système pourrait le confondre avec la table dans une base de données

