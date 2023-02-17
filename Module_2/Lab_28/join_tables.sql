-- Which actor has appeared in the most films?
SELECT
a.actor_id,
a.first_name,
a.last_name,
COUNT(distinct b.film_id) as count
FROM actor a JOIN film_actor b ON a.actor_id = b.actor_id
GROUP BY
a.actor_id,
a.first_name,
a.last_name
ORDER BY count DESC
LIMIT 1;

-- Most active customer (the customer that has rented the most number of films)
SELECT
a.first_name,
a.last_name,
COUNT(distinct b.rental_id) as count
FROM customer a JOIN rental b ON a.customer_id = b.customer_id 
GROUP BY
a.first_name,
a.last_name
ORDER BY count DESC
LIMIT 1;

-- List number of films per category.
SELECT
a.name,
COUNT(distinct b.film_id) as count
FROM category a JOIN film_category b ON a.category_id = b.category_id
GROUP BY
a.name

-- Display the first and last names, as well as the address, of each staff member.
SELECT
a.first_name,
a.last_name,
b.address
FROM staff a JOIN address b ON a.address_id = b.address_id;

-- get films titles where the film language is either English or italian, and whose titles starts with letter "M" , sorted by title descending.

SELECT
a.title,
b.name
FROM film a JOIN language b ON a.language_id = b.language_id
WHERE b.name IN ('English','Italian') AND a.title LIKE 'M%';

-- Display the total amount rung up by each staff member in August of 2005.
SELECT
a.first_name,
a.last_name,
SUM(b.amount)
FROM staff a JOIN payment b ON a.staff_id = b.staff_id
WHERE YEAR(payment_date) = 2005 AND MONTH(payment_date) =8
GROUP BY
a.first_name,
a.last_name
;

-- List each film and the number of actors who are listed for that film.
SELECT
a.title,
COUNT(distinct b.actor_id) as count
FROM film a JOIN film_actor b ON a.film_id = b.film_id
GROUP BY 
a.title
ORDER BY count DESC
LIMIT 10;

-- Using the tables payment and customer and the JOIN command, list the total paid by each customer. 
-- List the customers alphabetically by last name.

SELECT
b.last_name,
b.first_name,
SUM(a.amount) as sum
FROM payment a JOIN customer b ON a.customer_id = b.customer_id
GROUP BY
b.last_name,
b.first_name
ORDER BY b.last_name ASC
LIMIT 10;

-- Write sql statement to check if you can find any actor who never particiapted in any film.
SELECT *
FROM
(
SELECT
a.first_name,
a.last_name,
COUNT(distinct film_id) as count
FROM actor a JOIN film_actor b ON a.actor_id = b.actor_id
GROUP BY 
a.first_name,
a.last_name
) subquery
WHERE count = 0


