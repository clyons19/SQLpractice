SELECT id, n, SUM(max_chal_score) AS scores FROM
(
    SELECT h.hacker_id AS id, h.name AS n, s.challenge_id, MAX(s.score) AS max_chal_score FROM hackers AS h
    JOIN submissions AS s ON s.hacker_id=h.hacker_id
    GROUP BY h.hacker_id, h.name, s.challenge_id
    HAVING MAX(s.score) > 0
) AS sq
GROUP BY id, n
ORDER BY scores DESC, id ASC;