-- Write a query that identifies the first witness.
SELECT *
FROM person
WHERE address_street_name = 'Northwestern Dr'
ORDER BY address_number DESC LIMIT 1;

-- Write a query that identifies the second witness.
SELECT * FROM person 
WHERE name like '%Annabel%'
AND address_street_name = 'Franklin Ave';

-- Write a query that shows the interview transcripts for our two subjects.
