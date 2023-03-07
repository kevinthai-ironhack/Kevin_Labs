use employees_mod;

-- Create a procedure that will provide the average salary of all employees.

DELIMITER $$
CREATE PROCEDURE avg_salary()
BEGIN
SELECT 
AVG(salary) AS avg_salary
FROM t_salaries ;
END
$$ DELIMITER ;

-- Create a procedure called ‘emp_info’ that uses as parameters the first and the last name of an individual, 
-- and returns their employee number.

DELIMITER $$
CREATE PROCEDURE emp_info (
	IN firstname VARCHAR(50),
	IN lastname VARCHAR(50)
)
BEGIN
	SELECT emp_no
	FROM t_employees
	WHERE first_name = firstname
    AND last_name = lastname;
END$$
DELIMITER ;

-- Call the procedures 

CALL avg_salary();
CALL emp_info('Saniya','Kalloufi');

-- to check
-- SELECT * FROM  t_employees;

-- Create a trigger that checks if the hire date of an employee is higher than the current date. 
-- If true, set this date to be the current date. Format the output appropriately (YY-MM-DD)


