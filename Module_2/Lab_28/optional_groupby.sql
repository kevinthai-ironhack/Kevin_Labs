USE sakila;

SELECT
	last_name
FROM actor
GROUP BY last_name;

-- Using the rental table, find out how many rentals were processed by each employee.
SELECT
staff_id,
COUNT(distinct rental_id)
FROM rental
GROUP BY staff_id;

-- Using the film table, find out how many films there are of each rating.
SELECT
	rating,
    COUNT(distinct film_id) as count
FROM film
GROUP BY rating
ORDER BY count DESC
;

-- What is the mean length of the film for each rating type. Round off the average lengths to two decimal places
SELECT
	rating,
    ROUND(AVG(length),2) AS mean_length
FROM film
GROUP BY rating
;

-- Which kind of movies (rating) have a mean duration of more than two hours?
SELECT rating
FROM 
(
SELECT
	rating,
    ROUND(AVG(length),2) AS mean_length
FROM film
GROUP BY rating
) sub
WHERE mean_length > 120
;