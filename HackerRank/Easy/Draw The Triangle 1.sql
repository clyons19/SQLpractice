DELIMITER $$
CREATE PROCEDURE P (R INT)
BEGIN
DECLARE n INT;
SET n=R;
create_triangle: LOOP
    SELECT REPEAT('* ', n);
    SET n = n-1;
    IF n=0 THEN 
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
    SET n=R;
    WHILE n>0 DO
        SELECT REPEAT('* ', n);
        SET n=n-1;
    END WHILE; 
END $$
DELIMITER ;
CALL P(20);

/* Alternative Solution 2 */
DELIMITER $$
CREATE PROCEDURE P (R INT)
BEGIN
    DECLARE n INT;
    SET n=R;
    REPEAT
        SELECT REPEAT('* ', n);
        SET n=n-1;
    UNTIL n=0 END REPEAT; 
END $$
DELIMITER ;
CALL P(20);