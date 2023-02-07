use ppub;

-- Challenge 1 Most Profiting Authors
SELECT * 
FROM titles 
JOIN titleauthor ON titles.title_id = titleauthor.title_id
JOIN sales ON titleauthor.title_id = sales.title_id
;

-- Step 1 Calculate Royalty and Advance per author and title 
WITH step1 AS (
SELECT
b.title_id,
b.au_id,
a.advance * b.royaltyper / 100 AS advance,
a.price * c.qty * a.royalty / 100 * b.royaltyper / 100 AS royalty
FROM titles a
JOIN titleauthor b ON a.title_id = b.title_id
JOIN sales c ON b.title_id = c.title_id
),
step2 AS (
SELECT
title_id,
au_id,
SUM(royalty) AS agg_royalties
FROM step1
GROUP BY
title_id,
au_id
)
SELECT DISTINCT
step1.au_id,
step1.advance + step2.agg_royalties AS profits
FROM step1 JOIN 
step2 ON step1.title_id = step2.title_id 
AND step1.au_id = step2.au_id
ORDER BY profits DESC
LIMIT 3
;

-- Challenge 2 Alternative Solution
CREATE TEMPORARY TABLE IF NOT EXISTS STEP1
SELECT
b.title_id,
b.au_id,
a.advance * b.royaltyper / 100 AS advance,
a.price * c.qty * a.royalty / 100 * b.royaltyper / 100 AS royalty
FROM titles a
JOIN titleauthor b ON a.title_id = b.title_id
JOIN sales c ON b.title_id = c.title_id
;
CREATE TEMPORARY TABLE IF NOT EXISTS STEP2
SELECT
title_id,
au_id,
SUM(royalty) AS agg_royalties
FROM step1
GROUP BY
title_id,
au_id
;
SELECT DISTINCT
a.au_id,
a.advance + b.agg_royalties AS profits
FROM STEP1 a JOIN STEP2 b
ON a.au_id = b.au_id 
AND a.title_id = b.title_id
ORDER BY profits DESC
LIMIT 3
;

-- Challenge3  
DROP TABLE IF EXISTS most_profiting_authors;
CREATE TEMPORARY TABLE IF NOT EXISTS STEP1
SELECT
b.title_id,
b.au_id,
a.advance * b.royaltyper / 100 AS advance,
a.price * c.qty * a.royalty / 100 * b.royaltyper / 100 AS royalty
FROM titles a
JOIN titleauthor b ON a.title_id = b.title_id
JOIN sales c ON b.title_id = c.title_id
;
CREATE TEMPORARY TABLE IF NOT EXISTS STEP2
SELECT
title_id,
au_id,
SUM(royalty) AS agg_royalties
FROM step1
GROUP BY
title_id,
au_id
;
CREATE TABLE most_profiting_authors
SELECT DISTINCT
a.au_id,
a.advance + b.agg_royalties AS profits
FROM STEP1 a JOIN STEP2 b
ON a.au_id = b.au_id 
AND a.title_id = b.title_id
ORDER BY profits DESC
;

SELECT * FROM most_profiting_authors;