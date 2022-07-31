## VSCode CTRL+SHIFT+Q (execute query)

### 1. SQLite
### INTRODUCTION A SQL 
https://sqlite.org/docs.html

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

-- Selectionner toutes les recettes
SELECT * FROM recipes;


  -- Determiner le nombre total de recette existant dans mon application
  -- COUNT(X) : retourne toutes les recettes non null. 
  SELECT COUNT(id) FROM recipes;


  -- COUNT(*) : retorune toutes les recettes null et non null y compris (toutes les colonnes)
  SELECT COUNT(*) FROM recipes;


  -- Calculer la somme
  -- SUM(X)
  -- SELECT SUM(duration) as sum_duration FROM recipes;


  -- GROUP_CONCAT(X)
  -- title1,title2
  -- SELECT GROUP_CONCAT(title) AS titles FROM recipes; 


  -- title1, title2
  -- SELECT GROUP_CONCAT(title, ', ') AS titles FROM recipes; 


  -- title1-title2
  -- SELECT GROUP_CONCAT(title, '-') AS titles FROM recipes; 


  -- title1_title2
  -- SELECT GROUP_CONCAT(title, '_') AS titles FROM recipes;


  -- SELECT GROUP_CONCAT(title, ', ') FROM recipes;

  SELECT * FROM recipes;

  -- GROUP BY column (Je veux grouper par duration)
  -- Grouper 2 enregistrements qui ont une duree de 10 et 1 enregistrement qui ont une duree de 30
  -- SELECT COUNT(id), duration FROM recipes GROUP BY duration;


  -- Dans le cas suivant
  -- Vue que title n'y est pas dans group by cela peut generer une erreure
  -- Cela peut causer une erreure dans certaines base de donnees
  -- SELECT title, COUNT(id), duration FROM recipes GROUP BY duration;


  -- ANY_VALUE(X)
  -- SELECT ANY_VALUE(title), COUNT(id), duration FROM recipes GROUP BY duration;



  -- Recuper les recettes qui ont un COUNT(X) >= 2
  /*
  Ceci va gener une erreur de COUNT() a cause de la condition 
  WHERE qui n' est pas pris en compte par GROUP BY
  Pour remedier a cela on ajoute a la suite de la requette HAVING


  SELECT COUNT(id) AS count, duration 
  FROM recipes 
  WHERE count >= 2
  GROUP BY duration;
  */

  -- HAVING (marche comme WHERE)
  /*
  SELECT COUNT(id) AS count, duration 
  FROM recipes
  GROUP BY duration
  HAVING count >= 2;
 
  SELECT * 
  FROM ingredients i
  JOIN ingredients_recipes ir ON ir.ingredient_id = i.id;

  SELECT * 
  FROM ingredients i
  LEFT JOIN ingredients_recipes ir ON ir.ingredient_id = i.id;

  -- Resultat insatisfaisant
  SELECT i.name, COUNT(id) AS count
  FROM ingredients i
  LEFT JOIN ingredients_recipes ir ON ir.ingredient_id = i.id
  GROUP BY i.name;



  SELECT *
  FROM ingredients i
  LEFT JOIN ingredients_recipes ir ON ir.ingredient_id = i.id;


  -- GROUP : est interessant quant on a une fonction d' aggregation comt COUNT(), SUM() etc
  -- Resultat satifaisant
  SELECT i.name, COUNT(ir.recipe_id) AS count
  FROM ingredients i
  LEFT JOIN ingredients_recipes ir ON ir.ingredient_id = i.id
  GROUP BY i.name;


  SELECT i.name, COUNT(ir.recipe_id) AS count, r.duration
  FROM ingredients i
  LEFT JOIN ingredients_recipes ir ON ir.ingredient_id = i.id
  LEFT JOIN recipes r ON ir.recipe_id = r.id
  GROUP BY i.name, r.duration;

  -- DISTINCT
  /*
  SELECT i.name, COUNT(ir.recipe_id) AS count, r.duration
  FROM ingredients i
  LEFT JOIN ingredients_recipes ir ON ir.ingredient_id = i.id
  LEFT JOIN recipes r ON ir.recipe_id = r.id
  GROUP BY i.name, r.duration;
  */


  /* 
  Trouver tous le ingredients qui ont au moins une recette
  Retourne tous les ingredients qui sont utilises au moins une fois

  Ceci nous donnera une duplication de recettes

  SELECT *
  FROM ingredients i
  LEFT JOIN ingredients_recipes ir ON ir.ingredient_id = i.id
  WHERE ir.recipe_id IS NOT NULL;
  -- LEFT JOIN recipes r ON ir.recipe_id = r.id

  */

  -- SELECT DISTINCT : permet d' eviter les duplications de lignes
  /*
  SELECT DISTINCT i.name
  FROM ingredients i
  LEFT JOIN ingredients_recipes ir ON ir.ingredient_id = i.id
  WHERE ir.recipe_id IS NOT NULL;
  */

  -- Retourne des duplications de recettes
  /*
  SELECT DISTINCT i.name, r.duration
  FROM ingredients i
  LEFT JOIN ingredients_recipes ir ON ir.ingredient_id = i.id
  LEFT JOIN recipes r ON ir.recipe_id = r.id
  WHERE ir.recipe_id IS NOT NULL;
  */

  /*
  DISTINCT est utiliser s'il on n'a pas d'agregation a faire
  */
  SELECT DISTINCT i.name
  FROM ingredients i
  LEFT JOIN ingredients_recipes ir ON ir.ingredient_id = i.id
  LEFT JOIN recipes r ON ir.recipe_id = r.id
  WHERE ir.recipe_id IS NOT NULL;


 NB : 
 GROUP BY est utilise au cas 
 ou dans la requette SELECT 
 il ya une aggregation qui est utilisee comme COUNT(X), AVG(X), SUM(X)
