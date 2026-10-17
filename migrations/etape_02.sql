-- Création de la table catégorie
CREATE TABLE Categorie(
    id SERIAL PRIMARY KEY,
    libelle VARCHAR(255) NOT NULL
);

-- Insertion des catégories existantes
INSERT INTO Categorie(libelle) VALUES 
('Plats malagasy'),
('Plats chinois'),
('Soupes'),    
('Desserts'),
('Boissons');

-- Ajout de clé étrangère dans la table Plat
ALTER TABLE Plat 
    ADD COLUMN categorie_id INT REFERENCES Categorie(id);

-- Catégorisations des plats avec les catégorie
UPDATE Plat 
    SET categorie_id = 1
    WHERE nom = 'Romazava';

UPDATE Plat 
    SET categorie_id = 1
    WHERE nom = 'Ravitoto sy Henakisoa';

UPDATE Plat 
    SET categorie_id = 1
    WHERE nom = 'Akoho sy voanio';

UPDATE Plat 
    SET categorie_id = 2
    WHERE nom = 'Mine Sao';

UPDATE Plat 
    SET categorie_id = 3
    WHERE nom = 'Soupe Chinoise';

UPDATE Plat 
    SET categorie_id = 4
    WHERE nom = 'Mofo Gasy (les 4)';

UPDATE Plat 
    SET categorie_id = 5
    WHERE nom = 'Ranon''ampango';

-- Obligation de remplissage
ALTER TABLE Plat
    ALTER COLUMN categorie_id SET NOT NULL;