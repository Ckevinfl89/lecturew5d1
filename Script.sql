--select all colums from actor table
SELECT *-- * means all COLUMNS
from actor;

-- Syntax for a simple query
--SELECT column you'd like FROM table

SELECT * FROM actor;
-- query for specific colomns - Select col_1 col_2 etc From table_menu
SELECT first_name, last_name
FROM actor;

-- Filter rows - use WHERE clause -always comes after FROM 
SELECT *
FROM actor
WHERE first_name = 'Dan';

SELECT first_name, last_update
FROM actor 
WHERE first_name = 'Penelope';

-- use Wildcards with the LIke clause - % acts as a multi-character wildcard
-- can be any number of characters (0-infinity) - zero or many [\w\s]*
SELECT *
FROM actor a 
WHERE first_name LIKE 'M%';

SELECT *
FROM actor a 
WHERE last_name = '%r%'-- WILL LITERALLY LOOK FOR '%R%' -need the LIKE FOR wildcard

-- underscore (_)- represents 1 and only 1 CHARACTER 
SELECT *
FROM actor a WHERE first_name LIKE '_i_';

SELECT *
FROM actor a 
WHERE first_name LIKE '_i%';

-- using AND and OR in the WHERE clause
--OR - only one needs to be TRUE 
SELECT *
FROM actor a
WHERE first_name like 'N%' OR last_name LIKE 'W%';

--AND --all conditions need to be true
SELECT *
FROM actor a
WHERE first_name like 'N%' and last_name LIKE 'W%';

-- Comparing Operators in SQL:
-- Greater Than >   -- Less Than <
-- Greater Than or Equal >=  -- Less Than or Equal <=
-- Equal =   -- Not Equal <>

SELECT * 
FROM payment;


-- Query all of payments of more than $7.00
SELECT customer_id, amount
FROM payment p 
WHERE amount > 7.00;

SELECT customer_id, amount
FROM payment 
WHERE amount > '7';

SELECT *
FROM customer
WHERE store_id <> 2; -- NOT equal


SELECT * 
FROM actor 
WHERE first_name NOT LIKE 'P%';

SELECT * 
FROM actor a 
WHERE actor_id != 1; -- NOT equal

-- get all the things between $3.00 and $8.00 (inclusive)
SELECT * 
FROM payment p 
WHERE amount >= 3 AND amount <=8;

-- between/and clause
SELECT * 
FROM payment 
WHERE amount BETWEEN 3 AND 8;

--ordering the rows of data - order by
--ORDER BY col_name (default ASC, add DESC for descending)

SELECT * 
FROM film
ORDER BY rental_duration;

SELECT *
FROM category
ORDER BY name DESC;

--ORDER BY comes after WHERE (if present)

SELECT*
FROM payment 
WHERE customer_id = 453
ORDER BY amount


-- Exercise 1 - Write a query that will return all of the films that have an 'h' in the title and order it by rental_duration (ASC)

--title                      |rental_duration|
-----------------------------+---------------+
--Vanishing Rocky            |              3|
--Idaho Love                 |              3|
--Reunion Witches            |              3|
--Creatures Shakespeare      |              3|
--Sweet Brotherhood          |              3|
--Daughter Madigan           |              3|
--Day Unfaithful             |              3|
--Squad Fish                 |              3|
--Disciple Mother            |              3|

SELECT *
FROM film f 
WHERE title ILIKE '%h%' --ILIKE IS CASE-INSENSITIVE LIKE
ORDER BY rental_duration;


--SQL aggregations -> SUM(), AVG(), COUNT(), MIN(), MAX()
--take in a column_name as an argument and return a single value 

SELECT SUM(amount)
FROM payment;

SELECT SUM (amount)
FROM payment 
WHERE amount >5;

SELECT sum(amount)
FROM payment 
WHERE customer_id = 345;

--AVG -- average OF that COLUMN 

SELECT AVG(amount)
FROM payment;