```


### ORDER & LIMIT

```sql

-- ORDER & LIMIT
-- ORDER : permet d' organiser les enregistrements
-- LIMIT : permet de limiter le nombre de resultat
-- DESC  : Decroissant ( du plus grand au plus petit )
-- ASC   : Croissant   ( du plus petit au plus grand )

-- ORDRE PAR valeur numeric
/*
SELECT i.name, COUNT(ir.recipe_id) AS count
FROM ingredients i
LEFT JOIN ingredients_recipes ir ON ir.ingredient_id = i.id
LEFT JOIN recipes r ON ir.recipe_id = r.id
GROUP BY i.name
ORDER BY count DESC;
*/

-- ORDRE PAR valeur alphabetic
/*
SELECT i.name, COUNT(ir.recipe_id) AS count
FROM ingredients i
LEFT JOIN ingredients_recipes ir ON ir.ingredient_id = i.id
LEFT JOIN recipes r ON ir.recipe_id = r.id
GROUP BY i.name
ORDER BY i.name ASC;
*/

/*
SELECT i.name, COUNT(ir.recipe_id) AS count
FROM ingredients i
LEFT JOIN ingredients_recipes ir ON ir.ingredient_id = i.id
LEFT JOIN recipes r ON ir.recipe_id = r.id
GROUP BY i.name
ORDER BY count DESC, i.name ASC;
*/

-- LIMIT a un nombre definit
SELECT i.name, COUNT(ir.recipe_id) AS count
FROM ingredients i
LEFT JOIN ingredients_recipes ir ON ir.ingredient_id = i.id
LEFT JOIN recipes r ON ir.recipe_id = r.id
GROUP BY i.name
ORDER BY count DESC, i.name ASC
LIMIT 3;


