CREATE TABLE Serveurs(
    id SERIAL PRIMARY KEY,
    nom VARCHAR(20),
    prenom VARCHAR(20), 
    contact VARCHAR(10)
);

CREATE TABLE Tables(
    id SERIAL PRIMARY KEY,
    numero INT
);

CREATE TABLE TableCommandeServeur(
    id SERIAL PRIMARY KEY, 
    commande_id INT REFERENCES Commande(id) NOT NULL,
    table_id INT REFERENCES Tables(id) NOT NULL,
    serveur_id INT REFERENCES Serveurs(id) NOT NULL
);

INSERT INTO Serveurs(nom, prenom, contact) VALUES
('RAKOTO','Njaka','0324567546'),
('RASOA','Lalao','0373490123');

INSERT INTO Tables(numero) VALUES
(1),
(2),
(3),
(4),
(5),
(6),
(7),
(8);

-- Ajout de quelques commandes de plus
INSERT INTO Commande(dateCommande, clientele_id) VALUES
('2026-10-18 12:30:00', 2),
('2026-10-18 13:00:00', 3),
('2026-10-18 13:30:00', 3),
('2026-10-18 14:00:00', NULL),
('2026-10-18 14:12:00', 1),
('2026-10-18 14:25:00', 3);

-- Ajout des plats commandés
INSERT INTO CommandePlat(commande_id, plat_id, quantite) VALUES
(5, 2, 3),
(5, 5, 2),
(6, 1, 2),
(7, 4, 3),
(7, 6, 4),
(7, 2, 5),
(8, 1, 2),
(9, 7, 6),
(9, 7, 6),
(10, 5, 1);

-- Affectation serveur table
INSERT INTO TableCommandeServeur(commande_id, table_id, serveur_id) VALUES
(1, 7, 1),
(2, 7, 1),
(3, 8, 2),
(4, 6, 1),
(5, 1, 1),
(6, 2, 2),
(7, 3, 1),
(8, 4, 2),
(9, 5, 1),
(10, 6, 2);
