CREATE TABLE Paiement(
    id SERIAL PRIMARY KEY,
    paiementID VARCHAR(20) GENERATED ALWAYS AS ('PAI' || LPAD(id::text, 2, '0')) STORED,
    datePaiement TIMESTAMP DEFAULT NOW()
);

CREATE TABLE PaiementMode(
    id SERIAL PRIMARY KEY,
    libelle VARCHAR(10)
);

CREATE TABLE Operateur(
    id SERIAL PRIMARY KEY,
    libelle VARCHAR(10)
);

CREATE TABLE PaiementCommande(
    id SERIAL PRIMARY KEY,
    paiement_id INT REFERENCES Paiement(id),
    commande_id INT REFERENCES Commande(id),
    paiementMode_id INT REFERENCES PaiementMode(id),
    operateur_id INT REFERENCES Operateur(id),
    montant INT
);

-- Ajout d'une colonne pour stocker le montant déjà payé
ALTER TABLE Commande ADD COLUMN montant_paye TYPE INT


INSERT INTO Operateur(libelle) VALUES
('Mvola'),
('Orange Money'),
('Airtel Money');

INSERT INTO PaiementMode(libelle) VALUES
('Cash'),
('Mobile money');

-- Insertion de paiement pour les commandes 
INSERT INTO Paiement(datePaiement) VALUES
('2026-10-18 12:30:00'),
('2026-10-18 13:00:00'),
('2026-10-18 13:30:00'),
('2026-10-18 14:00:00'),
('2026-10-18 14:12:00'),
('2026-10-18 14:25:00'),
('2026-10-18 14:30:00'),
('2026-10-18 14:35:00'),
('2026-10-18 14:40:00'),
('2026-10-18 15:16:00');

-- Details de paiement
INSERT INTO PaiementCommande(
        paiement_id, 
        commande_id, 
        paiementMode_id,
        operateur_id,
        montant
    ) VALUES
    (1, 1, 1, NULL, 10000),
    (1, 1, 2, 1, 5000),
    (2, 2, 2, 2, 6000);

UPDATE Commande
    SET montant_paye = (SELECT MontantPaye 
                            FROM v_montantPayeByCommande
                            WHERE v_montantPayeByCommande.commande_id = Commande.id)