-- LIMIT  : a nombre definit mais commencer par OFFSET
-- OFFSET : signifitcommencant par (ca permet de bouger le curseur
-- LIMIT 3 OFFSET 100
-- LIMIT 10 OFFSET 6
-- LIMIT 3 OFFSET 3

/**
Par example :
On a le nombre total de recettes est de 250. SELECT COUNT(*) FROM recipes;
On limte le resultat a 4 par parge. LIMIT 4
En commencant par l'index 2. Numero de page OFFSET 200

LIMIT 4 OFFSET 200 (200 < 250) retournera un resultat
LIMIT 4 OFFSET 300 (300 > 250) Retourne aucun resultat

LIMIT 3 OFFSET 2
LIMIT 2, 3
*/

SELECT i.name, COUNT(ir.recipe_id) AS count
FROM ingredients i
LEFT JOIN ingredients_recipes ir ON ir.ingredient_id = i.id
LEFT JOIN recipes r ON ir.recipe_id = r.id
GROUP BY i.name
ORDER BY count DESC, i.name ASC
LIMIT 3 OFFSET 2; 


```

### REQUETES IMBRIQUES OU SOUS-REQUETES

Les sous-requetes sont utilises pour obtenir un resultat 
et utiliser ce resultat dans une autre requete

```sql

-- SOUS REQUETE

/*
SELECT *, (
   SELECT COUNT(*) FROM ingredients_recipes WHERE recipe_id = r.id
) AS count
FROM recipes r;


SELECT * 
FROM (
  SELECT * FROM recipes
) r;


SELECT r.title
FROM (
  SELECT * FROM recipes
) r;

SELECT r.count
FROM (
  SELECT COUNT(id) as count FROM recipes
) r;

*/


-- On veut connaitre les "Ingredients" qui sont utiliser au niveau de "Dessert"
-- 1. Quels sont les recettes qui sont dans "dessert"
/*
SELECT cr.recipe_id
FROM categories c
LEFT JOIN categories_recipes cr ON c.id = cr.category_id
WHERE c.title = 'Dessert';
*/
-- 2. 
/*
SELECT *
FROM recipes
WHERE id IN (1, 2, 3);
*/

SELECT *
FROM recipes
WHERE id IN (
    SELECT cr.recipe_id
    FROM categories c
    LEFT JOIN categories_recipes cr ON c.id = cr.category_id
    WHERE c.title = 'Dessert'
);


SELECT i.*
FROM ingredients_recipes ir
LEFT JOIN ingredients i ON i.id = ir.ingredient_id
WHERE ir.recipe_id IN (
    SELECT cr.recipe_id
    FROM categories c
    LEFT JOIN categories_recipes cr ON c.id = cr.category_id
    WHERE c.title = 'Dessert'
);


SELECT i.*
FROM ingredients_recipes ir
LEFT JOIN ingredients i ON i.id = ir.ingredient_id
WHERE ir.recipe_id IN (
    SELECT cr.recipe_id
    FROM categories c
    LEFT JOIN categories_recipes cr ON c.id = cr.category_id
    WHERE c.title NOT IN ('Dessert', 'Gateau')
);

--- OPTIMISATION QUERY
EXPLAIN QUERY PLAN SELECT i.*
FROM ingredients_recipes ir
LEFT JOIN ingredients i ON i.id = ir.ingredient_id
WHERE ir.recipe_id IN (
    SELECT cr.recipe_id
    FROM categories c
    LEFT JOIN categories_recipes cr ON c.id = cr.category_id
    WHERE c.title NOT IN ('Dessert', 'Gateau')
);


--- REQUETTE CORRELATED LIST SUBQUERY
--  Car la conditon depend d' une requette au dessus (ir)
EXPLAIN QUERY PLAN SELECT i.*
FROM ingredients_recipes ir
LEFT JOIN ingredients i ON i.id = ir.ingredient_id
WHERE ir.recipe_id IN (
    SELECT cr.recipe_id
    FROM categories c
    LEFT JOIN categories_recipes cr ON c.id = cr.category_id
    WHERE cr.recipe_id = ir.recipe_id
);

```


### LES TRANSACTIONS

Les transactions permettent de grouper certaines requete ensemble
et de revenir en arriere en cas de probleme

```sql

--- TRANSACTIONS

/*
BEGIN TRANSACTION;

SELECT * FROM recipes;

DELETE FROM recipes WHERE id = 1;

SELECT * FROM recipes;

ROLLBACK TRANSACTION;

SELECT * FROM recipes;
*/


BEGIN TRANSACTION;

SELECT * FROM recipes;

DELETE FROM recipes WHERE id = 1;

SELECT * FROM recipes;

COMMIT TRANSACTION;

SELECT * FROM recipes;



--- TRANSACTIONS

/*
BEGIN TRANSACTION;

SELECT * FROM recipes;

DELETE FROM recipes WHERE id = 1;

SELECT * FROM recipes;

ROLLBACK TRANSACTION;

SELECT * FROM recipes;
*/


BEGIN TRANSACTION;

SELECT * FROM recipes;

DELETE FROM recipes WHERE id = 1;

SELECT * FROM recipes;

COMMIT TRANSACTION;

SELECT * FROM recipes;

```


### NOTION DE VIEW : CREATE VIEW ...

```sql
-- NOTIONS DE VUES: CREATE VIEW

-- Selectionner la liste des recettes
/*
SELECT * 
FROM recipes r
LEFT JOIN ingredients_recipes ir ON ir.recipe_id = r.id
LEFT JOIN ingredients i ON ir.ingredient_id = i.id
;


SELECT r.title, GROUP_CONCAT(i.name, ', ') as ingredients
FROM recipes r
LEFT JOIN ingredients_recipes ir ON ir.recipe_id = r.id
LEFT JOIN ingredients i ON ir.ingredient_id = i.id
GROUP BY r.title;
*/


--- Creer une vue (CREATE VIEW nameOfView as sqlQuery)
CREATE VIEW recipe_with_ingredients
AS 
  SELECT r.title, GROUP_CONCAT(i.name, ', ') as ingredients
  FROM recipes r
  LEFT JOIN ingredients_recipes ir ON ir.recipe_id = r.id
  LEFT JOIN ingredients i ON ir.ingredient_id = i.id
  GROUP BY r.title;


/*
SELECT * 
FROM recipe_with_ingredients;
*/

SELECT *
FROM recipe_with_ingredients 
WHERE ingredients LIKE '%Farine%';



EXPLAIN QUERY PLAN SELECT *
FROM recipe_with_ingredients 
WHERE ingredients LIKE '%Farine%';


-- Supprimer une vue (DROP VIEW nameOfView)
DROP VIEW recipe_with_ingredients;

```


### Les Triggers (CREATE TRIGGER)

```sql
Les triggers permettent de rajouter de la logique
lorsquon a des operations qui sont effectuees sur ma base de donnees de voir combien de fois les ingredients sont utilises.

Par example quand on fait CRUD (ajout, mise a jour, lire, supprimer)
ALTER TABLE ingredients 
ADD COLUMN usage_count INTEGER DEFAULT 0;


SELECT * FROM ingredients;

-- Ce trigger sera appele 
-- apres insertion de donnees dans la table "ingredients_recipes"
-- dans le cas ou NEW.email != OLD.email
/*
CREATE TRIGGER update_usage_count_on_ingredients_linked
AFTER INSERT ON ingredients_recipes
WHERE NEW.email != OLD.email
*/

CREATE TRIGGER update_usage_count_on_ingredients_linked
AFTER INSERT ON ingredients_recipes
BEGIN 
   UPDATE ingredients
   SET usage_count = usage_count + 1
   WHERE id = NEW.ingredient_id;
END;


-- DROP Trigger
-- DROP TRIGGER decrement_usage_count_on_ingredients_unlinked


CREATE TRIGGER decrement_usage_count_on_ingredients_unlinked
AFTER INSERT ON ingredients_recipes
BEGIN
   UPDATE ingredients
   SET usage_count = usage_count - 1
   WHERE id = OLD.ingredient_id;
END;



CREATE TRIGGER decrement_usage_count_on_ingredients_unlinked
AFTER DELETE ON ingredients_recipes
BEGIN
   UPDATE ingredients
   SET usage_count = usage_count - 1
   WHERE id = OLD.ingredient_id;
END;


-- SELECT * FROM sqlite_master;
SELECT * FROM sqlite_master WHERE type = 'trigger';



-- Insertion d' identifiant a la table intermediaire (ingredients_recipes)
-- INSERT INTO ingredients_recipes (recipe_id, ingredient_id, quantity, unit) VALUES
-- (2, 7, 10, 'g');


DELETE FROM ingredients_recipes WHERE recipe_id = 1 AND ingredient_id = 7;
```


### 2. MYSQL
https://mariadb.com/downloads/community/


### Creer une base de donnees

```sql

CREATE DATABASE tuto;
DROP DATABASE tuto;

```

### Creer une table en MYSQL

```sql

-- UNSIGNED ()
CREATE TABLE posts (
    id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    content LONGTEXT,
    online VARCHAR(255) DEFAUT 0
);

INSERT INTO posts (title, online) VALUES ('Hello', 0);
-- INSERT INTO posts (title, online) VALUES ('Hello online', 1);
INSERT INTO posts SET title = 'Hello online', online = 1;
-- INSERT INTO posts SET title = 'Hello bad', online = 'azeaze';


SELECT * FROM posts;


UPDATE posts SET online = 1 WHERE id = 3;

ALTER TABLE posts
MODIFY online BOOLEAN NOT NULL DEFAULT 0;


-- Voir l' encodage qui est utiliser globalement par notre server
-- utf8mb3
SHOW VARIABLES LIKE 'character_set_server'; 

SELECT default_character_set_name FROM information_schema.SCHEMATA
WHERE schema_name = 'tuto';

```

### Sauvegarder des donnees temporelles (DATE, DATETIME, TIMESTAMP, YEAR)

```sql

-- Ajout de column a une table
ALTER TABLE posts
ADD published_at DATETIME;


INSERT INTO posts (title, published) VALUES ('Hello world', '2020-02-13 12:00:00');


SELECT title, YEAR(published_at) FROM posts;
SELECT title, TIMEDIFF(NOW(), published_at) FROM posts;
SELECT title, published_at FROM posts WHERE YEAR(published_at) = '2020';
SELECT title, published_at FROM posts WHERE published_at <= NOW();
SELECT title, published_at FROM posts WHERE published_at <= '2020';


-- Ajout de column a une table
ALTER TABLE posts
ADD created_at TIMESTAMP;

UPDATE posts SET created_at = '2020-01-01 12:00:00';

SELECT * FROM posts;

-- Changer le fuseau horaire de ma session SQL
SET time_zone = '+03:00';

SELECT * FROM posts;

-- Connaitre le fuseau de notre server
SELECT @@global.time_zone, @@session.time_zone;


-- Connaitre la difference de decalage entre le UTC et notre localisation (Paris, Moscow)
SELECT TIMEDIFF(NOW(), CONVERT_TZ(NOW(), @@session.time_zone, '+00:00'));


-- Ajout de champs de date de creation
/*
ALTER TABLE posts
ADD created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
*/

ALTER TABLE posts
ADD created_at DATETIME NOT NULL,
ADD updated_at DATETIME NOT NULL;

SELECT * FROM posts;


UPDATE posts SET title = 'Hello' WHERE id = 1;
```

### Types spaciaux (Geometric)

```sql
ALTER TABLE posts
ADD location POINT;



-- POINT(longitude latitude)
INSERT INTO posts (title, location) VALUES 
('Perpignan', ST_GeomFromText('POINT(2.895600 42.698601)')),
('Montpellier', ST_GeomFromText('POINT(3.8977200 43.611900)')),
('Paris', ST_GeomFromText('POINT(2.349014 48.864716)')),
;

-- Calcul de distance entre la ville de Monpellier et de Perpignan

SELECT CONCAT(
    ROUND(
    ST_Distance_Sphere(
    (SELECT location FROM posts WHERE title = 'Perpignan'),
    (SELECT location FROM posts WHERE title = 'Montpellier')
) / 1000), ' km') as distance; -- 129 km


-- Calcul de distance entre la ville de  Perpignan et Paris

SELECT CONCAT(
    ROUND(
    ST_Distance_Sphere(
    (SELECT location FROM posts WHERE title = 'Perpignan'),
    (SELECT location FROM posts WHERE title = 'Paris')
) / 1000), ' km') as distance; -- 129 km


SELECT title FROM posts WHERE ST_Distance_Sphere(
    (SELECT location FROM posts WHERE title = 'Perpignan'),
    location
) < 200000; -- 200000 m = 200 km


SELECT title FROM posts WHERE ST_Distance_Sphere(
    (SELECT location FROM posts WHERE title = 'Perpignan'),
    location
) > 200000; -- 200000 m = 200 km

```



### Donnees JSON

```sql

CREATE TABLE posts (
    id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    content LONGTEXT,
    online VARCHAR(255) DEFAUT 0,
    author JSON
);


-- Insertion d' articles
INSERT INTO posts (title, author) VALUES
('Titre de test', '{"age": 20, "firstname": "John"}');

INSERT INTO posts (title, author) VALUES
('Titre de jane', '{"age": 30, "firstname": "Jane"}');



INSERT INTO posts (title) VALUES
('Titre de sans author');


INSERT INTO posts (title, author) VALUES
('Titre de sans author', '{"age": 25, "firstname": "John\\" Doe"}');


SELECT title, author->"$.age" FROM posts;
SELECT * FROM posts WHERE author->"$.age" > 20;
SELECT * FROM posts WHERE author->"$.age" <= 20;
SELECT author->"$.age" FROM posts;
SELECT id, author->"$.age" FROM posts;


UPDATE posts SET author = JSON_SET(author, '$.age', 25);
UPDATE posts SET author = JSON_SET(author, '$.age', author->'$.age' + 2) WHERE id = 1;


SELECT author->"$.firstname" FROM posts;
SELECT author->>"$.firstname" FROM posts;

```

### Recherche FullText 

- Creer un INDEX de type FULLTEXT

```sql

-- FULLTEXT marche sur les moteurs de stcokages de donnees: InnoDB et MyISAM
CREATE TABLE posts (
    id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    content LONGTEXT,
    online VARCHAR(255) DEFAUT 0,
    FULLTEXT (content)
);



INSERT INTO posts (title, content) VALUES
('Lorem', 'Laudantium laudantium doloribus aperiam. Molestias est iste commodi numquam molestias veritatis dolor'),
('Rator Laveur', 'Le raton laveur est une espece de mammifere'),
('Raton rat', 'Le raton le bebe du rat'),
('Raton space', 'Le raton qui avait comme emploi laveur de carreau'),
('Raton double', 'Le raton qui avait comme ami un autre raton laveur'),
;


SELECT * FROM posts;
SELECT * FROM posts WHERE content LIKE '%Raton%';

-- Requette optimisee
SELECT * FROM posts WHERE MATCH(content) AGAINST('raton' IN NATURAL LANGUAGE MODE);

SELECT * FROM posts WHERE MATCH(content) AGAINST('raton laveur' IN NATURAL LANGUAGE MODE);

SELECT * FROM posts WHERE MATCH(content) AGAINST('\"raton laveur\"' IN NATURAL LANGUAGE MODE);

SELECT * FROM posts WHERE MATCH(content) AGAINST('+raton +laveur' IN BOOLEAN MODE);

SELECT * FROM posts WHERE MATCH(content) AGAINST('+raton -laveur' IN BOOLEAN MODE);

SELECT * FROM posts WHERE MATCH(content) AGAINST('+raton laveur' IN BOOLEAN MODE);

/*
SELECT *, MATCH(content) AGAINST('+raton laveur' IN BOOLEAN MODE) AS score
FROM posts
HAVING scor > 0
ORDER BY score DESC;
*/


SELECT *, MATCH(content) AGAINST('+raton laveur' IN NATURAL LANGUAGE MODE) AS score
FROM posts
MATCH(content) AGAINST('+raton laveur' IN NATURAL LANGUAGE MODE);



SELECT *, MATCH(content) AGAINST('+raton laveur' IN NATURAL LANGUAGE MODE) AS score
FROM posts
MATCH(content) AGAINST('+raton laveur' IN NATURAL LANGUAGE MODE WITH QUERY EXPANSION);



SELECT * FROM INFORMATION_SCHEMA.INNODB_FT_DEFAULT_STOPWORD;

```


### Gestion des permissions et privileges des utilisateurs (CREATE USER)

Donner access a de nouveaux utilisateurs
```sql

-- CREATE USER 'nomUtilisateur'@'%' IDENTIFIED BY 'motDePass';
-- % : n' importe quel interface
-- 'readonly'@'%' : On donne acces a l' utilisateur 'readonly' depuis n' importe quel interface. 

CREATE USER 'readonly'@'%' IDENTIFIED BY '0000';


-- Donner une permission a un utilisateur specific
-- Dans notre cas on va donner la permission a l' utilisateur de faire un SELECT

GRANT SELECT ON tuto.posts TO 'readonly'@'%'


-- Lister l' ensemble d' utilisateurs qu' on a dans notre BD
-- Si on est connecte en tant qu' administrateur
SELECT * FROM mysql.user;


-- Creer une table d' utilisateur
CREATE TABLE users (
    id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255)
)

