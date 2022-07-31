-- SQLite

-- CREER UNE TABLE DE RECETTE
CREATE TABLE recipes (
   title VARCHAR(150),
   slug VARCHAR(50),
   content TEXT,
   duration SMALLINT,
   online BOOLEAN,
   created_at DATETIME
);


--- Some comments (CTRL+SHIFT+Q)
/* 
recipes
 - title (varchar)
 - content (text)
 - slug (varchar)
 - duration (en minutes)
 - online (boolean)
 - created_at (datetime)
*/

-- CREER UNE TABLE D' ARTICLES
CREATE TABLE posts (
   title VARCHAR(150),
   content TEXT,
   category VARCHAR(50),
   created_at DATETIME
);