use ppub;

-- Challenge 1 - Who Have Published What At Where?

SELECT
a.au_id AS Author_ID,
a.au_lname AS Last_Name,
a.au_fname AS First_Name,
c.title AS Title,
d.pub_name AS Publisher

FROM authors a 
JOIN titleauthor b ON a.au_id = b.au_id
JOIN titles c ON b.title_id = c.title_id
JOIN publishers d ON c.pub_id = d.pub_id
;

SELECT COUNT(*)
FROM authors a 
JOIN titleauthor b ON a.au_id = b.au_id
JOIN titles c ON b.title_id = c.title_id
JOIN publishers d ON c.pub_id = d.pub_id
;

SELECT COUNT(*)
FROM titleauthor
;

-- verification OK 25 rows

-- Challenge 2 - Who Have Published How Many At Where?

SELECT
a.au_id AS Author_ID,
a.au_lname AS Last_Name,
a.au_fname AS First_Name,
d.pub_name AS Publisher,
COUNT(DISTINCT c.title) AS Title_Count

FROM authors a 
JOIN titleauthor b ON a.au_id = b.au_id
JOIN titles c ON b.title_id = c.title_id
JOIN publishers d ON c.pub_id = d.pub_id

GROUP BY
a.au_id,
a.au_lname,
a.au_fname,
d.pub_name
;

-- Challenge 3 - Best Selling Authors

SELECT
a.au_id AS Author_ID,
a.au_lname AS Last_Name,
a. au_fname AS First_Name,
SUM(s.qty) AS Total

FROM authors a 
LEFT JOIN titleauthor b ON a.au_id = b.au_id
LEFT JOIN titles c ON b.title_id = c.title_id
LEFT JOIN sales s ON c.title_id = s.title_id

GROUP BY 
a.au_id,
a.au_lname,
a. au_fname

ORDER BY SUM(s.qty) DESC
LIMIT 3
;

-- Challenge 4 - Best Selling Authors Ranking

SELECT
a.au_id AS Author_ID,
a.au_lname AS Last_Name,
a. au_fname AS First_Name,
SUM(CASE WHEN s.qty IS NULL THEN 0 ELSE s.qty END) AS Total

FROM authors a 
LEFT JOIN titleauthor b ON a.au_id = b.au_id
LEFT JOIN titles c ON b.title_id = c.title_id
LEFT JOIN sales s ON c.title_id = s.title_id

GROUP BY 
a.au_id,
a.au_lname,
a. au_fname

ORDER BY SUM(s.qty) DESC
;
