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
       ('Salade de fruit', 'salade-de-fruit', NULL)
;


--- LIAISON (JOIN)
/* 
Select toute les colonnes de la table (recipes)
et rejoindre la table (categories)
et on voudrait que la cle etrangere
soit egal a l'id de la table (categories)

Lors de SELECT, il est important de preciser les champs dont on a besoin

*/

-- Selection de tous les champs de recettes
-- SELECT * FROM recipes;

/*
 lorsq'on seulement un JOIN
 lors d'un SELECT 
 il recupera toutes les recettes qu'on peut joindre a la table categories
 s'il ne les trouve pas il va tout simplement les supprimer
 Cas d' insertion ou category_id = NULL
 
INSERT INTO recipes (title, slug, category_id) 
VALUES ('Creme anglaise', 'creme-anglaise', 2), 
       ('Soupe', 'soupe', 1),
       ('Salade de fruit', 'salade-de-fruit', NULL)
;

En un mot SELECT va recupere toutes les recettes 
qui ont une liaison possible avec ta table categories

Ou il aura category_id = NULL seront ignores
*/

SELECT r.id, r.title, c.title AS category
FROM recipes r
JOIN categories c ON r.category_id = c.id;

-- JOIN equivalent a INNER JOIN (les deux fonctionnent de la meme facon)
/*
 Selectionne les elements qui correspondent aux 2 criteres
*/
SELECT r.id, r.title, c.title AS category
FROM recipes r
INNER JOIN categories c ON r.category_id = c.id;



-- LIAISON (LEFT JOIN)
/* 
  Recupere tous les enregistrements meme si la cle primaire a une valeur NULL
  Recupere tous les elements qui ont la liaison 
  et ceux qui n' ont pas de liaison aussi

  LEFT JOIN est par defaut un LEFT OUTER JOIN
*/

SELECT r.id, r.title, c.title AS category
FROM recipes r 
LEFT JOIN categories c ON r.category_id = c.id; 


-- LIAISON (RIGHT JOIN)
/* 
Selection les elements de la table de jointure pour rejoindre la table selectionner
  
RIGHT JOIN est par defaut un RIGHT OUTER JOIN

Moins utiliser RIGHT JOIN
il fait le sens inverse de LEFT JOIN
*/

SELECT r.id, r.title, c.title AS category
FROM recipes r 
RIGHT JOIN categories c ON r.category_id = c.id; 


-- LIAISON (FULL JOIN)
/*
Renvoit les 2 colonnes avec les trucs croises avec des NULL partout

FULL OUTER JOIN
assez rarement supporte
*/

SELECT r.id, r.title, c.title AS category
FROM recipes r 
FULL JOIN categories c ON r.category_id = c.id; 