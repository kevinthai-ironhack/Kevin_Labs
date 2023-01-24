SELECT * FROM salespersons;

-- Now you find an error you need to fix in your existing data - in the Salespersons table, 
-- you mistakenly spelled Miami as Mimia for Paige Turner.

UPDATE salespersons
SET Store = 'Miami'
WHERE ID  = 4;

-- Also, you received the email addresses of the three customers:
select * from customers;

UPDATE customers
SET Email = 'ppicasso@gmail.com'
WHERE ID  = 0;

UPDATE customers
SET Email = 'lincoln@us.gov'
WHERE ID  = 1;

UPDATE customers
SET Email = 'hello@napoleon.me'
WHERE ID  = 2;

-- In addition, you also find a duplicated car entry for VIN DAM41UDN3CHU2WVF6. You want to delete car ID #4 from the database. 
SELECT * from cars;

DELETE FROM cars WHERE ID=4;