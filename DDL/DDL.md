# Data Definition Language

- ### Create
  - `CREATE DATABASE company_repository;` - создание новой БД
  - `CREATE SCHEMA company_storage;` - создание новой схемы в БД
  - `CREATE TABLE company("id" INT GENERATED ALWAYS AS IDENTITY, "name" VARCHAR(128) UNIQUE NOT NULL, manager VARCHAR(128) REFERENCES employee (id), "date" DATE NOT NULL CHECK (date > '1995-01-01' AND date < '2020-01-01'), PRIMARY KEY (id) , UNIQUE(name, date), FOREIGN KEY (company_name) REFERENCES company(name) ON DELETE CASCADE));` - создание новой таблицы с полями в БД
     - `GENERATED ALWAYS AS IDENTITY` - автоинкремент ключа
     - `UNIQUE` - уникальный ключ
     - `NOT NULL` - не null
     - `CHECK (...)` - проверка значения на условие 
     - `PRIMARY KEY` - основной ключ
     - `REFERENCES` - указатель на колонку строннюю таблицу, либо FOREIGN KEY (company_name) REFERENCES company(name)
     - `ON DELETE CASCADE` - параметр для FOREIGN KEY для автоматического удаления свяязанных записей из других таблиц
- ### Drop
  - `DROP DATABASE company_repository;` - удаление БД
  - `DROP SCHEMA company_storage;` - удаление схемы в БД
  - `DROP TABLE company;` - удаление схемы в БД
- ### Alter
