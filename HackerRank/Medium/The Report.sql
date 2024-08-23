SELECT
CASE
    WHEN 
        CASE
            WHEN marks = 100 THEN FLOOR((marks-1)/10)+1
            ELSE FLOOR(marks/10)+1
        END <8 THEN NULL
    ELSE name
END,
CASE
    WHEN marks = 100 THEN FLOOR((marks-1)/10)+1
    ELSE FLOOR(marks/10)+1
END AS grade, marks
FROM students ORDER BY grade DESC, name ASC, marks ASC;

/* Alternative Solution 1 */
SELECT
CASE 
    WHEN g.grade >= 8 THEN s.name
    ELSE NULL
    END AS Name,
g.grade, s.marks
FROM students AS s 
JOIN grades AS g ON s.marks BETWEEN g.min_mark AND g.max_mark
ORDER BY g.grade DESC, s.name ASC, s.marks ASC;