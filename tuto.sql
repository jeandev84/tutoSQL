-- SQLite

/* DROP TABLE posts; */

-- CREER UNE TABLE DE RECETTE
/*
CREATE TABLE recipes (
   title VARCHAR(150),
   slug VARCHAR(50),
   content TEXT,
   duration SMALLINT,
   online BOOLEAN,
   created_at DATETIME
);
*/


-- INSERER DES DONNEES 
/*
INSERT INTO recipes
(
    title, 
    slug, 
    content, 
    duration, 
    online, 
    created_at
) VALUES (
    'Salade de fruit', 
    'salade-de-fruit',
    'Contenu de test',
    30,
    TRUE,
    1659167706
);
*/


--- Multi Insertion

/*
INSERT INTO recipes
(
    title, 
    slug, 
    content, 
    duration, 
    online, 
    created_at
) VALUES (
    'Soupe1', 
    'soupe',
    'Contenu de test',
    10,
    FALSE,
    1659167706
),
(
    'Soupe2', 
    'soupe',
    'Contenu de test',
    10,
    FALSE,
    1659167706
),
(
    'Soupe3', 
    'soupe',
    'Contenu de test',
    10,
    FALSE,
    1659167706
);

SELECT * FROM recipes;
SELECT * FROM recipes WHERE title LIKE '%salade%';
*/

--- SELECTION DE DONNEES D' UNE TABLE

--- Selectionner toute les recettes avec les colonnes title et duration
/* SELECT title, duration FROM recipes; */


--- Selectionner toutes les recettes avec toutes les colonnes
/* SELECT * FROM recipes; */


--- Selectionner toutes les recettes qui durent moins de 20 min
/* SELECT * FROM recipes WHERE duration < 20;  */


--- Selectionner toutes les recettes qui ont un slug "soupe"
/*
SELECT * FROM recipes WHERE slug = 'soupe';
SELECT * FROM recipes WHERE slug = 'salade-de-fruit';
SELECT * FROM recipes WHERE slug = 'slug-non-existant';
*/


--- Selectionner toues les recettes qui durent entre 0 et 30 min
/* SELECT * FROM recipes WHERE duration BETWEEN 0 AND 30; */

--- Selectionner toues les recettes qui durent entre 0 et 100 min
/* SELECT * FROM recipes WHERE duration BETWEEN 0 AND 100; */


--- Selectionner toutes les recettes dont le slug se trouve dans un ensemble d' elements
--- IN permet de selectionner un ensemble d'elements

/* SELECT * FROM recipes WHERE slug IN ('soupe', 'salade-de-fruit'); */

--- Selectionner toutes les recettes par comparaison: <, <= , >, >=,  = , != (different) ou <> ( dans certaines base de donnees)
/* SELECT * FROM recipes WHERE slug =! 'soupe'; */


--- Selectionner toutes les recettes par combinaison
/*
SELECT * FROM recipes WHERE slug = 'soupe' AND duration < 20;
SELECT * FROM recipes WHERE slug = 'soupe' OR duration > 20;
SELECT * FROM recipes WHERE slug = 'soupe' OR (duration > 20 AND online = TRUE);
SELECT * FROM recipes WHERE (slug = 'soupe' OR duration > 20) AND online = TRUE;
*/


/* Operation boolean
TRUE AND TRUE   = TRUE
TRUE AND FALSE  = FALSE
FALSE AND TRUE  = FALSE
FALSE AND FALSE = FALSE


TRUE OR FALSE   = TRUE
FALSE OR TRUE   = TRUE
TRUE OR TRUE    = TRUE
FALSE OR FALSE  = FALSE
*/

--- Selectionner toutes les recettes semblable a une chaine de caracteres (LIKE)
--- JE VEUX QUELQUE CHOSE QUI EST 'salade' suivit de n'importe quoi. (% un jocker)

/*
SELECT * FROM recipices WHERE slug LIKE 'salade%';
SELECT * FROM recipices WHERE slug LIKE '%salade%';
SELECT * FROM recipices WHERE slug LIKE '%salade';


SELECT * FROM recipices WHERE title LIKE '%Salade';
SELECT * FROM recipices WHERE title LIKE '%salade';
*/


--- Supprimer un enregistrement

