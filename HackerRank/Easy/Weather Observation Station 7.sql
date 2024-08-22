SELECT DISTINCT city FROM station WHERE city LIKE '%a' OR city LIKE '%e' or city LIKE '%i' or city LIKE '%o' or city LIKE '%u';

/* Alternative Solution 1 */
SELECT DISTINCT city FROM station WHERE RIGHT(city,1) IN ('a', 'e', 'i', 'o', 'u');