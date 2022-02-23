-- Lab | SQL Queries - Lesson 2.5
-- Solutions by Aaron Pereira

USE sakila;
SET sql_mode='STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- 1. Select all the actors with the first name ‘Scarlett’.
SELECT * FROM actor
WHERE first_name = 'Scarlett';

-- 2. How many films (movies) are available for rent and how many films have been rented?
-- Answer: There are 4581 movies to rent and 4580 of these movies have been rented before.
SELECT COUNT(inventory_id) FROM inventory;

SELECT COUNT(DISTINCT(inventory_id)) FROM rental;

-- 3. What are the shortest and longest movie duration? Name the values max_duration and min_duration.
SELECT MAX(length) AS max_duration, MIN(length) AS min_duration FROM film; 

-- 4. What's the average movie duration expressed in format (hours, minutes)?
SELECT film_id, title, length, CONCAT(FLOOR(length/60),'h ',MOD(length,60),'m') AS duration_h_m  FROM film;

-- 5. How many distinct (different) actors' last names are there?
-- Answer: 121
SELECT DISTINCT(last_name) FROM actor;
SELECT COUNT(DISTINCT(last_name)) FROM actor;

-- 6. Since how many days has the company been operating (check DATEDIFF() function)?
-- ANSWER: 5852 Days
SELECT store_id, last_update, DATEDIFF("2022-02-23", last_update) AS days_operating FROM store;

-- 7. Show rental info with additional columns month and weekday. Get 20 results.
-- Answer: THe following command will give you name of month, the day of the week, and the name of that day. 
SELECT * , date_format((rental_date), '%M') AS month, date_format((rental_date), '%D') AS date_day, DAYNAME(rental_date) AS weekday FROM rental
LIMIT 20;

-- 8. Add an additional column day_type with values 'weekend' and 'workday' depending on the rental day of the week.
SELECT * , date_format((rental_date), '%M') AS month, date_format((rental_date), '%D') AS date_day, DAYNAME(rental_date) AS weekday, 
CASE
WHEN DAYNAME(rental_date) IN('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday') then 'Workday'
WHEN DAYNAME(rental_date) IN('Saturday', 'Sunday') then 'Weekend'
ELSE 'No day' 
END AS day_type
FROM rental;

-- 9. Get release years.
SELECT * FROM film;
SELECT DISTINCT(release_year) AS release_years FROM film;

-- 10. Get all films with ARMAGEDDON in the title.
SELECT film_id, title FROM film
WHERE title LIKE 'ARMAGEDD%';

-- 11. Get all films which title ends with APOLLO.
SELECT film_id, title FROM film
WHERE title regexp'APOLLO$';

-- 12. Get 10 the longest films.
SELECT length, film_id, title FROM film
ORDER BY length DESC
LIMIT 10;

-- 13. How many films include Behind the Scenes content?
-- Answer: 538
SELECT COUNT(special_features) FROM film 
WHERE special_features LIKE '%ehind the Scene%';