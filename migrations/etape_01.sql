CREATE DATABASE gargotte;
\c gargotte;

CREATE TABLE Plat(
    id SERIAL PRIMARY KEY ,
    nom VARCHAR(200),
    prix INT NOT NULL
);

INSERT INTO Plat(nom, prix) VALUES
    ('Romazava', 7000),
    ('Ravitoto sy Henakisoa', 8000),
    ('Akoho sy voanio', 8500),
    ('Mine Sao', 6000),
    ('Soupe Chinoise', 5000),
    ('Mofo Gasy (les 4)', 1000),
    ('Ranon''ampango', 500)
;
