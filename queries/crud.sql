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

/* 
UPDATE recipes SET title = 'Soupe de legume' WHERE title = 'Soupe';
*/



