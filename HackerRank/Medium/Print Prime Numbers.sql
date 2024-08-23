DELIMITER $$
CREATE PROCEDURE is_prime (IN n INT, OUT cls BOOLEAN)
BEGIN
    DECLARE d INT DEFAULT 1;
    SET cls=TRUE;
    divisor: WHILE d<FLOOR(SQRT(n)) DO
        SET d=d+1;
        IF n%d=0 THEN
            SET cls=FALSE;
            LEAVE divisor;
        END IF;
    END WHILE divisor;
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE primes (IN n INT)
BEGIN
    DECLARE d INT DEFAULT 1;
    DECLARE s TEXT DEFAULT '';
    WHILE d<n DO
        SET d=d+1;
        CALL is_prime(d, @cls);
        -- SELECT @cls;
        IF @cls THEN
            SET s=CONCAT(s, d, '&');
        END IF;
    END WHILE;
    SELECT LEFT(s, LENGTH(s)-1);
END $$
DELIMITER ;

CALL primes (1000);