--- supprimmer la ligne de la table ou le titre egal a Soupe2
/*
DELETE FROM recipes WHERE title = 'Soupe2';
DELETE FROM recipes WHERE title = 'Soupe3';


SELECT * FROM recipes;
*/


--- Mettre ajour un enregistrement

/* UPDATE recipes SET title = 'Soupe de legume' WHERE title = 'Soupe'; */




--- NOTION D' INDEX (CLE PRIMAIRE)
--- Les indexes permette d' identifier chacune des lignes de nos enregistrements
--- Les cles primaires permettent d' avoir une cle UNIQUE 
--- une cle unique qui permet de specifier cette ligne specifiquement dans le tableau cette cle ne change pas elle est invariante dans le tableau

--- Pour creer une cle primaire on va supprimer notre table
/* DROP TABLE recipes; */

--- Ensuite on cree notre table
/*
CREATE TABLE recipes (
   id INTEGER PRIMARY KEY AUTOINCREMENT,
   title VARCHAR(150),
   slug VARCHAR(50),
   content TEXT,
   duration SMALLINT,
   online BOOLEAN,
   created_at DATETIME
);
*/

/* OPTIMISATION DES REQUETTES :

EXPLAIN : QUI PERMET D'EXECUTER LES REQUETTES AVEC MOINS DE TEMPS 
Beaucoup utiliser pour faire des requettes complexes
*/


--- REGARGER COMMENT UNE REQUETTE EST EXECUTER (SCAN LA REQUETTE)

/*
--- SCAN
EXPLAIN QUERY PLAN SELECT * FROM recipes;
EXPLAIN QUERY PLAN SELECT * FROM recipes WHERE title = 'Soupe';

--- SEARCH
EXPLAIN QUERY PLAN SELECT * FROM recipes WHERE id = 3;

*/

--- Insertion des donnees
/*
INSERT INTO recipes
(
    title, 
    slug, 
    content, 
    duration, 
    online, 
    created_at
) VALUES (
    'Soupe1', 
    'soupe',
    'Contenu de test',
    10,
    FALSE,
    1659167706
),
(
    'Soupe2', 
    'soupe',
    'Contenu de test',
    10,
    FALSE,
    1659167706
);
*/


--- Delete record
/* DELETE FROM recipes WHERE id = 2; */


--- CREER INDEXES PERSONALISEES

/*
On cree un index unique nomme idx_recipes_slug
sur la table recipes et on precise le champ (slug) qui est unique
*/

-- On met ajour nos donnees ou les enregistrements sont identiques

-- UPDATE recipes SET slug = 'soupe1' WHERE id = 3;
-- UPDATE recipes SET slug = 'soupe2' WHERE id = 4;

/*
 Cette creation d' index unique (idx_recipes_slug)
 permet a ce que un article aie un meme slug dans notre cas. 
 Et cela permet de retrouver les articles plus rapidement
*/

-- CREATE UNIQUE INDEX idx_recipes_slug ON recipes (slug);

-- Plus performant d' executer une requette de la sorte
-- les requettes s' executent plus rapidement

/* EXPLAIN QUERY PLAN SELECT * FROM recipes WHERE slug = 'soupe'; */

/* 
EXPLAIN est plus rapide de recuperer des donnees.
EXPLAIN est moins rapide (ralentit) l' insertion a cause des cles primaires
Il est important de mettre les indexes seulement sur les champs 
qui seront utiliser dans la requette ou referencer
*/


-- Recuperer la liste des indexes utiliser par la table 'recipes' (propre a SQLite)

-- PRAGMA index_list('recipes');

-- Suppression d' index
-- DROP INDEX (idx_recipes_slug);

-- Bonne convention pour creer les indexes 
-- afin d' eviter la collision des noms d' indexes de differentes tables
-- prefix_nomDeLaTable_lenomDuChamps (idx_recipes_slug)


/* 
 TOUJOURS SUPPRIMER LES INDEXES AVANT DE FAIRE UNE INSERTION
*/

/* DROP INDEX idx_slug; */

/*
INSERT INTO recipes
(
    title, 
    slug, 
    content, 
    duration, 
    online, 
    created_at
) VALUES (
    'Soupe1', 
    'soupe',
    'Contenu de test',
    10,
    FALSE,
    1659167706
),
(
    'Soupe2', 
    'soupe',
    'Contenu de test',
    10,
    FALSE,
    1659167706
);
*/



