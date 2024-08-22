SELECT DISTINCT city FROM station WHERE
city NOT LIKE  'a%a' AND city NOT LIKE  'a%e' AND city NOT LIKE  'a%i' AND city NOT LIKE  'a%o' AND city NOT LIKE  'a%u' AND
city NOT LIKE  'e%a' AND city NOT LIKE  'e%e' AND city NOT LIKE  'e%i' AND city NOT LIKE  'e%o' AND city NOT LIKE  'e%u'  AND
city NOT LIKE  'i%a' AND city NOT LIKE  'i%e' AND city NOT LIKE  'i%i' AND city NOT LIKE  'i%o' AND city NOT LIKE  'i%u' AND
city NOT LIKE  'o%a' AND city NOT LIKE  'o%e' AND city NOT LIKE  'o%i' AND city NOT LIKE  'o%o' AND city NOT LIKE  'o%u' AND 
city NOT LIKE  'u%a' AND city NOT LIKE  'u%e' AND city NOT LIKE  'u%i' AND city NOT LIKE  'u%o' AND city NOT LIKE  'i%u'; 


/* Alternative Solution 1 */
SELECT DISTINCT city FROM station
WHERE 
    (city NOT LIKE 'a%' AND city NOT LIKE 'e%' AND city NOT LIKE 'i%' AND city NOT LIKE 'o%' AND city NOT LIKE 'u%')
OR
    (city NOT LIKE '%a' AND city NOT LIKE '%e' AND city NOT LIKE '%i' AND city NOT LIKE '%o' AND city NOT LIKE '%u');

/* Alternative Solution 2 */
SELECT DISTINCT city FROM station 
WHERE 
    LEFT(city,1) NOT IN ('a', 'e', 'i', 'o', 'u')
OR
    RIGHT(city,1) NOT IN ('a', 'e', 'i', 'o', 'u');