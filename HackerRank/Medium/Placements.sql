SELECT subq.name FROM
(
	SELECT s.id AS id, s.name AS name, p.salary AS salary, f.friend_id AS id_f, s_f.name AS name_f, p_f.salary AS salary_f FROM students AS s
	JOIN packages AS p ON s.id=p.id
	JOIN friends AS f ON s.id=f.id
	JOIN students AS s_f ON f.friend_id=s_f.id
	JOIN packages AS p_f ON f.friend_id=p_f.id
) AS subq
WHERE subq.salary < subq.salary_f
ORDER BY subq.salary_f;