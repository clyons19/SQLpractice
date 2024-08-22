SELECT e.name FROM employee AS e
WHERE 
	e.salary > 2E3
AND
	e.months < 10
ORDER BY e.employee_id ASC;