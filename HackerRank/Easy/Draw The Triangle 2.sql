DELIMITER $$
CREATE PROCEDURE P (R INT)
BEGIN
DECLARE n INT;
SET n=0;
create_triangle: LOOP
    SET n=n+1;
    SELECT REPEAT('* ', n);
    IF n=R THEN 
        LEAVE create_triangle;
    END IF;
END LOOP create_triangle;
END $$
DELIMITER ;
CALL P(20);

/* Alternative Solution 1 */
DELIMITER $$
CREATE PROCEDURE P (R INT)
BEGIN
    DECLARE n INT;
    SET n=0;
    WHILE n<R DO
        SET n=n+1;
        SELECT REPEAT('* ', n);
    END WHILE; 
END $$
DELIMITER ;
CALL P(20);

/* Alternative Solution 2 */
DELIMITER $$
CREATE PROCEDURE P (R INT)
BEGIN
    DECLARE n INT;
    SET n=0;
    REPEAT
        SET n=n+1;
        SELECT REPEAT('* ', n);
    UNTIL n=R END REPEAT; 
END $$
DELIMITER ;
CALL P(20);