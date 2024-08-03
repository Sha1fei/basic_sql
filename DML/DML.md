# Data Manipulation Language

- ### Insert
    - `INSERT INTO company(name, date) VALUES ('Google', '2011-01-01'), ('Facebook', '2012-01-01');` - вставка строчки в таблицу БД 
- ### Delete
- ### Update
- ### Select
    - `SELECT DISTINCT name AS company, date FROM company WHERE (name != 'Facebook') AND (name LIKE '%o%') AND id IN (1, 2, 8, 9, 10, 11) ORDER BY name, date DESC LIMIT 2 OFFSET 2;` - выбор данных из таблицы
      - `name AS company` - переименовать выводимый столбец
      - `DISTINCT` - только уникальные значения
      - `ORDER BY name DESC` - отсоритровать по столбцу
      - `LIMIT 2` - количество выводимых значений
      - `OFFSET 2` - Смещение выводимых значений по таблице
      - `WHERE name != 'Facebook'` - фильтрация данных c условием
      - `WHERE name LIKE '%o%'` - фильтрация данных, LIKE - полное совпадение, % - не имеет значение символ
      - `WHERE date BETWEEN '2011-01-01' AND '2011-03-01'` - фильтрация данных, по диапазону BETWEEN и AND значениями 
      - `WHERE id IN (1, 2, 8, 9, 10, 11)` - фильтрация данных,из списка значений
      - `AND ... OR` - конъюнкция и дизъюнкция условий
