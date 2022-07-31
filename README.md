## VSCode CTRL+SHIFT+Q (execute query)

### INTRODUCTION A SQL ( https://sqlite.org/docs.html )

1. CREATE UNE TABLE
```sql 
CREATE TABLE posts (
   title VARCHAR(150),
   content TEXT,
   category VARCHAR(50),
   created_at DATETIME
);
```

2. SUPPRIMMER UNE COLONNE
```sql
ALTER TABLE posts DROP category;
```

3. AJOUTER UNE COLONNE
```sql
ALTER TABLE posts ADD category VARCHAR(50);
```


4. RENOMMER UNE TABLE
```sql
ALTER TABLE posts RENAME TO post;ALTER TABLE post RENAME TO posts;
```

5. RENAME UNE COLONNE DE TABLE
```sql
ALTER TABLE posts RENAME category TO tag;
```


6. DROP TABLE
```sql
DROP TABLE posts;
```

### CREER UNE TABLE DE RECETTE DE CUISINE

```
recipes
 - title (varchar)
 - content (text)
 - slug (varchar)
 - duration (en minutes)
 - online (boolean)
 - created_at (datetime)
```

```sql
CREATE TABLE recipes (
   title VARCHAR(150),
   slug VARCHAR(50),
   content TEXT,
   duration SMALLINT,
   online BOOLEAN,
   created_at DATETIME
);
```

### INSERER DES DONNEES DANS UNE TABLE

```sql
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


INSERT INTO recipes
(
    title, 
    slug, 
    content, 
    duration, 
    online, 
    created_at
) VALUES (
    'Soupe', 
    'soupe',
    'Contenu de test',
    10,
    FALSE,
    1659167706
);

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


--- Multi Insertion de donnees

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
*/

SELECT * FROM recipes;
SELECT * FROM recipes WHERE title LIKE '%salade%';

```

### SELECTIONNER DES DONNEES D' UNE TABLE

```sql

--- SELECTION DE DONNEES D' UNE TABLE

--- Selectionner toute les recettes avec les colonnes title et duration
/* SELECT title, duration FROM recipes; */


--- Selectionner toutes les recettes avec toutes les colonnes
/* SELECT * FROM recipes; */


--- Selectionner toutes les recettes qui durent moins de 20 min
/* SELECT * FROM recipes WHERE duration < 20;  */


--- Selectionner toutes les recettes qui ont un slug "soupe"
SELECT * FROM recipes WHERE slug = 'soupe';
SELECT * FROM recipes WHERE slug = 'salade-de-fruit';
SELECT * FROM recipes WHERE slug = 'slug-non-existant';

--- Selectionner toues les recettes qui durent entre 0 et 30 min
/* SELECT * FROM recipes WHERE duration BETWEEN 0 AND 30; */

--- Selectionner toues les recettes qui durent entre 0 et 100 min
/* SELECT * FROM recipes WHERE duration BETWEEN 0 AND 100; */


--- Selectionner toutes les recettes dont le slug se trouve dans un ensemble d' elements
--- IN permet de selectionner un ensemble d'elements

SELECT * FROM recipes WHERE slug IN ('soupe', 'salade-de-fruit');

/* SELECT * FROM recipes WHERE slug IN ('soupe', 'salade-de-fruit'); */

--- Selectionner toutes les recettes par comparaison: <, <= , >, >=,  = , != (different) ou <> ( dans certaines base de donnees)
SELECT * FROM recipes WHERE slug =! 'soupe';


--- Selectionner toutes les recettes par combinaison
SELECT * FROM recipes WHERE slug = 'soupe' AND duration < 20;
SELECT * FROM recipes WHERE slug = 'soupe' OR duration > 20;
SELECT * FROM recipes WHERE slug = 'soupe' OR (duration > 20 AND online = TRUE);
SELECT * FROM recipes WHERE (slug = 'soupe' OR duration > 20) AND online = TRUE;


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
SELECT * FROM recipices WHERE slug LIKE 'salade%';
SELECT * FROM recipices WHERE slug LIKE '%salade%';
SELECT * FROM recipices WHERE slug LIKE '%salade';


SELECT * FROM recipices WHERE title LIKE '%Salade';
SELECT * FROM recipices WHERE title LIKE '%salade';
```


### SUPPRIMER UN ENREGISTREMENTE D' UNE TABLE

```sql

--- Supprimer

--- supprimmer la ligne de la table ou le titre egal a Soupe2
DELETE FROM recipes WHERE title = 'Soupe2';
DELETE FROM recipes WHERE title = 'Soupe3';


SELECT * FROM recipes;

```

