        -- STEP 1: LA CARTE MENU
-- FUNCTION FOR DISPLAYING DISH BY PRICE
SELECT  nom,
        prix 
    FROM Plat 
    ORDER BY PRIX DESC 

        -- STEP 2: LES CATEGORIES
SELECT Categorie.libelle AS Categorie, count(Plat.nom) AS NbrPlat_par_Categorie
    FROM Plat
    LEFT JOIN Categorie
        ON Plat.categorie_id = Categorie.id
    GROUP BY Categorie.libelle

        -- STEP 3: LES COMMANDES
-- Details pour chaque commande         
SELECT Commande.nomCommande AS Commande, 
       Plat.nom AS Plat,
       CommandePlat.quantite AS Quantite,
       (Plat.prix * CommandePlat.quantite) AS PrixTotal
    FROM CommandePlat
    JOIN Commande
        ON CommandePlat.commande_id = Commande.id
    JOIN Plat 
        ON CommandePlat.plat_id = Plat.id
    GROUP BY Commande.nomCommande, Plat.nom, CommandePlat.quantite, Plat.prix
    ORDER BY Commande.nomCommande
-- Somme total pour chaque commande
SELECT Commande.nomCommande AS Commande,
       SUM(Plat.prix * CommandePlat.quantite) AS PrixTotal
    FROM CommandePlat
    JOIN Commande
        ON CommandePlat.commande_id = Commande.id
    JOIN Plat 
        ON CommandePlat.plat_id = Plat.id
    GROUP BY Commande.nomCommande
    ORDER BY Commande.nomCommande

        -- STEP 4: LES HABITUES:
SELECT Commande.nomCommande AS Commande, 
        COALESCE(Clientele.nom, 'Client de passage') AS Clientele 
    FROM Commande 
    LEFT JOIN Clientele 
        ON Commande.clientele_id = Clientele.id 
    ORDER BY commande         

        -- STEP 5: SERVEURS & TABLES:
SELECT  SRV.prenom AS Serveur,
        COUNT(DISTINCT CMD.nomCommande) AS NbrCommande,
        SUM(PLT.prix * CMDPLT.quantite) AS VenteTotale
    FROM TableCommandeServeur AS TCS
    JOIN Serveurs AS SRV
        ON TCS.serveur_id = SRV.id
    JOIN Commande AS CMD
        ON TCS.commande_id = CMD.id
    JOIN CommandePlat AS CMDPLT
        ON CMD.id = CMDPLT.commande_id
    JOIN Plat AS PLT
        ON CMDPLT.plat_id = PLT.id
    GROUP BY SRV.prenom