DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS visits;

CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  password_digest VARCHAR,
  name VARCHAR, 
  age INTEGER, 
  location VARCHAR, 
  avatar_img_url VARCHAR
);

CREATE TABLE visits (
  visited_id INTEGER,
  visitor_id INTEGER,
  created_at DATETIME
);