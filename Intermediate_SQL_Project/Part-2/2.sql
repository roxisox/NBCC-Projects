--1
ALTER TABLE DETAILRENTAL add DAYS_LATE NUMBER(4);

--2
ALTER TABLE GAMECOPY
ADD GA_STATUS VARCHAR2(4) DEFAULT 'IN' NOT NULL
CONSTRAINT status_domain CHECK (GA_STATUS IN ('IN', 'OUT', 'LOST'));

--3
UPDATE GAMECOPY SET GA_STATUS = 'OUT' WHERE GC_NUM IN(SELECT GC_NUM FROM DETAILRENTAL WHERE RETURN_DATE IS NULL);

--4
ALTER TABLE PRICE ADD RENT_DAYS NUMBER(2) DEFAULT 3 NOT NULL;

--5
UPDATE PRICE SET RENT_DAYS = 5 WHERE PRICE_CODE = 1;
UPDATE PRICE SET RENT_DAYS = 3 WHERE PRICE_CODE = 2;
UPDATE PRICE SET RENT_DAYS = 5 WHERE PRICE_CODE = 3;
UPDATE PRICE SET RENT_DAYS = 7 WHERE PRICE_CODE = 4;
SELECT * FROM PRICE;

--6
SELECT g.ga_num as "Game Number", g.title, COUNT(gc.gc_num) AS INVENTORY
FROM game g
JOIN gamecopy gc ON g.ga_num = gc.ga_num
GROUP BY g.ga_num, g.title;

--7
SELECT g.ga_num as "Game Number", g.title, COUNT(r.rent_num)AS INVENTORY
FROM game g
JOIN gamecopy gc ON g.ga_num = gc.ga_num
LEFT JOIN detailrental dr ON gc.gc_num = dr.gc_num
LEFT JOIN RENTAL r ON dr.RENT_NUM = r.RENT_NUM 
AND dr.return_date IS NOT NULL
GROUP BY g.ga_num, g.title;

--8
DROP SEQUENCE SEQ_GAME_COPY;
DROP SEQUENCE SEQ_RENT_NUM;

CREATE SEQUENCE SEQ_GAME_COPY
START WITH 70000
INCREMENT by 1
NOcache;

CREATE SEQUENCE SEQ_RENT_NUM
start with 1200 
INCREMENT by 1
NOcache;


------------------------------9---------------------------------

SET SERVEROUTPUT ON;
CREATE OR REPLACE PROCEDURE PRC_ADD_GAMECOPY (
    p_ga_num VARCHAR2
)
AS
    v_game_count NUMBER;
    v_gc_num NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_game_count FROM game WHERE ga_num = p_ga_num;

    IF v_game_count = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Error: Game number ' || p_ga_num || ' does not exist.');
        RETURN;
    END IF;

    SELECT SEQ_GAME_COPY.NEXTVAL INTO v_gc_num FROM DUAL;

    INSERT INTO gamecopy (gc_num, indate, ga_num, ga_status)
    VALUES (v_gc_num, SYSDATE, p_ga_num, 'IN');

    DBMS_OUTPUT.PUT_LINE('New game copy added successfully:');
    DBMS_OUTPUT.PUT_LINE('Game Copy Number: ' || v_gc_num);
    DBMS_OUTPUT.PUT_LINE('Game Number: ' || p_ga_num);
    DBMS_OUTPUT.PUT_LINE('Status: IN');
EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20001, 'Error: Unable to add game copy.');
END;
/

call PRC_ADD_GAMECOPY('70002');




----------------------------10---------------------------------

SET SERVEROUTPUT ON;

CREATE or REPLACE PROCEDURE PRC_MEM_INFO(
    membership_num NUMBER
)
AS
    v_name VARCHAR2(30);
    v_postal VARCHAR2(10);
    v_steet VARCHAR2(50);
    v_COUNT NUMBER;

BEGIN
    SELECT lname||', '|| fname As Name, Street,  postal 
    INTO v_name, v_steet, v_postal
    from membership
    where mem_num = membership_num;

    IF v_COUNT  = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Error: name ' || v_name );
        RETURN;
    END IF;
    
    DBMS_OUTPUT.PUT_LINE(v_name);
    DBMS_OUTPUT.PUT_LINE(v_steet ||'  '|| v_postal);

EXCEPTION
    WHEN NO_DATA_FOUND  THEN
      RAISE_APPLICATION_ERROR(-20011, 'No Matching Membership ID for '|| membership_num);
    