### METTRE AJOUR UN ENREGISTREMENT

```sql
--- Mettre ajour un enregistrement

UPDATE recipes SET title = 'Soupe de legume' WHERE title = 'Soupe';

```

###  NOTION D' INDEX (CLE PRIMAIRE)

```sql
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

--- SCAN
EXPLAIN QUERY PLAN SELECT * FROM recipes;
EXPLAIN QUERY PLAN SELECT * FROM recipes WHERE title = 'Soupe';

--- SEARCH
EXPLAIN QUERY PLAN SELECT * FROM recipes WHERE id = 3;


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

```

### CREER DES INDEXES PERSONNALISEES

```sql

--- CREER INDEXES PERSONALISEES

/*
On cree un index unique nomme idx_slug 
sur la table recipes et on precise le champ (slug) qui est unique
*/

-- On met ajour nos donnees ou les enregistrements sont identiques

-- UPDATE recipes SET slug = 'soupe1' WHERE id = 3;
-- UPDATE recipes SET slug = 'soupe2' WHERE id = 4;

/*
 Cette creation d' index unique (idx_slug)
 permet a ce que un article aie un meme slug dans notre cas. 
 Et cela permet de retrouver les articles plus rapidement
*/

CREATE UNIQUE INDEX idx_slug ON recipes (slug);

-- Plus performant d' executer une requette de la sorte
-- les requettes s' executent plus rapidement

/* 
EXPLAIN est plus rapide de recuperer des donnees.
EXPLAIN est moins rapide (ralentit) l' insertion a cause des cles primaires
Il est important de mettre les indexes seulement sur les champs 
qui seront utiliser dans la requette ou referencer
*/

EXPLAIN QUERY PLAN SELECT * FROM recipes WHERE slug = 'soupe'; 

```


### SUPPRIMER UN INDEX

```sql

-- Recuperer la liste des indexes utiliser par la table 'recipes' (propre a SQLite)

-- PRAGMA index_list('recipes');

-- Suppression d' index
-- DROP INDEX (idx_recipes_slug);

-- Bonne convention pour creer les indexes 
-- afin d' eviter la collision des noms d' indexes de differentes tables
-- prefix_nomDeLaTable_lenomDuChamps (idx_recipes_slug)

-- IL FAUT TOUJOURS SUPPRIMER LES INDEXES AVANT DE FAIRE UNE INSERTION !!!!

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

```


### LA VALEUR NULL pour une colonne

```sql

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

```


### NOTION DE CLE ETRANGERES ENTRE NOS TABLES

```sql
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


```

### JOINTURE (JOIN)

```sql
-- CREATION ET INSERTION DE DONNES (Migrations)
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



-- LIAISON (JOIN)
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

```


### CONTRAINTES DES CLES PRIMAIRES (ON DELETE, ON UPDATE)

```sql

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


--- CONDITION SUR LES JOIN

SELECT r.id, r.title, c.title AS category
FROM recipes r 
INNER JOIN categories c ON r.category_id = c.id
WHERE c.title = 'Dessert'; 

```


### SCHEMATISATION (MCD & MLD)
- MCD : Modele Conceptual de Donnees
- MLD : Modele Relationnel de Logic de Donnees
- http://draw.io (https://app.diagrams.net/)

- Links :
http://perso.univ-lemans.fr/~cpiau/BD/SQL_PAGES/SQL0.html

```sql
Une recette appartient a combien de categories au minimum : 0
elle appartient a 0 categorie

Une recette peut avoir une infinite de categories : n

(0,n)

User ----0,n---Cree---1,1---Recette
Recette ----1,n---EstComposerDe---0,n---Ingredient
Recette ----0,n-----Appartient----0,n----Categorie


users
 - id
 - pseudo
 - email


recipes
 - id
 - title
 - slug
 - date
 - duration
 - user_id


categories_recipes
 - recipe_id
 - category_id


categories
 - id
 - title


ingredients_recipes
 - recipe_id
 - ingredient_id
 - quantity
 - unit

ingredient
 - id
 - title
```

### MLD (Pratique)