-- get the minimum and maximum of payment -- also alias the column name - col_name AS alias_name
SELECT min(amount) AS lowest_amount_paid, max(amount) AS greatest_amount_paid
FROM payment;

--Can work on strings as well
SELECT min(title), max(title)
FROM film;

-- COUNT() -> takes in either the column name or * for all colums
--if colums name, will count how many NON-NULL rows, if * will count all ROWS 
SELECT count(amount)
FROM payment;

SELECT count(*)
FROM payment;

SELECT *
FROM staff;

--Get the total number of staff members
SELECT COUNT(*)
FROM staff;-- RETURN 2 because there ARE 2 ROWS

-- get the total number of staff number with a picture
SELECT count(picture)
FROM staff; -- RETURNS 1 because ONLY 1 ROW have a picture. the other IS NULL!


-- count how many unique first names there are in the actors
--use distinct in the count( -- count(discinct col_name)
SELECT count(DISTINCT first_name)
FROM actor;


-- Calculate a new column based on other COLUMNS 
SELECT payment_id, rental_id, payment_id - rental_id AS difference
FROM payment;

-- CONCAT -- will concatenate two strings together
SELECT CONCAT(first_name, ' ', last_name) AS full_name
FROM customer;

--GROUP BY clause
-- used with aggregation

SELECT count(*)
FROM payment
WHERE amount = 1.99;

SELECT count(*)
FROM payment 
WHERE amount = 2.99;

SELECT *
FROM payment p 
ORDER BY amount;

SELECT amount, count(*), sum(amount), avg(amount)
FROM payment p 
GROUP BY amount;

--columns selected from the table must also be used in the group by
SELECT amount, count(*)
FROM payment p GROUP BY amount; -- error

SELECT amount, customer_id, count(*)
FROM payment p
GROUP BY amount, customer_id 
ORDER BY customer_id;


-- Use aggregation in the ORDER BY clause
--QUERY the payment tabe to display the customer (by id) who has spend the most
SELECT customer_id, sum(amount)
FROM payment p 
GROUP BY customer_id
ORDER BY sum(amount) DESC;

-- alias our aggregated column and use in the order BY
sELECT customer_id, sum(amount) AS total_spend
FROM payment p 
GROUP BY customer_id
ORDER BY total_spend DESC;

--HAVING CLAUSE-> HAVING is to GROUP BY/aggregation as WHERE is to SELECT 
sELECT customer_id, sum(amount)AS total_spend
FROM payment p 
GROUP BY customer_id
HAVING sum(amount)<150
ORDER BY total_spend DESC;

-- customers who have made between 20 and 30 individual payments
SELECT customer_id, count(*)
FROM payment p 
GROUP BY customer_id 
HAVING count(*) BETWEEN 20 AND 30;

-- limit and OFFSET clause
--LIMIT - limit the number of rows that are returned
SELECT *
FROM film
LIMIT 10;

SELECT *
FROM staff s LIMIT 10;

--OFFSET - start your rows after a certain number of rows using OFFSET
SELECT *
FROM film f 
OFFSET 10;--SKIP OVER the 1st 10 ROWS

--can be used together
SELECT *
FROM film
OFFSET 5
LIMIT 10;

-- Putting all of the clauses together
-- Of all the customers who have made less than 20 payments and have a customer > 350, display those who have sppent 11-20th most
SELECT customer_id, count(*), sum (amount) AS total_spend
FROM payment
WHERE customer_id >350
GROUP BY customer_id
HAVING count(*) <20
ORDER BY total_spend DESC
OFFSET 10
LIMIT 10;

--SYNTAX ORDER: (SELECT and FROM are the only mandatory)

--SELECT (columns from table)
--FROM (TABLE name)

--where (row filter)
--GROUP BY (aggregations)
--HAVING (filter aggregation)
--ORDER BY (column value ASC or DESC)
--OFFSET (number of rows to skip)
--LIMIT (max number of rows to display)
