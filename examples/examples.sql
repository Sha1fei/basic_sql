CREATE DATABASE company_repository;
DROP DATABASE company_repository;
CREATE SCHEMA company_storage;
DROP SCHEMA company_storage;
DROP TABLE company;
DROP TABLE employee;
CREATE TABLE company("id" INT GENERATED ALWAYS AS IDENTITY, "name" VARCHAR(128) UNIQUE NOT NULL, "date" DATE NOT NULL CHECK (date > '1995-01-01' AND date < '2020-01-01'), PRIMARY KEY (id) , UNIQUE(name, date));
INSERT INTO company(name, date) VALUES ('Google', '2011-01-01'), ('Facebook', '2012-01-01');
CREATE TABLE employee("id" INT GENERATED ALWAYS AS IDENTITY, first_name VARCHAR(128), last_name VARCHAR(128), salary INT, company_id INT references company (id), company_name VARCHAR(128), UNIQUE(first_name, last_name), FOREIGN KEY (company_name) references company(name) ON DELETE cascade);
INSERT INTO employee(first_name, last_name, salary) VALUES ('Ivan', 'Ivanov', 1000 ), ('Sveta', 'Svatikova', 2000), ('Petr', 'Petrov', 3000);
INSERT INTO employee(first_name, last_name, salary) VALUES ('Ivan', 'Sidorov', 1000)
select distinct first_name as fname from employee order by fname desc;
select first_name as fname, last_name as lname, salary from employee order by salary desc limit 3 offset 1;
SELECT first_name AS fname, salary FROM employee WHERE salary IN  (1000, 2000) OR (first_name LIKE '%etr' AND last_name = 'Petrov') OR salary BETWEEN 1000 AND 2000;
SELECT first_name as fname, last_name as lname, salary from employee;
SELECT sum(salary) AS sum, avg(salary) AS avg, max(salary) AS max, min(salary) AS min, count(salary) AS count, now() FROM employee;
SELECT lower(first_name) AS fname, upper(last_name) as lname, concat(first_name, ' ', last_name) FROM employee;
SELECT * FROM company;
SELECT * FROM employee;

DROP TABLE company_storage.company;
DROP TABLE company_storage.employee;

CREATE TABLE company_storage.company("id" INT GENERATED ALWAYS AS IDENTITY, "name" VARCHAR(128) UNIQUE NOT NULL, "date" DATE NOT NULL CHECK (date > '1995-01-01' AND date < '2020-01-01'), PRIMARY KEY (id) , UNIQUE(name, date));
INSERT INTO company_storage.company(name, date) VALUES ('Google', '2011-01-01'), ('Facebook', '2012-01-01');
CREATE TABLE company_storage.employee("id" INT GENERATED ALWAYS AS IDENTITY, first_name VARCHAR(128), last_name VARCHAR(128), salary INT, company_id INT references company_storage.company(id), company_name VARCHAR(128), UNIQUE(first_name, last_name), FOREIGN KEY (company_name) references company_storage.company(name) ON DELETE cascade);
INSERT INTO company_storage.employee(first_name, last_name, salary, company_id, company_name) VALUES ('Ivan', 'Ivanov', 1000, 1, 'Google' ), ('Sveta', 'Svatikova', 2000, 2, 'Facebook'), ('Petr', 'Petrov', 3000, 1, 'Google');

SELECT name, date FROM company_storage.company WHERE id = 1 UNION ALL SELECT name, date FROM company_storage.company WHERE id = 2;s
SELECT name FROM (SELECT * FROM company_storage.company c ORDER BY id DESC limit 3) WHERE id IN (SELECT company_id FROM company_storage.employee WHERE salary > 1000);
SELECT * FROM (VALUES ('Google', '2011-01-01'), ('Facebook', '2012-01-01'));


INSERT INTO company_storage.employee(first_name, last_name, salary) VALUES ('Test', 'Testov', NUll);
UPDATE company_storage.employee SET salary = 10000 WHERE first_name = 'Test' RETURNING *;
DELETE FROM company_storage.employee WHERE first_name = 'Test' RETURNING *;

