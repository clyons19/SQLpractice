SELECT w.id, p.age, w.coins_needed, w.power FROM wands AS w
JOIN wands_property as p ON w.code = p.code
WHERE p.is_evil = 0 AND w.coins_needed = 
(
    SELECT MIN(wands.coins_needed) FROM wands
    JOIN wands_property ON wands.code = wands_property.code
    WHERE w.power=wands.power AND p.age=wands_property.age
)
ORDER BY w.power DESC, p.age DESC;


/* Alternative Solution 1 */
SELECT w.id, wp.age, w.coins_needed, w.power FROM wands AS w
JOIN wands_property AS wp ON w.code=wp.code AND w.coins_needed =
(
    SELECT MIN(coins_needed) FROM wands AS w2
    JOIN wands_property AS wp2 ON w2.code=wp2.code
    WHERE wp2.age=wp.age AND w2.power=w.power
)
WHERE wp.is_evil=0
ORDER BY w.power DESC, wp.age DESC;