-- Lister l' ensemble des permissions donner a l' utilisateur 'readonly'
SHOW GRANTS FOR 'reaonly'@'%';


-- Supprimer une permission specific
REVOKE SELECT `tuto`.`posts` FROM `readonly`@`%`;


-- On reaffiche l' ensemble des permissions donner a l' utilisateur 'readonly'
SHOW GRANTS FOR 'reaonly'@'%';


-- Supprimer un utilisateur
DROP USER 'readonly'@'%';


```


### Les procedures stockees (CREATE PROCEDURE)

Ils permettent de creer des fonctions qu' on pourra memoriser dans notre base de donnees
et ensuite on pourra l' utiliser soit pour modifier ou recuperer des informations
semblable aux VUES (CREATE VIEW)

```sql

SELECT title,
       ST_Distance_Sphere(
          location,
          (SELECT location FROM posts WHERE title = 'Montpellier')
       ) as distance
       FROM posts
       HAVING distance IS NOT NULL;


-- Create procedure
/*
DELIMITER $

CREATE PROCEDURE getDistances ()
BEGIN
   SELECT * FROM posts
END$

DELIMITER ;
*/


DELIMITER $

CREATE OR REPLACE PROCEDURE getDistances ()
BEGIN
   SELECT title,
       ST_Distance_Sphere(
          location,
          (SELECT location FROM posts WHERE title = 'Montpellier')
       ) as distance
       FROM posts
       HAVING distance IS NOT NULL;