END;
/

call PRC_MEM_INFO(411);

-----------------------11-----------------------------
SET SERVEROUTPUT ON;

CREATE or REPLACE PROCEDURE PRC_NEW_RENTAL(
    P_mem_num NUMBER
)
AS
    v_name VARCHAR2(30);
    v_postal VARCHAR2(10);
    v_steet VARCHAR2(50);
    v_COUNT NUMBER;
    v_balance NUMBER;
    v_gc_num NUMBER;

BEGIN

    SELECT lname||', '|| fname As Name, Street,  postal 
    INTO v_name, v_steet, v_postal
    from membership
    where mem_num = P_mem_num;

    IF v_COUNT  = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Error: name ' || v_name );
        RETURN;
    END IF;

    DBMS_OUTPUT.PUT_LINE(v_name);
    DBMS_OUTPUT.PUT_LINE(v_steet ||'  '|| v_postal);

    SELECT BALANCE into v_balance FROM MEMBERSHIP where MEM_NUM = P_mem_num;
    DBMS_OUTPUT.PUT_LINE('$Balance: ' || v_balance);

    SELECT SEQ_RENT_NUM.NEXTVAL INTO v_gc_num FROM DUAL;

    INSERT INTO RENTAL (RENT_NUM, RENT_DATE, MEM_NUM)
    VALUES (v_gc_num, SYSDATE, P_mem_num);


EXCEPTION
    WHEN NO_DATA_FOUND  THEN
      RAISE_APPLICATION_ERROR(-20021, 'No Matching Membership ID for '|| P_mem_num);
 
END;
/
SELECT * FROM RENTAL;
call PRC_NEW_RENTAL(111);



--------------------------------------12---------------------------------------------
SET SERVEROUTPUT ON;
CREATE OR REPLACE PROCEDURE PRC_NEW_DETAIL(p_game_num NUMBER) AS
    v_gc_num            VARCHAR2(60);
    v_game_available    BOOLEAN := FALSE;
    v_rent_fee          NUMBER(5,2);
    v_daily_late_fee    NUMBER(5,2);
    v_rent_days         NUMBER;
    v_due_date          DATE;
    v_rent_num          VARCHAR2(50);
    e_game_not_found    EXCEPTION;
    e_no_game_available EXCEPTION;
    v_title             VARCHAR2(50);
BEGIN
    BEGIN
        SELECT gc.gc_num, g.TITLE INTO v_gc_num, v_title
        FROM GAMECOPY gc
        JOIN GAME g
        ON gc.ga_num = g.ga_num
        WHERE g.ga_num = p_game_num
        AND ga_status = 'IN';
        
        v_game_available := TRUE;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE e_game_not_found;
    END;

    IF v_game_available THEN
        SELECT rent_fee, daily_late_fee, rent_days
        INTO v_rent_fee, v_daily_late_fee, v_rent_days
        FROM price
        WHERE price_code = (SELECT price_code FROM game WHERE ga_num = p_game_num);

        v_due_date := SYSDATE + v_rent_days;

        SELECT SEQ_RENT_NUM.NEXTVAL INTO v_rent_num FROM DUAL;
        INSERT INTO detailrental (rent_num, gc_num, fee, due_date, return_date, daily_late_fee)
        VALUES (v_rent_num, v_gc_num, v_rent_fee ,v_due_date,null, v_daily_late_fee);

        UPDATE gamecopy
        SET ga_status = 'OUT'
        WHERE gc_num = v_gc_num;
        commit;
        DBMS_OUTPUT.PUT_LINE('Rental Number: ' || v_rent_num);
        DBMS_OUTPUT.PUT_LINE('Game Copy: ' || v_gc_num);
        DBMS_OUTPUT.PUT_LINE('Title: ' || v_title);
        DBMS_OUTPUT.PUT_LINE('Rental Fee: ' || v_rent_fee);
        DBMS_OUTPUT.PUT_LINE('Late Fee: ' || v_daily_late_fee);
        DBMS_OUTPUT.PUT_LINE('Due Back in ' || v_rent_days || ' days - ' || TO_CHAR(v_due_date, 'YYYY-MM-DD'));

    ELSE
        RAISE e_no_game_available;
    END IF;

