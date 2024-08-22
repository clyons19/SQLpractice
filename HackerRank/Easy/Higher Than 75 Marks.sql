SELECT s.name FROM students AS s
WHERE s.marks > 75
ORDER BY RIGHT(s.name, 3) ASC, s.id;