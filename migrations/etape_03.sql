CREATE TABLE Commande(
    id SERIAL PRIMARY KEY,
    nomCommande VARCHAR(20) GENERATED ALWAYS AS ('CMD' || LPAD(id::text, 2, '0')) STORED,
    dateCommande TIMESTAMP DEFAULT NOW()
);

INSERT INTO Commande DEFAULT VALUES;
INSERT INTO Commande DEFAULT VALUES;
INSERT INTO Commande DEFAULT VALUES;
INSERT INTO Commande DEFAULT VALUES;

CREATE TABLE CommandePlat(
    id SERIAL PRIMARY KEY,
    commande_id INT REFERENCES Commande(id) NOT NULL,
    plat_id INT REFERENCES Plat(id) NOT NULL,
    quantite INT NOT NULL
);

INSERT INTO CommandePlat(commande_id, plat_id, quantite) VALUES
(1, 2, 4),
(1, 3, 1),
(1, 5, 5),
(2, 4, 3),
(2, 5, 3),
(2, 7, 3),
(3, 1, 2),
(3, 7, 2),
(4, 6, 10);