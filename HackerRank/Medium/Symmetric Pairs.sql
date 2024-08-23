SELECT DISTINCT sq.x, sq.y FROM
(
    SELECT f.x, f.y, COUNT(f.x) AS cnt FROM functions AS f
    GROUP BY f.x, f.y
) AS sq
JOIN functions AS f2 ON sq.x=f2.y AND sq.y=f2.x
WHERE 
    sq.x < sq.y
OR
    (sq.x=sq.y AND sq.cnt > 1)
ORDER BY sq.x ASC;

/* Alternative Solution 1 */
SELECT DISTINCT f1.x, f1.y FROM functions as f1
JOIN functions AS f2 ON f1.x=f2.y AND f1.y=f2.x
WHERE f1.x<f1.y OR f1.x=f1.y AND
(
    SELECT COUNT(*) FROM functions as f2
    WHERE f1.x=f2.x AND f1.y=f2.y
)>1
ORDER BY f1.x;