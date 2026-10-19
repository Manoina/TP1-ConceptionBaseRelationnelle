-- Creation de la table de la clientèle
CREATE TABLE Clientele(
    id SERIAL PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    prenom VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE
);

-- Insertion de 3 clients fidèles
INSERT INTO Clientele(nom, prenom, email) VALUES
('RAKOTO', 'Jean', 'Jean@gmail.com'),
('RABE', 'Konetaka', 'rabekonetaka@gmail.com'),
('JEAN', 'Pierre', 'jean.pierre@gmail.com');

-- Mise à jour de la table Commande: add clientele_id
ALTER TABLE Commande
    ADD COLUMN clientele_id INT REFERENCES Clientele(id);

-- Attribution de clients aux commandes effectués
UPDATE Commande
    SET clientele_id = 1
    WHERE id = 1;

 
UPDATE Commande 
    SET clientele_id = 3
    WHERE id = 3;

-- 