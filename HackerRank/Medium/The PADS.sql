SELECT CONCAT(name, '(', UPPER(LEFT(occupation, 1)), ')') FROM occupations
ORDER BY name;
SELECT CONCAT('There are a total of ', COUNT(name), ' ', LOWER(occupation), 's.') FROM occupations
GROUP BY occupation
ORDER BY COUNT(name) ASC, occupation ASC;