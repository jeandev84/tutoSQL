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
  name VARCHAR(150) NOT NULL,
  usage_count INTEGER DEFAULT 0 NOT NULL
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