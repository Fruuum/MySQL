-- lesson 5
-- для запросов используем БД shop
USE shop;

-- 1. (по желанию) Из таблицы shop.users необходимо извлечь пользователей, родившихся в августе и мае. 
SELECT * FROM users
where birthday_at LIKE '_____05%' or birthday_at LIKE '_____08%';

-- 2. (по желанию) Из таблицы shop.catalogs извлекаются записи при помощи запроса. 
-- SELECT * FROM catalogs WHERE id IN (5, 1, 2); Отсортируйте записи в порядке, заданном в списке IN. 
SELECT * FROM catalogs WHERE id IN (5, 1, 2) ORDER BY field(id, 5, 1, 2); 


-- Практическое задание теме «Агрегация данных»


-- 1. Подсчитайте средний возраст пользователей в таблице users.shop
SELECT round(avg(TIMESTAMPDIFF(YEAR, birthday_at, NOW()))) FROM users;
-- или так
SELECT round(avg(floor((to_days(now()) - to_days(birthday_at)) / 365.25))) FROM users;

-- 2. Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели. 
--    Следует учесть, что необходимы дни недели текущего года, а не года рождения.
SELECT DATE_FORMAT(DATE(CONCAT_WS('-', YEAR(NOW()), MONTH(birthday_at), DAY(birthday_at))), '%W') 
	   as day, COUNT(*) total FROM users GROUP BY day;


-- 3. (по желанию) Подсчитайте произведение чисел в столбце таблицы.
 
CREATE DATABASE examples;
USE examples;

DROP TABLE IF EXISTS product;
CREATE TABLE product (
  value INT NOT NULL
 );
  
INSERT INTO product (value)
VALUES 
	(1),
	(2), 
	(3), 
	(4), 
	(5);


-- в MySQL нет произведения по столбцу, но его можно выразить через встроенные матформулы log и exp
-- реализовав формулу exp(ln(a) + ln(b) + ln(c) = a*b*c, где a,b,c - табличные значения
SELECT exp(SUM(log(value))) FROM product;