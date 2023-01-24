select * from ironhack_examples.applestore limit 10;

SELECT DISTINCT prime_genre
FROM ironhack_examples.applestore
ORDER BY prime_genre ASC;

SELECT prime_genre, SUM(rating_count_tot)
FROM ironhack_examples.applestore
GROUP BY prime_genre
ORDER BY SUM(rating_count_tot) DESC
LIMIT 1;

SELECT prime_genre, COUNT(DISTINCT track_name)
FROM ironhack_examples.applestore
GROUP BY prime_genre
ORDER BY COUNT(DISTINCT track_name) DESC
LIMIT 1;

SELECT prime_genre, COUNT(DISTINCT track_name)
FROM ironhack_examples.applestore
GROUP BY prime_genre
ORDER BY COUNT(DISTINCT track_name) ASC
LIMIT 1;

SELECT track_name, rating_count_tot
FROM ironhack_examples.applestore
ORDER BY rating_count_tot DESC
LIMIT 10;

SELECT track_name, user_rating
FROM ironhack_examples.applestore
ORDER BY user_rating DESC
LIMIT 10;

SELECT track_name, user_rating, rating_count_tot
FROM ironhack_examples.applestore
ORDER BY user_rating DESC, rating_count_tot DESC
LIMIT 3;


