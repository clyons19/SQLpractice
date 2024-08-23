SELECT CASE
    WHEN COUNT(id)%2=1 THEN 
    (
        SELECT ROUND(lat_n, 4) FROM 
        (
            SELECT lat_n, ROW_NUMBER() OVER (ORDER BY lat_n ASC) AS rn FROM station
        ) AS sq1
        WHERE rn = 
            (
                SELECT ROUND((COUNT(*)+1)/2) FROM station
            )
    )
    ELSE ROUND((
    (
        SELECT lat_n FROM 
        (
            SELECT lat_n, ROW_NUMBER() OVER (ORDER BY lat_n ASC) AS rn2 FROM station
        ) as sq2
        WHERE rn2 = 
            (
                SELECT ROUND(COUNT(*)/2) FROM station
            ) 
    )
    +
    (
        SELECT lat_n FROM 
        (
            SELECT lat_n, ROW_NUMBER() OVER (ORDER BY lat_n ASC) AS rn3 FROM station
        ) AS sq3
        WHERE rn3 = 
            (
                SELECT ROUND(COUNT(*)/2)+1 FROM station
            )       
    ))/2, 4)
END
FROM station;

/* Alternative Solution 1 */
SELECT ROUND(AVG(lat_n), 4) AS median FROM
(
    SELECT lat_n FROM
        (
            SELECT lat_n, ROW_NUMBER() OVER (ORDER BY lat_n ASC) AS rn FROM station
        ) AS sq
    WHERE rn = 
        (
            SELECT FLOOR((COUNT(*)+1)/2) FROM station
        )
    OR rn = 
        (
            SELECT CEIL((COUNT(*)+1)/2) FROM station
        )
) AS sq1;