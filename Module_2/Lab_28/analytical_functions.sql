USE sakila;

-- 1. find the running total of rental payments for each customer in the payment table, ordered by payment date. 
-- By selecting the customer_id, payment_date, and amount columns from the payment table, 
-- and then applying the SUM function to the amount column within each customer_id partition, ordering by payment_date.

SELECT 
    customer_id, 
    payment_date, 
    amount, 
    SUM(amount) OVER (PARTITION BY customer_id ORDER BY payment_date) AS running_total 
FROM payment;

-- find the rank and dense rank of each payment amount within each payment date 
-- by selecting the payment_date and amount columns from the payment table, 
-- and then applying the RANK and DENSE_RANK functions to the amount column within each payment_date partition,
-- ordering by amount in descending order.

SELECT 
	CAST(payment_date AS date),
    amount, 
    RANK() OVER (PARTITION BY CAST(payment_date AS date) ORDER BY amount DESC) AS rnk,
    DENSE_RANK() OVER (PARTITION BY CAST(payment_date AS date) ORDER BY amount DESC) AS dense_rnk
FROM payment;

-- 3. find the ranking of each film based on its rental rate, within its respective category. 
-- Hint: you need to extract the information from the film,film_category and category tables after applying join on them.

SELECT
	c.name,
	a.title,
	a.rental_rate,
    RANK() OVER (PARTITION BY c.name ORDER BY a.rental_rate DESC) AS rnk,
    DENSE_RANK() OVER (PARTITION BY c.name ORDER BY a.rental_rate DESC) AS dense_rnk
FROM film a
JOIN film_category b ON a.film_id = b.film_id
JOIN category c ON b.category_id = c.category_id

-- 4.(OPTIONAL) update the previous query from above to retrieve only the top 5 films within each category

SELECT *
FROM
(
	SELECT
	c.name,
	a.title,
	a.rental_rate,
    RANK() OVER (PARTITION BY c.name ORDER BY a.rental_rate DESC) AS rnk,
    DENSE_RANK() OVER (PARTITION BY c.name ORDER BY a.rental_rate DESC) AS dense_rnk
	FROM film a
	JOIN film_category b ON a.film_id = b.film_id
	JOIN category c ON b.category_id = c.category_id
) subquery
WHERE dense_rnk <=5;

-- 5. find the difference between the current and previous payment amount 
-- and the difference between the current and next payment amount, for each customer in the payment table
-- Hint: select the payment_id, customer_id, amount, and payment_date columns from the payment table, 
-- and then applying the LAG and LEAD functions to the amount column, partitioning by customer_id and ordering by payment_date.

SELECT 
    payment_id, 
    customer_id, 
    amount, 
    payment_date,
    (amount - LAG(amount) OVER (PARTITION BY customer_id ORDER BY payment_date)) AS diff_from_prev ,
    (amount - LEAD(amount)  OVER (PARTITION BY customer_id ORDER BY payment_date)) AS diff_from_next
FROM payment;