```sql
-- SQLite
PRAGMA foreign_keys = ON;


-- Suppression des tables de liaison ensuite la table liees
DROP TABLE IF EXISTS categories_recipes;
DROP TABLE IF EXISTS ingredients_recipes;

-- Suppression des tables ordinaires
DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS recipes;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS ingredients;



-- Creation de table users
CREATE TABLE users (
  id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  username VARCHAR(150) NOT NULL UNIQUE,
  email VARCHAR(150) NOT NULL UNIQUE
);



-- Creation de table recipes (recette)
CREATE TABLE recipes (
  id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  title VARCHAR(150) NOT NULL,
  slug VARCHAR(150) NOT NULL,
  date DATETIME,
  duration INTEGER DEFAULT 0 NOT NULL,
  user_id  INTEGER NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);


-- Creation de table categories
CREATE TABLE categories (
  id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  title VARCHAR(150) NOT NULL
);


-- Create de table intermediaire ou table de liaison : categories_recipes
CREATE TABLE categories_recipes (
  recipe_id INTEGER NOT NULL,
  category_id INTEGER NOT NULL,
  FOREIGN KEY (recipe_id) REFERENCES recipes(id) ON DELETE CASCADE,
  FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE CASCADE,
  PRIMARY KEY (recipe_id, category_id),
  UNIQUE (recipe_id, category_id)
);



-- Creation de table d' ingredients
CREATE TABLE ingredients (
  id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  name VARCHAR(150) NOT NULL
);


-- Creation de table de table de liaison (ingredients_recipes)
CREATE TABLE ingredients_recipes (
  recipe_id INTEGER NOT NULL,
  ingredient_id INTEGER NOT NULL,
  quantity INTEGER,
  unit VARCHAR(20),
  FOREIGN KEY (recipe_id) REFERENCES recipes(id) ON DELETE CASCADE,
  FOREIGN KEY (ingredient_id) REFERENCES ingredients(id) ON DELETE CASCADE,
  PRIMARY KEY (recipe_id, ingredient_id),
  UNIQUE (recipe_id, ingredient_id)
);


-- Insertion de users
INSERT INTO users (username, email) VALUES ('John Doe', 'john@doe.fr');



-- Insertion de categories
INSERT INTO categories (title) VALUES
  ('Plat'),
  ('Dessert'),
  ('Gateau');



-- Insertion de recipes
INSERT INTO recipes (title, slug, duration, user_id) VALUES 
('Soupe', 'soupe', 10, 1),
('Madeleine', 'madeleine', 30, 1);


-- Insertion d' identifiant a la table intermediaire (categories_recipes)
INSERT INTO categories_recipes (recipe_id, category_id) VALUES
(1, 1),
(2, 2),
(2, 3);


-- Insertion d' ingredients
INSERT INTO ingredients (name) VALUES 
('Sucre'),
('Farine'),
('Levure chimique'),
('Beurre'),
('Lait'),
('Oeuf');



-- Insertion d' identifiant a la table intermediaire (ingredients_recipes)
INSERT INTO ingredients_recipes (recipe_id, ingredient_id, quantity, unit) VALUES
(2, 1, 150, 'g'),
(2, 2, 200, 'g'),
(2, 3, 8, 'g'),
(2, 4, 100, 'g'),
(2, 5, 50, 'g'),
(2, 6, 3, NULL);


-- Selection (JOIN)
/*
SELECT * 
FROM recipes r
JOIN categories_recipes cr ON cr.recipe_id = r.id
JOIN categories c ON cr.category_id = c.id;


SELECT r.title, c.title AS category
FROM recipes r
JOIN categories_recipes cr ON cr.recipe_id = r.id
JOIN categories c ON cr.category_id = c.id;
;


SELECT r.title
FROM ingredients i
JOIN ingredients_recipes ir ON ir.ingredient_id = i.id
JOIN recipes r ON ir.recipe_id = r.id
WHERE i.name = 'Oeuf';


SELECT * 
FROM recipes r
LEFT JOIN ingredients_recipes ir ON ir.recipe_id = r.id
WHERE ir.recipe_id IS NULL;


DELETE FROM ingredients WHERE id = 3;
SELECT * FROM ingredients_recipes;
*/

/*
UPDATE ingredients_recipes 
SET quantity = 10
WHERE recipe_id = 2 AND ingredient_id = 3;


SELECT r.title, ir.quantity, ir.unit, i.name AS ingredient
FROM recipes r
JOIN ingredients_recipes ir ON ir.recipe_id = r.id
JOIN ingredients i ON ir.ingredient_id = i.id;
*/



SELECT * FROM recipes WHERE id = 2;


SELECT ir.quantity, ir.unit, i.name
FROM ingredients_recipes ir 
JOIN ingredients i ON ir.ingredient_id = i.id
WHERE ir.recipe_id = 2;

```


### AGREGER LES DONNEES (AGREGATION DES DONNEES)

```sql

avg(X)
count(*)
count(X)
group_concat(X)
group_concat(X,Y)
max(X)
min(X)
sum(X)
total(X)


```