DROP TABLE company_storage.company;
DROP TABLE company_storage.employee;
DROP TABLE company_storage.contact;
DROP TABLE company_storage.employeeId_contactId;
CREATE TABLE company_storage.company(id INT GENERATED ALWAYS AS IDENTITY, name VARCHAR(128) UNIQUE NOT NULL, date DATE NOT NULL CHECK (date > '1995-01-01' AND date < '2020-01-01'), PRIMARY KEY (id));
CREATE TABLE company_storage.employee(id INT GENERATED ALWAYS AS IDENTITY, first_name VARCHAR(128), last_name VARCHAR(128), salary INT, company_id INT references company_storage.company(id) ON DELETE CASCADE, PRIMARY KEY (id));
CREATE TABLE company_storage.contact(id INT GENERATED ALWAYS AS IDENTITY, phone VARCHAR(128), type VARCHAR(128), PRIMARY KEY (id));
CREATE TABLE company_storage.employeeId_contactId(id INT GENERATED ALWAYS AS IDENTITY, employeeId INT references company_storage.employee(id) ON DELETE CASCADE, contactId INT references company_storage.contact(id)ON DELETE CASCADE);
INSERT INTO company_storage.company(name, date) VALUES ('Google', '2011-01-01'), ('Facebook', '2012-01-01');
INSERT INTO company_storage.employee(first_name, last_name, salary, company_id) VALUES ('Ivan', 'Ivanov', 1000, 1), ('Sveta', 'Svatikova', 2000, 2), ('Petr', 'Petrov', 3000, 1);
INSERT INTO company_storage.contact(phone, type) VALUES ('666-666', 'work'), ('222-222', 'work'), ('8-999-999-99-99', 'private'), ('8-999-333-33-33', 'private') , ('8-999-111-11-11', 'private');
INSERT INTO company_storage.employeeId_contactId(employeeId , contactId) VALUES (1, 1), (2, 1), (3, 2), (1, 3), (2, 4), (3, 5);
SELECT (emp.first_name || ' ' || emp.last_name) AS employee, comp.name AS company, (c.phone || ' ' || c.type) AS contact  FROM company_storage.employee emp JOIN company_storage.company comp ON emp.company_id = comp.id JOIN company_storage.employeeid_contactid ec ON emp.id = ec.employeeId JOIN company_storage.contact c ON c.id = ec.contactId WHERE c.type = 'private';
SELECT (emp.first_name || ' ' || emp.last_name) AS employee, comp.name AS company FROM company_storage.employee emp JOIN company_storage.company comp ON emp.company_id = comp.id;
SELECT (emp.first_name || ' ' || emp.last_name) AS employee, comp.name AS company FROM company_storage.employee emp RIGHT JOIN company_storage.company comp ON emp.company_id = comp.id;
SELECT (emp.first_name || ' ' || emp.last_name) AS employee, comp.name AS company FROM company_storage.employee emp LEFT JOIN company_storage.company comp ON emp.company_id = comp.id;
SELECT (emp.first_name || ' ' || emp.last_name) AS employee, comp.name AS company FROM company_storage.employee emp FULL JOIN company_storage.company comp ON emp.company_id = comp.id;

SELECT  COUNT(salary), salary FROM company_storage.employee e GROUP BY e.salary;
SELECT first_name, salary, MAX(salary) OVER(), COUNT(salary) over(partition BY e.first_name) FROM company_storage.employee e GROUP BY e.salary, e.first_name;
SELECT * FROM company_storage.employee e;
CREATE VIEW custom_sql_view AS SELECT * FROM company_storage.company c ORDER BY c.name;
SELECT * FROM custom_sql_view;

ALTER TABLE if EXISTS company_storage.company ADD COLUMN test VARCHAR(128);
ALTER TABLE if EXISTS company_storage.company DROP test;

SELECT generate_series * random() AS random, generate_series AS series FROM generate_series(1, 100);


// Командды для работы с postgresql

psql --host=localhost --port=5432 --dbname=new_db_name - подклюяение к базе данных new_db_name
  \l - список все баз данных
  \c new_db_name - переключение на базу данных new_db_name
  \d - список всех таблицы в текущей базе данных
  \dt - список всех таблиц (БЕЗ sequence) в текущей базе данных
  \d table_name - информация о таблице table_name
  \q - выход из бд
pg_dump


