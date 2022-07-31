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

/*
ON DELETE RESTRICT : permet de restraindre la supppression

CREATE TABLE IF NOT EXISTS recipes (
   id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
   title VARCHAR(150) NOT NULL,
   slug VARCHAR(50) NOT NULL UNIQUE,
   content TEXT,
   category_id INTEGER,  -- On cible la cle primaire de la table categories
   FOREIGN KEY (category_id) REFERENCES categories(id)
   ON DELETE RESTRICT 
);

ON DELETE CASCADE : 
permet de supprimer tous les enregistrements en cascade

CREATE TABLE IF NOT EXISTS recipes (
   id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
   title VARCHAR(150) NOT NULL,
   slug VARCHAR(50) NOT NULL UNIQUE,
   content TEXT,
   category_id INTEGER,  -- On cible la cle primaire de la table categories
   FOREIGN KEY (category_id) REFERENCES categories(id)
   ON DELETE CASCADE 
);

ON DELETE SET NULL : 
permet de mettre tous les enregistrements a NULL la ou il y a liason

CREATE TABLE IF NOT EXISTS recipes (
   id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
   title VARCHAR(150) NOT NULL,
   slug VARCHAR(50) NOT NULL UNIQUE,
   content TEXT,
   category_id INTEGER,  -- On cible la cle primaire de la table categories
   FOREIGN KEY (category_id) REFERENCES categories(id)
   ON DELETE SET NULL
);

*/

CREATE TABLE IF NOT EXISTS recipes (
   id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
   title VARCHAR(150) NOT NULL,
   slug VARCHAR(50) NOT NULL UNIQUE,
   content TEXT,
   category_id INTEGER,  -- On cible la cle primaire de la table categories
   FOREIGN KEY (category_id) REFERENCES categories(id)
   ON DELETE SET NULL
);



INSERT INTO recipes (title, slug, category_id) 
VALUES ('Creme anglaise', 'creme-anglaise', 2), 
       ('Soupe', 'soupe', 1),
       ('Salade de fruit', 'salade-de-fruit', 2)
;



DELETE FROM categories WHERE id = 2;


SELECT * FROM recipes;
-- SELECT * FROM categories;


/*
SELECT r.id, r.title, c.title AS category
FROM recipes r 
INNER JOIN categories c ON r.category_id = c.id; 
*/


--- Les contraintes sur les cles primaires lors de la creation de table
/*
  ON DELETE : 
   - NO ACTION : par default est definit sur "NO ACTION" il ne fera rien
   - RESTRICT empeche la suppression
  
   NB: NO ACTION: lorsqu'on supprime un enregistrement cela ne lui pose pas un soucis
   
   - SET NULL : met la valeur a null lors de la suppression

   - SET DEFAULT : mettra la valeur par defaut lors de la suppression

   - CASCADE : 
     lorsqu'on supprime un enregistrement on supprime 
     aussi tous les enregistrements qui y sont lies a la liaison (cle primaire)
*/
