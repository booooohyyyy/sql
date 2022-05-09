-- 제어문
-- 조건문 : IF, 반복문: WHILE, FOR, 탈출문: EXIT

SET SERVEROUTPUT ON;

-- 랜덤수를 출력하는 방법
DECLARE
    V_NUM NUMBER := DBMS_RANDOM.VALUE(); -- 0~1미만 랜덤실수
    RAN NUMBER := ROUND(DBMS_RANDOM.VALUE(0, 10)); -- 0~10까지 랜덤정수
BEGIN
    DBMS_OUTPUT.PUT_LINE(V_NUM);
    DBMS_OUTPUT.PUT_LINE(RAN);
END;

-- IF문 (IF ~ END IF)
-- PL/SQL에서 범위를 나타내는 문장은 END
DECLARE
    NUM1 NUMBER := 5;
    NUM2 NUMBER := ROUND(DBMS_RANDOM.VALUE(0, 10));
BEGIN
--    IF NUM1 >= NUM2 THEN
--        DBMS_OUTPUT.PUT_LINE(NUM1 || '이 큰 수 입니다.');
--    END IF;
    IF NUM1 >= NUM2 THEN
        DBMS_OUTPUT.PUT_LINE(NUM1 || '이 큰 수 입니다.');
    ELSE
        DBMS_OUTPUT.PUT_LINE(NUM2 || '이 큰 수 입니다.');
    END IF;

END;

-- IF ~ ELSIF THEN
DECLARE
    RAN NUMBER := ROUND(DBMS_RANDOM.VALUE(0, 100));
BEGIN
    DBMS_OUTPUT.PUT_LINE('점수: ' || RAN);
    
    IF RAN >= 90 THEN
        DBMS_OUTPUT.PUT_LINE('A학점');
    ELSIF RAN >= 80 THEN
        DBMS_OUTPUT.PUT_LINE('B학점');
    ELSIF RAN >= 70 THEN
        DBMS_OUTPUT.PUT_LINE('C학점');
    ELSE
        DBMS_OUTPUT.PUT_LINE('D학점');
    END IF;
END;

--------------------------------------------------------------------------------
-- IF문 실습 (EMPLOYEES 테이블)
-- 첫번째 값은 ROWNUM을 이용하면 됨
-- 10~120사이의 십단위 랜덤한 번호를 이용해서 랜덤 DEPARTMENT_ID의 첫번째 행만 SELECT
-- 뽑은 사람의 SALARY가 9000이상이면 높음, 5000이상이면 중간, 나머지는 낮음으로 출력
SELECT ROUND(DBMS_RANDOM.VALUE(10, 120), -1) FROM DUAL;

DECLARE
    RAN NUMBER := ROUND(DBMS_RANDOM.VALUE(10, 120), -1);
    EMP_SALARY EMPLOYEES.SALARY%TYPE;
BEGIN
    
    SELECT SALARY
    INTO EMP_SALARY
    FROM EMPLOYEES 
    WHERE DEPARTMENT_ID = RAN AND ROWNUM = 1;
    
    DBMS_OUTPUT.PUT_LINE(EMP_SALARY);
    
    IF EMP_SALARY >= 9000 THEN
        DBMS_OUTPUT.PUT_LINE('높음');
    ELSIF EMP_SALARY >= 5000 THEN
        DBMS_OUTPUT.PUT_LINE('중간');
    ELSE
        DBMS_OUTPUT.PUT_LINE('낮음');
    END IF;
END;