END$

DELIMITER ;


-- Lister l' ensemble de procedures qui sont stocker dans mon systeme
SHOW PROCEDURE STATUS;

SHOW PROCEDURE STATUS LIKE 'getDistances';


-- Utiliser notre procedure
CALL getDistance();



-- Creer une procedure parametree

DELIMITER $

CREATE OR REPLACE PROCEDURE getDistances (
    IN origin VARCHAR(255)
)
BEGIN
   SELECT title,
       ST_Distance_Sphere(
          location,
          (SELECT location FROM posts WHERE title = origin)
       ) as distance
       FROM posts
       HAVING distance IS NOT NULL;

END$

DELIMITER ;


CALL getDistances('Perpignan');
CALL getDistances('Paris');



-- Creer une procedure pour trouver la ville la plus proche

/*
DELIMITER $

CREATE OR REPLACE PROCEDURE getClosesCity (
    IN origin VARCHAR(255)
    OUT closestCity VARCHAR(255)
)
BEGIN
   SELECT title,
       ST_Distance_Sphere(
          location,
          (SELECT location FROM posts WHERE title = origin)
       ) as distance
       FROM posts
       WHERE title != origin
       HAVING distance IS NOT NULL
       ORDER BY distance ASC
       LIMIT 1;

END$

DELIMITER ;


CALL getClosesCity('Perpignan');
CALL getClosesCity('Paris');
*/


