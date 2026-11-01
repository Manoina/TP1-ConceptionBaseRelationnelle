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
    GROUP BY Commande.nomCommande, Plat.nom, CommandePlat.quantite, Plat.prix, CommandePlat.plat_id
    ORDER BY Commande.nomCommande, CommandePlat.plat_id
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

        -- STEP 6: PAIEMENTS
-- 1# Vue pour le montant total par commande        
CREATE OR REPLACE VIEW v_montantTotalByCommande AS
    SELECT  Commande.id AS Commande_id,
            Commande.nomCommande AS Commande,
            SUM(Plat.prix * CommandePlat.quantite) AS PrixTotal
        FROM Commande
        JOIN CommandePlat 
            ON Commande.id = CommandePlat.commande_id
        JOIN Plat 
            ON CommandePlat.plat_id = Plat.id
        GROUP BY Commande.nomCommande, Commande.id

-- 2# Vue pour le montant Paye par commande
CREATE OR REPLACE VIEW v_montantPayeByCommande AS         
    SELECT  CMD.id AS Commande_id,
            CMD.nomCommande AS Commande, 
            SUM(PmtC.montant) AS MontantPaye
        FROM Commande AS CMD
        LEFT JOIN PaiementCommande AS PmtC
            ON CMD.id = PmtC.commande_id
        GROUP BY CMD.nomCommande, CMD.id
        ORDER BY Commande

-- 3# Vue pour rassembler Montant total d'une commande, le paiement dû à ce dernier, et ce qui reste à payer
SELECT  Commande.nomCommande AS nomCommande,
        VMT.PrixTotal AS MontantTotal, 
        COALESCE(VMP.MontantPaye, 0) AS MontantPaye, 
        (VMT.PrixTotal - COALESCE(VMP.MontantPaye, 0)) AS MontantRestant
    FROM v_montantTotalByCommande AS VMT
    JOIN v_montantPayeByCommande AS VMP 
        ON VMT.commande_id = VMP.commande_id
    JOIN Commande
        ON VMT.commande_id = Commande.id
    ORDER BY Commande.id           

       /*REQUETE DEFFAILLANTE*/ 

    -- SELECT Commande.nomCommande AS Commande,
    --    SUM(Plat.prix * CommandePlat.quantite) AS PrixTotal,
    --    SUM(PaiementCommande.montant) AS MontantPaye
    -- FROM CommandePlat
    -- JOIN Commande
    --     ON CommandePlat.commande_id = Commande.id
    -- JOIN PaiementCommande
    --     ON Commande.id = PaiementCommande.commande_id    
    -- JOIN Plat 
    --     ON CommandePlat.plat_id = Plat.id
          
    -- GROUP BY Commande.nomCommande
    -- ORDER BY Commande.nomCommande


-- SELECT CMD.nomCommande AS Commande,
--         PAI.paiementID AS Paiement,
--         PM.libelle AS ModePaiement,
--         OPR.libelle AS Operateur,
--         PAI.datePaiement AS DatePaiement,
--         PAICom.montant AS Montant
--     FROM PaiementCommande AS PAICom
--     JOIN Paiement AS PAI
--         ON PAICom.paiement_id = PAI.id
--     JOIN Commande AS CMD
--         ON PAICom.commande_id = CMD.id
--     JOIN PaiementMode AS PM
--         ON PAICom.paiementMode_id = PM.id
--     LEFT JOIN Operateur AS OPR
--         ON PAICom.operateur_id = OPR.id
--     ORDER BY PAI.datePaiement;        