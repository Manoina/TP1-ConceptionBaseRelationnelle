        -- STEP 1: LA CARTE MENU
-- FUNCTION FOR DISPLAYING DISH BY PRICE
SELECT  nom,
        prix 
    FROM Plat 
    ORDER BY PRIX DESC 

        -- STEP 2: LES CATEGORIES:
SELECT Categorie.libelle AS Categorie, count(Plat.nom) AS NbrPlat_par_Categorie
    FROM Plat
    LEFT JOIN Categorie
        ON Plat.categorie_id = Categorie.id
    GROUP BY Categorie.libelle