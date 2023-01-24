select * from olist.order_items;

-- 1. From the order_items table, find the price of the highest priced order and lowest price order.
SELECT
MAX(price),
MIN(price)
FROM olist.order_items
;

-- 2. From the order_items table, what is range of the shipping_limit_date of the orders?
SELECT
MIN(shipping_limit_date),
MAX(shipping_limit_date)
FROM olist.order_items
;

SELECT * FROM olist.customers;

-- 3. From the customers table, find the states with the greatest number of customers.
SELECT 
customer_state,
COUNT(DISTINCT customer_id),
COUNT(DISTINCT customer_unique_id)
FROM olist.customers
GROUP BY customer_state
ORDER BY COUNT(DISTINCT customer_id) DESC
LIMIT 1
;

-- 4. From the customers table, within the state with the greatest number of customers, find the cities with the greatest number of customers.
SELECT 
customer_city,
COUNT(DISTINCT customer_id),
COUNT(DISTINCT customer_unique_id)
FROM olist.customers
WHERE customer_state = 'SP'
GROUP BY customer_city
ORDER BY COUNT(DISTINCT customer_id) DESC
;

SELECT * from olist.closed_deals;
-- 5. From the closed_deals table, how many distinct business segments are there (not including null)?
SELECT COUNT(DISTINCT business_segment)
FROM olist.closed_deals
WHERE business_segment IS NOT NULL;

-- 6. From the closed_deals table, sum the declared_monthly_revenue for duplicate row values in business_segment 
-- and find the 3 business segments with the highest declared monthly revenue (of those that declared revenue).
SELECT
business_segment,
SUM(declared_monthly_revenue)
FROM olist.closed_deals
WHERE business_segment IS NULL
GROUP BY
business_segment
;

SELECT
business_segment,
SUM(declared_monthly_revenue)
FROM olist.closed_deals
GROUP BY
business_segment
ORDER BY SUM(declared_monthly_revenue) DESC
LIMIT 3
;

SELECT * FROM olist.order_reviews;
-- 7. From the order_reviews table, find the total number of distinct review score values.
SELECT DISTINCT review_score
FROM olist.order_reviews;

-- 8. In the order_reviews table, create a new column with a description that corresponds 
-- to each number category for each review score from 1 - 5, then find the review score and category occurring most frequently in the table.
SELECT * from olist.order_reviews;

SELECT
review_score,
CASE 
	WHEN review_score = 1 THEN 'poor'
    WHEN review_score = 2 THEN 'poor+'
    WHEN review_score = 3 THEN 'average'
    WHEN review_score = 4 THEN 'good'
    ELSE 'very good'
END as description,
COUNT(review_id)
FROM olist.order_reviews
GROUP BY 
review_score,
description
ORDER BY COUNT(review_id) DESC
;

-- 9. From the order_reviews table, find the review value occurring most frequently and how many times it occurs.
SELECT
review_score,
COUNT(DISTINCT review_id)
FROM olist.order_reviews
GROUP BY review_score
ORDER BY COUNT(DISTINCT review_id) DESC;
