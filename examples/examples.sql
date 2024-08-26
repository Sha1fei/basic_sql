CREATE DATABASE company_repository;
DROP DATABASE company_repository;
CREATE SCHEMA company_storage;
DROP SCHEMA company_storage;
DROP TABLE company;
CREATE TABLE company("id" INT GENERATED ALWAYS AS IDENTITY, "name" VARCHAR(128) UNIQUE NOT NULL, "date" DATE NOT NULL CHECK (date > '1995-01-01' AND date < '2020-01-01'), PRIMARY KEY (id) , UNIQUE(name, date));
INSERT INTO company(name, date) VALUES ('Google', '2011-01-01'), ('Facebook', '2012-01-01');
CREATE TABLE employee("id" INT GENERATED ALWAYS AS IDENTITY, first_name VARCHAR(128), last_name VARCHAR(128), salary INT, UNIQUE(first_name, last_name));
INSERT INTO employee(first_name, last_name, salary) VALUES ('Ivan', 'Ivanov', 1000), ('Sveta', 'Svatikova', 2000), ('Petr', 'Petrov', 3000);
INSERT INTO employee(first_name, last_name, salary) VALUES ('Ivan', 'Sidorov', 1000)
SELECT DISTINCT first_name AS fname FROM employee ORDER BY fname DESC;
SELECT first_name AS fname, last_name AS lname, salary FROM employee ORDER BY salary DEsc limit 3 offset 1;
SELECT first_name AS fname, salary FROM employee WHERE salary IN  (1000, 2000) OR (first_name LIKE '%etr' AND last_name = 'Petrov');