--- NOTION DE CLE PRIMAIRE ( CAS DE MIGRATION )
-- PRAGMA foreign_keys = ON : specific a SQLite pour activer la gestion des cles etrangeres
PRAGMA foreign_keys = ON; 

DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS recipes;


CREATE TABLE IF NOT EXISTS categories (
   id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
   title VARCHAR(150) NOT NULL,
   description TEXT
);

INSERT INTO categories (
   title
) VALUES ('Plat'), ('Dessert');


/*
FOREIGN KEY (category_id) REFERENCES categories(id)
permet de pointer la cle referencee dans la table categories
au cas s'il n'y a pas de categorie dont id = 19 cela generera une erreur

Par example:
INSERT INTO recipes (title, slug, category_id) 
VALUES ('Creme anglaise', 'creme-anglaise', 2), 
       ('Soupe', 'soupe', 1),
       ('Salade de fruit', 'salade-de-fruit', 19)
;

*/

CREATE TABLE IF NOT EXISTS recipes (
   id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
   title VARCHAR(150) NOT NULL,
   slug VARCHAR(50) NOT NULL UNIQUE,
   content TEXT,
   category_id INTEGER,  -- On cible la cle primaire de la table categories
   FOREIGN KEY (category_id) REFERENCES categories(id)
);


INSERT INTO recipes (title, slug, category_id) 
VALUES ('Creme anglaise', 'creme-anglaise', 2), 
       ('Soupe', 'soupe', 1),
       ('Salade de fruit', 'salade-de-fruit', 2)
;


--- LIAISON (JOIN)
/* 
Select toute les colonnes de la table (recipes)
et rejoindre la table (categories)
et on voudrait que la cle etrangere
soit egal a l'id de la table (categories)

Lors de SELECT, il est important de preciser les champs dont on a besoin

*/

-- SELECT * FROM recipes;

SELECT r.id, r.title, c.title AS category
FROM recipes r
JOIN categories c ON r.category_id = c.id;
