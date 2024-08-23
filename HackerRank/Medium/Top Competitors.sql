SELECT id, name FROM
(
    SELECT s.hacker_id AS id, h.name AS name, s.challenge_id AS c_id, s.score AS score, d.score AS max_score FROM submissions AS s
    JOIN challenges AS c ON s.challenge_id=c.challenge_id
    JOIN difficulty AS d ON c.difficulty_level=d.difficulty_level
    JOIN hackers AS h ON s.hacker_id=h.hacker_id
    WHERE s.score=d.score
) AS sq
GROUP BY id, name
HAVING COUNT(name)>1
ORDER BY COUNT(name) DESC, id ASC;

/* Alternative Solution 1 */
SELECT h.hacker_id, h.name FROM hackers AS h
JOIN submissions AS s ON h.hacker_id = s.hacker_id
JOIN challenges AS c ON s.challenge_id = c.challenge_id
JOIN difficulty AS d ON c.difficulty_level = d.difficulty_level and s.score=d.score
GROUP BY h.hacker_id, h.name
HAVING COUNT(s.score=d.score)>1
ORDER BY COUNT(s.score=d.score) DESC, h.hacker_id ASC;