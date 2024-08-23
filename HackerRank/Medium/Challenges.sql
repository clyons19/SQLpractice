SELECT h.hacker_id AS id, h.name AS n, COUNT(DISTINCT c.challenge_id) AS cnt FROM hackers AS h
JOIN challenges AS c ON h.hacker_id=c.hacker_id
GROUP BY h.hacker_id, h.name
HAVING
    COUNT(DISTINCT c.challenge_id) =
    (
        SELECT MAX(c_id_cnt) FROM
        (
            SELECT COUNT(DISTINCT c2.challenge_id) AS c_id_cnt FROM hackers AS h2
            JOIN challenges AS c2 ON h2.hacker_id=c2.hacker_id     
            GROUP BY h2.hacker_id, h2.name
        ) AS sq
    )
OR
    COUNT(DISTINCT c.challenge_id) NOT IN 
    (
        SELECT COUNT(DISTINCT c3.challenge_id) FROM hackers AS h3
        JOIN challenges AS c3 ON h3.hacker_id=c3.hacker_id
        WHERE h.hacker_id != h3.hacker_id
        GROUP BY h3.hacker_id, h3.name    
    )
ORDER BY cnt DESC, id ASC;


/* Alternative Solution 1 */
SELECT h.hacker_id, h.name, COUNT(DISTINCT c.challenge_id) AS num_c FROM hackers AS h
JOIN challenges AS c ON h.hacker_id = c.hacker_id
GROUP BY h.hacker_id, h.name
HAVING num_c = 
(
    SELECT MAX(num_chals) FROM
    (
        SELECT COUNT(DISTINCT c2.challenge_id) AS num_chals FROM hackers AS h2
        JOIN challenges AS c2 ON h2.hacker_id = c2.hacker_id
        GROUP BY h2.hacker_id, h2.name
    ) AS chal_cnts
)
OR num_c IN
(
    SELECT c_cnts.num_c FROM
    (
        SELECT h3.hacker_id, h3.name, COUNT(DISTINCT c3.challenge_id) AS num_c FROM hackers AS h3
        JOIN challenges AS c3 ON h3.hacker_id = c3.hacker_id
        GROUP BY h3.hacker_id, h3.name
    ) AS c_cnts
    GROUP BY c_cnts.num_c
    HAVING COUNT(c_cnts.num_c) = 1
)
ORDER BY num_c DESC, h.hacker_id ASC;