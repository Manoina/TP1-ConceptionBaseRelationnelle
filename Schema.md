#                            **LEVEL 1**    
**SGBD**: Postgres

## **STEP 1: CARD**
* TABLE_SCHEMA
PLAT(**id**, nom, prix)

_Trap response_: 
Type de **prix**: INT, parce que comme l'énoncé donne comme consigne, "Les montants sont en ariary, sans centimes: utiliser des entiers";
INT = entier. 
Je choisi **id** comme identifiant d'un plat au lieu du nom de plat à cause des variations de tailles(trop long...)


## **STEP 2: CATEGORIES**
* TABLE_SCHEMA
PLAT(**id**, nom, prix, #categorie_id)
CATEGORY(**id**, libelle)

* _Trap_": Pourquoi ne pas simplement ajouter une colonne categorie VARCHAR(50) dans la table Plat":
* _Response_: Parce que ça équivaut à laisser les utilisateurs écrires ceux qu'ils veulent dans le champ de texte.
Pour une catégorie qui est nommé "Plat Chinoise" par exemple, vue que les gens ne vont pas chercher comment on a écrit le nom du plat dans la base, donc l'utilisateur pourrait taper "Plat Sinoise" par exemple.
Quand le manager veut faire un recap des activités et voir par exemple les revenus grâce au Plat chinois, celle écrite avec Sinoise ne sera pas prise en compte, et le calcul ne sera pas exacte.


