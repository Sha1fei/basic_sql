CREATE DATABASE company_repository;
DROP DATABASE company_repository;
CREATE SCHEMA company_storage;
DROP SCHEMA company_storage;
DROP TABLE company;
DROP TABLE employee;
CREATE TABLE company("id" INT GENERATED ALWAYS AS IDENTITY, "name" VARCHAR(128) UNIQUE NOT NULL, "date" DATE NOT NULL CHECK (date > '1995-01-01' AND date < '2020-01-01'), PRIMARY KEY (id) , UNIQUE(name, date));
INSERT INTO company(name, date) VALUES ('Google', '2011-01-01'), ('Facebook', '2012-01-01');
CREATE TABLE employee("id" INT GENERATED ALWAYS AS IDENTITY, first_name VARCHAR(128), last_name VARCHAR(128), salary INT, company_id INT references company (id), UNIQUE(first_name, last_name));
INSERT INTO employee(first_name, last_name, salary) VALUES ('Ivan', 'Ivanov', 1000), ('Sveta', 'Svatikova', 2000), ('Petr', 'Petrov', 3000);
INSERT INTO employee(first_name, last_name, salary) VALUES ('Ivan', 'Sidorov', 1000)
select distinct first_name as fname from employee order by fname desc;
select first_name as fname, last_name as lname, salary from employee order by salary desc limit 3 offset 1;
SELECT first_name AS fname, salary FROM employee WHERE salary IN  (1000, 2000) OR (first_name LIKE '%etr' AND last_name = 'Petrov') OR salary BETWEEN 1000 AND 2000;
SELECT first_name as fname, last_name as lname, salary from employee;
SELECT sum(salary) AS sum, avg(salary) AS avg, max(salary) AS max, min(salary) AS min, count(salary) AS count, now() FROM employee;
SELECT lower(first_name) AS fname, upper(last_name) as lname, concat(first_name, ' ', last_name) FROM employee;
SELECT * FROM company;
SELECT * FROM employee;