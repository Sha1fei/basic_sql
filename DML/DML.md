# Data Manipulation Language

- ### Insert
    - `INSERT INTO company(name, date) VALUES ('Google', '2011-01-01'), ('Facebook', '2012-01-01');` - вставка строчки в таблицу БД 
- ### Delete
    - `DELETE FROM company_storage.employee WHERE first_name = 'Test' RETURNING *;` - удаление строки таблицы 
      - `RETURNING *` - возращает удаленную строку
- ### Update
    - `UPDATE company_storage.employee SET salary = 10000 WHERE first_name = 'Test' RETURNING *;` - обновление строки таблицы
      - `SET` - устанавливаемые значения
      - `RETURNING *` - возращает обновленную строку
- ### Select
    - `SELECT DISTINCT name AS company, date FROM company WHERE (name != 'Facebook') AND (name LIKE '%o%') AND id IN (1, 2, 8, 9, 10, 11) ORDER BY name, date DESC LIMIT 2 OFFSET 2;` - выбор данных из таблицы
      - `name AS company` - переименовать выводимый столбец
      - `DISTINCT` - только уникальные значения
      - `ORDER BY name DESC` - отсоритровать по столбцу
      - `LIMIT 2` - количество выводимых значений
      - `OFFSET 2` - Смещение выводимых значений по таблице
      - `WHERE name != 'Facebook'` - фильтрация данных c условием
      - `WHERE name LIKE '%o%'` - фильтрация данных, LIKE - полное совпадение, % - не имеющие значение символы до или после
      - `WHERE date BETWEEN '2011-01-01' AND '2011-03-01'` - фильтрация данных, по диапазону BETWEEN и AND значениями 
      - `WHERE id IN (1, 2, 8, 9, 10, 11)` - фильтрация данных,из списка значений
      - `AND ... OR` - конъюнкция и дизъюнкция условий
      - `IS NOT NULL` - для сравнения на NULL используется IS, а не =
      - `WHERE (end_date - start_date) > INTERVAL 5 DAY;` - `INTREVAL` задает временной диапазон
      - `EXTRACT(DAY FROM TIMESTAMP '2016-12-31 13:30:15') d;` - `EXTRACT` достает значение из TIMESTAMP (MINUTE, MONTH, YEAR, HOUR и т.д.)
      - `CAST(12005.6 AS DECIMAL), CONVERT(12005.4, DECIMAL);` - `CAST` и `CONVERT` - преобразуют типы значений для дальнейшего использования в запросах (DATE, CHAR, DECIMAL и т.д.)
      - `SELECT EXISTS(SELECT * FROM Products WHERE ProductName = "Mozzarella") AS Mozzarella;` - позволяет использовать true/false вмсето результат запроса при наличии/отсутсвиии занчений
- ### Union
  - `SELECT name, date FROM company WHERE id = 1 UNION ALL SELECT name, date FROM company WHERE id = 2` 
        - `UNION ALL` - объединяет все результаты выборки из таблиц, 
        - `UNION` - выводит только уникальные (не повторяющиеся в обоих множжествах)
        - `INRESECT` - выводит только повторящиеся (присутствуют в обоих множествах)
        - `EXCEPT` - исключаем из множества A все что пересекается с множеством B
- ### Nested Request
    - `SELECT name FROM (SELECT * FROM company ORDER BY id DESC LIMIT 3) WHERE id IN (SELECT company_id FROM employee WHERE salary > 1000)`
      - можем подставлять подзапросы со столбцами с колонками в `FROM` и `WHERE`, сначала выполнится самый вложенный
    - `SELECT salary, (SELECT MAX(salary) AS max FROM employee) max from employee;`
      - можем подставлять значение в выводимые столбцы
    - `SELECT * FROM (VALUES ('Google', '2011-01-01'), ('Facebook', '2012-01-01'))`
      - можем подставлять `VALUES` из `INSERT` запроса т.к. это тоже данные со столбцами и строками
- ### JOIN
    - `SELECT (emp.first_name || ' ' || emp.last_name) AS employee, comp.name AS company, (c.phone || ' ' || c.type) AS contact  FROM company_storage.employee emp JOIN company_storage.company comp ON emp.company_id = comp.id JOIN company_storage.employeeid_contactid ec ON emp.id = ec.employeeId JOIN company_storage.contact c ON c.id = ec.contactId WHERE c.type = 'private';`
        - `JOIN` указываем таблицу `ON`указываем по каким строкам соединяем таблицы - отсекаются NULL значения из обоих таблиц
    - `SELECT (emp.first_name || ' ' || emp.last_name) AS employee, comp.name AS company FROM company_storage.employee emp LEFT JOIN company_storage.company comp ON emp.company_id = comp.id;`
        - отсекаются NULL соотношения значений из правой таблицы
    - `SELECT (emp.first_name || ' ' || emp.last_name) AS employee, comp.name AS company FROM company_storage.employee emp RIGHT JOIN company_storage.company comp ON emp.company_id = comp.id;`
        - отсекаются NULL соотношения значения из левой таблицы
    - `SELECT (emp.first_name || ' ' || emp.last_name) AS employee, comp.name AS company FROM company_storage.employee emp FULL JOIN company_storage.company comp ON emp.company_id = comp.id;`
        - показываются все null значения из таблиц
- ### Functions
    - `SELECT sum(salary) AS sum, avg(salary) AS avg, max(salary) AS avg, min(salary) AS avg, count(salary) AS count, now() FROM employee;` 
      - `sum` - сумма значений в столбце
      - `avg` - среднее значение в столбце
      - `max` - максимальное значение в столбце
      - `min` - минимальное значение в столбце
      - `count` - колличество столбцов в выборке not null, count(*) колличество всех столбцов в выборке
      - `now` - текущее время на сервере
      -`SELECT lower(first_name) AS fname, upper(last_name) as lname, concat(first_name, ' ', last_name) FROM employee;`
      - `lower` - перевод в нижний регистр
      - `upper` - перевод в верхний регистр
      - `concat` - конкатенация строк в столбце
- ### GROUP BY
  - `SELECT count(salary), salary FROM company_storage.employee e GROUP BY e.salary;`
        - позволяет добавлять группировки для Functions
- ### Window Functions
    - `SELECT first_name, salary, MAX(salary) OVER(), COUNT(salary) OVER(PARTITION BY e.first_name) FROM company_storage.employee e GROUP BY e.salary, e.first_name;` 
        - `OVER()` - создает оконную функцию, 
        - `PARTITION BY` - разбиение внутри результатов оконной функции по параметру
- ### View 
  - `CREATE VIEW custom_sql_view AS select * FROM company_storage.company c ORDER BY c.name;` 
    - `SELECT * FROM custom_sql_view;` - использование кастомного созданого вью, не ускоряет запросы - просто используем как аналог alias
    - `CREATE MATERIALIZED VIEW` - создание закешированого VIEW, `REFRESH MATERIALIZED VIEW` - обновление кеша VIEW

- ### Tools
    - `EXPLAIN ANALYZE SELECT * FROM company_storage.company;`
        - `EXPLAIN` - описание выполнение запроса с помощью индексов, `ANALYZE` - одновить данные привязки инедксации
    - `SELECT generate_series * random() AS random, generate_series AS series FROM generate_series(1, 100);` 
        - `generate_series` - генерация значений (значение, количество), 
        - `random` - случайное число в диапазоне 0.0 <= x < 1.0
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