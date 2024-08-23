SET @start_date = '2016-03-01', @end_date = '2016-03-15';
SELECT sub_each_day.submission_date, sub_each_day.continual_sub_cnt, max_daily_subs.ids, max_daily_subs.name FROM
(
    SELECT submission_date, COUNT(DISTINCT hacker_id) AS continual_sub_cnt FROM
    (
        SELECT submission_date, hacker_id,
        (
            SELECT COUNT(hacker_id) FROM 
            (
                SELECT DISTINCT submission_date, hacker_id FROM submissions
            ) AS sub2
            WHERE 
                sub2.hacker_id=sub.hacker_id
            AND
                sub2.submission_date<=sub.submission_date
        ) AS total_subs
        FROM 
        (
            SELECT DISTINCT submission_date, hacker_id FROM submissions
        ) AS sub
        WHERE 
            submission_date BETWEEN @start_date AND @end_date
        ORDER BY submission_date ASC
    ) AS subq1
    WHERE subq1.total_subs = DATEDIFF(subq1.submission_date, @start_date)+1
    GROUP BY subq1.submission_date    
) AS sub_each_day
JOIN
(
    SELECT ct2.submission_date, ct2.ids, h.name FROM
    (
        SELECT ct.submission_date, MIN(ct.hacker_id) as ids, ct.num_subs FROM
        (
            SELECT t1.submission_date, t1.hacker_id, t1.num_subs FROM
            (
                SELECT submission_date, hacker_id, COUNT(hacker_id) AS num_subs
                FROM submissions AS sub
                WHERE submission_date BETWEEN @start_date AND @end_date
                GROUP BY submission_date, hacker_id
            ) AS t1
            JOIN 
            (
                SELECT submission_date, MAX(num_subs) AS max_subs FROM
                (
                    SELECT submission_date, hacker_id, COUNT(hacker_id) AS num_subs
                    FROM submissions AS sub
                    WHERE submission_date BETWEEN @start_date AND @end_date
                    GROUP BY submission_date, hacker_id
                ) AS sq1
                GROUP BY submission_date
            ) AS t2
            ON t1.submission_date = t2.submission_date AND t1.num_subs = t2.max_subs
        ) AS ct
        GROUP BY ct.submission_date, ct.num_subs
    ) AS ct2
    JOIN hackers AS h ON ct2.ids = h.hacker_id
) AS max_daily_subs
ON sub_each_day.submission_date = max_daily_subs.submission_date
ORDER BY sub_each_day.submission_date;