DROP TABLE IF EXISTS auditlogs;
DROP TABLE IF EXISTS events;
DROP TABLE IF EXISTS users_modules;
DROP TABLE IF EXISTS modules;
DROP TABLE IF EXISTS users;

CREATE TABLE users (
id            INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
principal     VARCHAR(255) NOT NULL, 
credential    VARCHAR(32) NOT NULL,
salt          VARCHAR(32) NOT NULL,
firstname     VARCHAR(32) NOT NULL,
lastname      VARCHAR(32) NOT NULL,
description   TEXT,
verification  VARCHAR(32) NOT NULL,
verified      BOOLEAN NOT NULL DEFAULT 0,
suspended     BOOLEAN NOT NULL DEFAULT 0,
created       TIMESTAMP DEFAULT NOW(),
UNIQUE INDEX(principal));

CREATE TABLE modules (
id            INT UNSIGNED NOT NULL PRIMARY KEY,
name          VARCHAR(32) NOT NULL,
created       TIMESTAMP DEFAULT NOW());

CREATE TABLE users_modules (
user_id       INT UNSIGNED NOT NULL,
module_id     INT UNSIGNED NOT NULL,
created       TIMESTAMP DEFAULT NOW(),
FOREIGN KEY(user_id) REFERENCES users(id),
FOREIGN KEY(module_id) REFERENCES modules(id));

CREATE TABLE events (
id            INT UNSIGNED NOT NULL PRIMARY KEY,
name          VARCHAR(64) NOT NULL,
created       TIMESTAMP DEFAULT NOW());

CREATE TABLE auditlogs (
id            INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
user_id       INT UNSIGNED NOT NULL,
event_id      INT UNSIGNED NOT NULL,
new_value     TEXT,
old_value     TEXT,
created       TIMESTAMP DEFAULT NOW(),
FOREIGN KEY(user_id) REFERENCES users(id),
FOREIGN KEY(event_id) REFERENCES events(id),
INDEX(created));

