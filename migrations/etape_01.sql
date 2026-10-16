CREATE DATABASE gargotte;
\c gargotte;

CREATE TABLE Plat(
    id SERIAL PRIMARY KEY ,
    nom VARCHAR(200),
    prix INT NOT NULL
);

-- FUNCTION FOR DISPLAYING DISH BY PRICE
SELECT  nom,
        prix 
    FROM Plat 
    ORDER BY PRIX DESC 

