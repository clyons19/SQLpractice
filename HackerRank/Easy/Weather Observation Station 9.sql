SELECT DISTINCT city FROM station
WHERE city NOT LIKE 'a%' AND city NOT LIKE 'e%' AND city NOT LIKE 'i%' AND city NOT LIKE 'o%' AND city NOT LIKE 'u%';

/* Alternative Solution 1 */
SELECT DISTINCT city FROM station 
WHERE LEFT(city,1) NOT IN ('a', 'e', 'i', 'o', 'u');