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
  - `CREATE UNIQUE INDEX unique_index ON company (name, manager);` - создание новых индексов для таблицы (может быть составным) `UNIQUE` - необязателен, придает уникальность ключу (не создаст подтаблицу из двух и более строк по одному индексу)
- ### Drop
  - `DROP DATABASE company_repository;` - удаление БД
  - `DROP SCHEMA company_storage;` - удаление схемы в БД
  - `DROP TABLE company;` - удаление схемы в БД
- ### Alter
  - `ALTER TABLE if EXISTS company_storage.company ADD COLUMN test VARCHAR(128);` - изменение текущей таблицы
     - `ADD` - добавлние колонки
     - `DROP` - удаление колонки
     - `ALTER COLUMN test VARCHAR(256)`; - измененеие типа колонки
     - `ADD CHECK (Age > 21);` - изменение ограничения
     - `DROP FK_Orders_To_Customers;` - удаления ограничения по имени

# PostgresSql commands
  - `psql --host=localhost --port=5432 --dbname=new_db_name` - подклюяение к базе данных new_db_name
    - `c "new_db_name_2` - создание базы данных new_db_name_2
    - `\l` - список все баз данных
    - `\c new_db_name` - переключение на базу данных new_db_name
    - `\d` - список всех таблицы в текущей базе данных
    - `\dt` - список всех таблиц (БЕЗ sequence) в текущей базе данных
    - `\d table_name` - информация о таблице table_name
    - `\q` - выход из бд
    - `-d new_db_name -f new_db_name.sql` - применение sql файла базы данных для накатывания на созданную бд 
  `pg_dump -d new_db_name > new_db_name.sql` - создание дампа из базы данных

# Transaction
  - `begin` - начало транзации (можно выполнять несколько коммад в рамках одной транзации)
  - `commit` - коммит изменний
  - `rollback` - откат изменений
  - ### Transaction issues
    - `Lost Update` - обе транзакции обновляют данные одновременно, а затем вторая их откатывает, теряются измененяи обоих транзакций
      ![lost update](images/lostUpdate.png)
    - `Dirty Read` - Первая тразакция читает изменнные данные второй транзакцией, вторая транзакиця после их откатывает, а первая продолжает работать с грязными данными
      ![dirty read](images/dirtyRead.png)
    - `Non Repeatable Read` - происходит когда первая транзакция читает данные дважды, но послепепрвого прочтенияб вторая транзакция их изменяет и делает коммит, вследствии чего первая тразакция во второй выборке получит другие данные 
      ![non repeatable read](images/nonRepeatableRead.png)
    - `Last Commit Wins` - происходит в случае если обе команды читают данные, но первая успевает их обновить и закомммить раньше, вторая же позже - тогда теряются изменения первой транзакции 
      ![last commit wins](images/lastCommitWins.png)
    - `Phantom Read` - первая транзакиця читает дважда данные, в промежутке между ними вторая транзация успевает их изменить или удалить, в следствии чего втоая выборка вернет другой резульататы
      ![Phantom Read](images/phantomRead.png)
  