DELIMITER $

CREATE OR REPLACE PROCEDURE getClosestCity (
    IN origin VARCHAR(255)
    OUT closestCity VARCHAR(255)
)
BEGIN
   SELECT subquery.title INTO closestCity FROM (
      SELECT title,
       ST_Distance_Sphere(
          location,
          (SELECT location FROM posts WHERE title = origin)
       ) as distance
       FROM posts
       WHERE title != origin
       HAVING distance IS NOT NULL
       ORDER BY distance ASC
       LIMIT 1;
   ) as subquery;
END$

DELIMITER ;


CALL getClosestCity('Montpellier', @city);


SELECT @city;


-- Cas INOUT

DELIMITER $

CREATE OR REPLACE PROCEDURE getClosestCity (
    INOUT origin VARCHAR(255)
)
BEGIN
   SELECT subquery.title INTO origin FROM (
      SELECT title,
       ST_Distance_Sphere(
          location,
          (SELECT location FROM posts WHERE title = origin)
       ) as distance
       FROM posts
       WHERE title != origin
       HAVING distance IS NOT NULL
       ORDER BY distance ASC
       LIMIT 1;
   ) as subquery;
END$

DELIMITER ;


SET @city = "Montpellier";
CALL getClosestCity(@city);
SELECT @city;


```

### Sauvegarde de la base de donnees

Depuis un terminal

```sql
-- Exporter la base de donnees

> mysqldump -u root -p tuto
password: (Enter)

> mysqldump -u root -p tuto > dump.sql


-- Importer la base de donnees

> mysql -u root -p tuto < dump.sql
password: ***

```



