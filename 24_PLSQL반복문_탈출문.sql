-- 반복문 WHILE
-- 범위를 나타내는 표현 LOOP ~ END LOOP
DECLARE
    A NUMBER := 1;
BEGIN
    WHILE A < 10
    LOOP
        DBMS_OUTPUT.PUT_LINE(A);
        A := A + 1; -- 1증가
    END LOOP;
END;

-- 3단 출력
DECLARE
    NUM NUMBER := 3;
    A NUMBER := 1;
BEGIN
    WHILE A < 10
    LOOP
        DBMS_OUTPUT.PUT_LINE(NUM || ' * ' || A || ' = ' || NUM*A);
        A := A + 1;
    END LOOP;
END;

-- FOR문 FOR A IN 1..9
DECLARE
    NUM NUMBER := 3;
BEGIN
    FOR I IN 1..9
    LOOP
        DBMS_OUTPUT.PUT_LINE(NUM || ' * ' || I || ' = ' || NUM*I);
    END LOOP;
END;

--------------------------------------------------------------------------------
-- 탈출문
-- EXIT WHEN 조건
-- CONTINUE WHEN 조건
DECLARE
    A NUMBER := 1;
BEGIN
    WHILE A <= 100
    LOOP
        DBMS_OUTPUT.PUT_LINE(A);
        
        EXIT WHEN A = 10; -- A가 10이면 탈출
                
        A := A + 1; -- 1증가
        
    END LOOP;
END;

--
DECLARE
BEGIN
    FOR I IN 1..10
    LOOP
        CONTINUE WHEN I = 5;
        DBMS_OUTPUT.PUT_LINE(I);
    END LOOP;
END;

--------------------------------------------------------------------------------
--1. 모든 구구단을 출력하는 익명블록
DECLARE
BEGIN
    FOR DAN IN 2..9
    LOOP
    DBMS_OUTPUT.PUT_LINE(DAN || '단');
        FOR I IN 1..9
        LOOP
            DBMS_OUTPUT.PUT_LINE(DAN || ' X ' || I || ' = ' || DAN*I);
        END LOOP;
    DBMS_OUTPUT.PUT_LINE('------------------');
    END LOOP;
END;

--2. EMPS테이블에 INSERT를 100번 수행하는 익명블록(데이터는 자유)
DROP TABLE EMPS;
CREATE TABLE EMPS AS (SELECT * FROM EMPLOYEES WHERE 1 = 2);

DECLARE
BEGIN
    FOR I IN 1..100
    LOOP
    INSERT INTO EMPS(EMPLOYEE_ID, LAST_NAME, EMAIL, HIRE_DATE, JOB_ID)
    VALUES(I, 'AAA'||I, 'BBB'||I, SYSDATE, 'IT');
    END LOOP;
    
    COMMIT;
END;

SELECT * FROM EMPS;