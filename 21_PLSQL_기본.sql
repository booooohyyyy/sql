DROP TABLE USERS;
DROP TABLE ORDER_LIST;
DROP TABLE PRODUCT; 
DROP TABLE PAYMENT;
DROP TABLE DELIVERY_ADDR;
DROP TABLE ORDER; -- 마우스로 테이블 삭제
-------------------------------------------선행

/*
PL/SQL - 프로그램언어 SPL
    >> 변수, IF, WHILE, LOOP, FOR, 함수 등등 프로그램적 기능을 사용할 수 있는 기능
    
실행방법 - 실행시킬 블록을 SHIFT + 범위지정 해서, F5 or CTRL + ENTER



익명블록
DECLARE
    -- 변수의 선언
BEGIN
    -- 실행시킬 PL/SQL문
END;

출력문사용 선언
SET SERVEROUTPUT ON;
*/

DECLARE
    -- 이름 타입;
    A NUMBER;
    B NUMBER := 20;
BEGIN
    -- := 대입
    A := 10;
    
    -- 출력문
    DBMS_OUTPUT.PUT_LINE( A );
    DBMS_OUTPUT.PUT_LINE( B );
END;

-- 연산자
-- =, >, <, >=, <=, <>, +, -, /, *, MOD(값, 나눌값), **(제곱)

DECLARE
    A NUMBER := 3**2 + 3*2;
BEGIN
    DBMS_OUTPUT.PUT_LINE( A );
    DBMS_OUTPUT.PUT_LINE('A는:' || A);
END;

--------------------------------------------------------------------------------

/*
BEGIN절 아래에 DML의 사용이 가능하다. (DDL문은 사용불가)
조회한 결과를 변수에 담고 싶다면 INTO절을 사용
*/

DECLARE
    EMP_NAME VARCHAR(50);
    DEPTS_NAME VARCHAR(50);
BEGIN
    SELECT CONCAT(FIRST_NAME || ' ', LAST_NAME) AS EMP_NAME,
           D.DEPARTMENT_NAME
    INTO EMP_NAME, DEPTS_NAME -- 대입할 변수(컬럼과 대칭되는 변수의 개수 일치)
    FROM EMPLOYEES E
    LEFT OUTER JOIN DEPARTMENTS D
    ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
    WHERE EMPLOYEE_ID = 100;
    
    DBMS_OUTPUT.PUT_LINE(EMP_NAME || ' ' || DEPTS_NAME);
END;

-- 컬럼명%TYPE
-- 특정 테이블의 컬럼과 동일한 타입을 선언하는 방법
DECLARE
    EMP_NAME VARCHAR(50);
    DEPTS_NAME DEPARTMENTS.DEPARTMENT_NAME%TYPE; -- 해당 컬럼과 동일한 타입 선언
BEGIN
    SELECT CONCAT(FIRST_NAME || ' ', LAST_NAME) AS EMP_NAME,
           D.DEPARTMENT_NAME
    INTO EMP_NAME, DEPTS_NAME -- 대입할 변수(컬럼과 대칭되는 변수의 개수 일치)
    FROM EMPLOYEES E
    LEFT OUTER JOIN DEPARTMENTS D
    ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
    WHERE EMPLOYEE_ID = 100;
    
    DBMS_OUTPUT.PUT_LINE(EMP_NAME || ' ' || DEPTS_NAME);
END;

--------------------------------------------------------------------------------
-- SELECT한 결과를 INSERT
CREATE TABLE EMP_SAL(
    EMP_YEARS VARCHAR2(50),
    EMP_SALARY NUMBER(10)
);

-- 08년 입사한 사원의 SALARY 합을 구해서 테이블 INSERT
DECLARE
    EMP_SUM EMPLOYEES.SALARY%TYPE;
    EMP_YEARS EMP_SAL.EMP_YEARS%TYPE := 2008;
BEGIN
    -- SELECT
    SELECT SUM(SALARY)
    INTO EMP_SUM
    FROM EMPLOYEES
    WHERE TO_CHAR(HIRE_DATE, 'YYYY') = EMP_YEARS;
    
    -- INSERT
    INSERT INTO EMP_SAL VALUES(EMP_YEARS, EMP_SUM);
    
    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE(EMP_SUM);
END;

SELECT * FROM EMP_SAL;
