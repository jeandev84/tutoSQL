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