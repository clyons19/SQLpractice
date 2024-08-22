SELECT salary*months as earnings, COUNT(name) as num_employees FROM employee
WHERE salary*months=
    (
        SELECT MAX(salary*months) FROM employee
    )
GROUP BY earnings;

/* Alternative Solution 1 */
SELECT months*salary as earnings, COUNT(*) FROM employee
GROUP BY earnings
ORDER BY earnings DESC
LIMIT 1;