/*
Pour certaines base de donnees uuid sera sous forme de chaines de characteres
L'avantage est que on a un index sous forme de chaines de characteres on ne peut pas la deviner


CREATE TABLE recipes (
   uuid INTEGER PRIMARY KEY AUTOINCREMENT,
   title VARCHAR(150),
   slug VARCHAR(50),
   content TEXT,
   duration SMALLINT,
   online BOOLEAN,
   created_at DATETIME
);

*/


-- NOTION DE VALEUR NULL
-- NULL : extime l' absence de presence de valeur
-- Un champ deja existant sans valeur est par defaut NULL

-- Par example inseront des donnees sans le champs 'slug'

-- On va supprimer d'abord la table 'recipes' ( DROP TABLE recipes; )


/*
INSERT INTO recipes
(
    title, 
    content, 
    duration, 
    online, 
    created_at
) VALUES (
    'Soupe1', 
    'Contenu de test',
    10,
    FALSE,
    1659167706
),
(
    'Soupe2', 
    'Contenu de test',
    10,
    FALSE,
    1659167706
);
*/

-- DROP TABLE recipes;
-- CREATE UNIQUE INDEX idx_recipes_slug ON recipes (slug);
-- UPDATE recipes SET slug = 'soupe2' WHERE id = 4;
-- EXPLAIN QUERY PLAN SELECT * FROM recipes WHERE slug = 'soupe';
-- PRAGMA index_list('recipes');
-- DROP INDEX idx_recipes_slug
-- CREATE TABLE recipes;


-- NOT NULL est une contrainte qui permet de ne pas avoir une valeur NULL

-- DROP TABLE recipes;
/*
CREATE TABLE recipes (
   id INTEGER PRIMARY KEY AUTOINCREMENT,
   title VARCHAR(150) NOT NULL,
   slug VARCHAR(50) NOT NULL UNIQUE,
   content TEXT,
   duration SMALLINT,
   online BOOLEAN,
   created_at DATETIME
);
*/

/*
INSERT INTO recipes
(
    title, 
    slug, 
    duration, 
    online, 
    created_at
) VALUES (
    'Soupe2', 
    'soupe-2',
    10,
    FALSE,
    1659167706
);
*/

/*
INSERT INTO recipes
(
    title, 
    slug, 
    content,
    duration, 
    online, 
    created_at
) VALUES (
    'Soupe3', 
    'soupe-3',
    'contenu de test',
    10,
    FALSE,
    1659167706
);
*/


-- Recuperer toutes les recettes dont le contenu est null
-- SELECT * FROM recipes WHERE content IS NULL;

-- Recupere toutes les recettes dont le contenu est non null
-- SELECT * FROM recipes WHERE content IS NOT NULL;


-- Mettre un contenu a NULL ( Mise ajour )
-- UPDATE recipes SET content = NULL WHERE id = 1;

/*
INSERT INTO recipes
(
    title, 
    slug, 
    content,
    duration, 
    online, 
    created_at
) VALUES (
    'Soupe3', 
    'soupe-3',
    NULL,
    10,
    FALSE,
    1659167706
);
*/

-- Ajouter une valeur par defaut a une colonne (DEFAULT)
-- Par example ajouter une valeur par defaut pour notre champ (duration)

-- DROP TABLE recipes;
/*
CREATE TABLE recipes (
   id INTEGER PRIMARY KEY AUTOINCREMENT,
   title VARCHAR(150) NOT NULL,
   slug VARCHAR(50) NOT NULL UNIQUE,
   content TEXT DEFAULT 'hello' NOT NULL,
   duration SMALLINT DEFAULT 10 NOT NULL,
   online BOOLEAN,
   created_at DATETIME
);
*/

/*
INSERT INTO recipes
(
    title, 
    slug,  
    online, 
    created_at
) VALUES (
    'Soupe3', 
    'soupe-3',
    FALSE,
    1659167706
);

UPDATE recipes SET title = 'Soupe1', slug = 'soupe-1' WHERE id = 1;
*/


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



-- DELETE FROM categories WHERE id = 2;

-- SELECT * FROM recipes;
-- SELECT * FROM categories;


SELECT r.id, r.title, c.title AS category
FROM recipes r 
INNER JOIN categories c ON r.category_id = c.id
WHERE c.title = 'Dessert'; 





