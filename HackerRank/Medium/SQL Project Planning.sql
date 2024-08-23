SELECT sd.start_date, ed.end_date FROM
(
    SELECT start_date, ROW_NUMBER() OVER () AS rn FROM projects
    WHERE start_date NOT IN
    (
        SELECT end_date FROM projects
    )
) AS sd
JOIN
(
    SELECT end_date, ROW_NUMBER() OVER () AS rn FROM projects
    WHERE end_date NOT IN
    (
        SELECT start_date FROM projects
    )
) AS ed
ON sd.rn = ed.rn
ORDER BY ed.end_date - sd.start_date, sd.start_date;