EXCEPTION
    WHEN e_game_not_found THEN
        DBMS_OUTPUT.PUT_LINE('ORA-20032: No matching game ID for ' || p_game_num);
    WHEN e_no_game_available THEN
        DBMS_OUTPUT.PUT_LINE('No game currently available for rent.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Unexpected error: ' || SQLERRM);
END;
/

SHOW ERRORS PROCEDURE PRC_NEW_DETAIL;

call PRC_NEW_DETAIL(1246);
--don't knpw why giving me integrity constrain error


---------------------------------------13-----------------------------------
-- Define default values for member number and game number for testing
DEFINE member_num = 111;
DEFINE game_num = 1246;

SET SERVEROUTPUT ON;
SET VERIFY OFF;

DECLARE
  v_member_num CHAR(4) := '&member_num';
  v_game_num CHAR(5) := '&game_num';
BEGIN
  --Call procedure to rent a game
  PRC_RENT_GAME(v_member_num, v_game_num);

    IF NOT EXISTS (SELECT * FROM RENTAL WHERE mem_num = v_member_num AND game_num = v_game_num)
        THEN
        RAISE_APPLICATION_ERROR(-20001, 'Rental transaction failed.');
    END IF;

  DBMS_OUTPUT.PUT_LINE('Rental transaction completed successfully for Member ' || v_member_num || ' and Game ' || v_game_num);

EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
END;
/

-------------------------------------14------------------------------------

------------------------------------15-------------------------------------
SET SERVEROUTPUT ON;
--DROP procedure PRC_RETURN_GAME;
CREATE OR REPLACE PROCEDURE PRC_RETURN_GAME(p_gc_num IN NUMBER) AS
  v_count NUMBER;
BEGIN
  SELECT COUNT(*) INTO v_count FROM detailrental WHERE gc_num = p_gc_num AND return_date IS NULL;

  IF v_count = 0 THEN
    DBMS_OUTPUT.PUT_LINE('Error: The game copy number provided was not found or has already been returned.');
    RETURN;
  ELSIF v_count > 1 THEN
    DBMS_OUTPUT.PUT_LINE('Error: The game has multiple outstanding rentals.');
    RETURN;
  ELSE
    UPDATE detailrental
    SET return_date = SYSDATE
    WHERE gc_num = p_gc_num AND return_date IS NULL;

    UPDATE gamecopy
    SET indate = SYSDATE -- Assuming 'indate' tracks the last check-in
    WHERE gc_num = p_gc_num;

    -- Success message
    DBMS_OUTPUT.PUT_LINE('The game was successfully returned.');
  END IF;

  
  COMMIT;
EXCEPTION
  WHEN OTHERS THEN
    -- Rolling back in case of any error
    ROLLBACK;
    RAISE_APPLICATION_ERROR(-20044, 'No Matching game copy for : ' || p_gc_num);
END PRC_RETURN_GAME;
/

call PRC_RETURN_GAME(61367);

-----------------------------------16------------------------------------
CREATE OR REPLACE TRIGGER TRG_LATE_RETURN
BEFORE UPDATE OF RETURN_DATE, DUE_DATE ON DETAILRENTAL
FOR EACH ROW
BEGIN
  IF :NEW.RETURN_DATE IS NULL THEN
    :NEW.DAYS_LATE := NULL;
  ELSIF :NEW.RETURN_DATE <= :NEW.DUE_DATE THEN
    :NEW.DAYS_LATE := 0;
  ELSIF :NEW.RETURN_DATE > :NEW.DUE_DATE THEN
    :NEW.DAYS_LATE := :NEW.RETURN_DATE - :NEW.DUE_DATE;
  END IF;
END;
/

-- Add a row to test the trigger
INSERT INTO DETAILRENTAL (rent_num, gc_num, fee, due_date, return_date, daily_late_fee, DAYS_LATE)
VALUES ('R0001', 'GC001', 10.00, SYSDATE + 7, NULL, 1.50, NULL);

COMMIT;

UPDATE DETAILRENTAL SET RETURN_DATE = NULL WHERE rent_num = 'R0001';
UPDATE DETAILRENTAL SET RETURN_DATE = SYSDATE + 7 WHERE rent_num = 'R0001';
UPDATE DETAILRENTAL SET RETURN_DATE = SYSDATE + 10 WHERE rent_num = 'R0001';
UPDATE DETAILRENTAL SET DUE_DATE = SYSDATE + 5 WHERE rent_num = 'R0001';
