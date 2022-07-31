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
('Madeleine', 'madeleine', 30, 1),
('Salade de fruit', 'salade-de-fruit', 10, 1);


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
('Oeuf'),
('Miel');



-- Insertion d' identifiant a la table intermediaire (ingredients_recipes)
INSERT INTO ingredients_recipes (recipe_id, ingredient_id, quantity, unit) VALUES
(2, 1, 150, 'g'),
(2, 2, 200, 'g'),
(2, 3, 8, 'g'),
(2, 4, 100, 'g'),
(2, 5, 50, 'g'),
(2, 6, 3, NULL),
(3, 1, 50, 'g');


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


-- Modifier la date d' une recette
UPDATE recipes SET date = 100 WHERE id =2;


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
*/

/*
SELECT * 
FROM ingredients i
JOIN ingredients_recipes ir ON ir.ingredient_id = i.id;

SELECT * 
FROM ingredients i
LEFT JOIN ingredients_recipes ir ON ir.ingredient_id = i.id;
*/


/*
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
*/


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
*/
SELECT *
FROM ingredients i
LEFT JOIN ingredients_recipes ir ON ir.ingredient_id = i.id;
-- LEFT JOIN recipes r ON ir.recipe_id = r.id


