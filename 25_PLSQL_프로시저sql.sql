-- 저장 프로시저 : 하나의 함수처럼 실행하기 위한 SQL문의 집합 (단, 함수X)
-- 만드는 과정, 호출해서 사용하는 과정

-- 프로시저 생성
--CREATE OR REPLACE PROCEDURE NEW_JOB_PROC -- 매개변수
--IS -- 지역변수
--BEGIN -- 실행영역
--    DBMS_OUTPUT.PUT_LINE('프로시저 실행');
--    DBMS_OUTPUT.PUT_LINE('HELLO WORLD');
--END;

-- 프로시저 호출
EXECUTE NEW_JOB_PROC;

-- 프로시저 삭제
--DROP PROCEDURE NEW_JOB_PROC;

--------------------------------------------------------------------------------
-- 프로시저의 매개변수: IN, OUT, IN OUT
--CREATE OR REPLACE PROCEDURE NEW_JOB_PROC
--( 
--    P_JOB_ID IN JOBS.JOB_ID%TYPE,
--    P_JOB_TITLE IN JOBS.JOB_TITLE%TYPE,
--    P_MIN_SALARY IN JOBS.MIN_SALARY%TYPE,
--    P_MAX_SALARY IN JOBS.MAX_SALARY%TYPE
--)
--IS
--    V_COUNT NUMBER := 0; -- 지역변수
--BEGIN
--    DBMS_OUTPUT.PUT_LINE(P_JOB_ID);
--    DBMS_OUTPUT.PUT_LINE(P_JOB_TITLE);
--    DBMS_OUTPUT.PUT_LINE(P_MIN_SALARY);
--    DBMS_OUTPUT.PUT_LINE(P_MAX_SALARY);
--    DBMS_OUTPUT.PUT_LINE(V_COUNT);
--END;

-- 매개변수의 개수를 정확히 전달
EXECUTE NEW_JOB_PROC('SI_MAN', '~~~~~~', 1000, 20000);

-- JOBS테이블에 해당값이 있다면 UPDATE, 없다면 INSERT구문으로 프로시저 생성
--CREATE OR REPLACE PROCEDURE NEW_JOB_PROC
--( 
--    P_JOB_ID IN JOBS.JOB_ID%TYPE,
--    P_JOB_TITLE IN JOBS.JOB_TITLE%TYPE,
--    P_MIN_SALARY IN JOBS.MIN_SALARY%TYPE,
--    P_MAX_SALARY IN JOBS.MAX_SALARY%TYPE
--)
--IS
--    V_COUNT NUMBER := 0; -- 지역변수
--BEGIN
--    --1. SELECT 이용해서 P_JOB_ID가 존재하는지 확인
--    --2. 있으면 지역변수 V_COUNT에 조회의 개수을 저장
--    SELECT COUNT(*)
--    INTO V_COUNT -- 조회의 개수를 전달
--    FROM JOBS
--    WHERE JOB_ID = P_JOB_ID;
--    --3. IF ~ ELSE END IF 
--    IF V_COUNT = 0 THEN
--        INSERT INTO JOBS VALUES(P_JOB_ID, P_JOB_TITLE, P_MIN_SALARY, P_MAX_SALARY);
--    ELSE
--        UPDATE JOBS SET
--            JOB_TITLE = P_JOB_TITLE,
--            MIN_SALARY = P_MIN_SALARY,
--            MAX_SALARY = P_MAX_SALARY
--        WHERE JOB_ID = P_JOB_ID;
--    END IF;
--END;

-- 호출
EXECUTE NEW_JOB_PROC('SA_MAN1', 'SAMPLE', 1100, 2200);
SELECT * FROM JOBS;
ROLLBACK;

--------------------------------------------------------------------------------
-- 매개변수의 기본값 := 0 // PARAM := 0
--CREATE OR REPLACE PROCEDURE NEW_JOB_PROC
--( 
--    P_JOB_ID IN JOBS.JOB_ID%TYPE,
--    P_JOB_TITLE IN JOBS.JOB_TITLE%TYPE,
--    P_MIN_SALARY IN JOBS.MIN_SALARY%TYPE := 1000, -- 매개변수의 기본값
--    P_MAX_SALARY IN JOBS.MAX_SALARY%TYPE := 10000 -- 매개변수의 기본값
--)
--IS
--    V_COUNT NUMBER := 0; -- 지역변수
--BEGIN
--    --1. SELECT 이용해서 P_JOB_ID가 존재하는지 확인
--    --2. 있으면 지역변수 V_COUNT에 조회의 개수을 저장
--    SELECT COUNT(*)
--    INTO V_COUNT -- 조회의 개수를 전달
--    FROM JOBS
--    WHERE JOB_ID = P_JOB_ID;
--    --3. IF ~ ELSE END IF 
--    IF V_COUNT = 0 THEN
--        INSERT INTO JOBS VALUES(P_JOB_ID, P_JOB_TITLE, P_MIN_SALARY, P_MAX_SALARY);
--    ELSE
--        UPDATE JOBS SET
--            JOB_TITLE = P_JOB_TITLE,
--            MIN_SALARY = P_MIN_SALARY,
--            MAX_SALARY = P_MAX_SALARY
--        WHERE JOB_ID = P_JOB_ID;
--    END IF;
--END;

-- 호출
EXECUTE NEW_JOB_PROC('TEST', '~~~~~'); -- 기본값이 없는 매개변수만 전달
SELECT * FROM JOBS;
ROLLBACK;

--------------------------------------------------------------------------------
-- OUT 변수 : 프로시저에서 외부로 전달할 수 있는 매개값
CREATE OR REPLACE PROCEDURE NEW_JOB_PROC
( 
    P_JOB_ID IN JOBS.JOB_ID%TYPE,
    P_JOB_TITLE IN JOBS.JOB_TITLE%TYPE,
    P_MIN_SALARY IN JOBS.MIN_SALARY%TYPE := 1000, -- 매개변수의 기본값
    P_MAX_SALARY IN JOBS.MAX_SALARY%TYPE := 10000,-- 매개변수의 기본값
    P_RESULT OUT VARCHAR2 -- OUT변수
)
IS
    V_COUNT NUMBER := 0; -- 지역변수
BEGIN
    --1. SELECT 이용해서 P_JOB_ID가 존재하는지 확인
    --2. 있으면 지역변수 V_COUNT에 조회의 개수을 저장
    SELECT COUNT(*)
    INTO V_COUNT -- 조회의 개수를 전달
    FROM JOBS
    WHERE JOB_ID = P_JOB_ID;
    --3. IF ~ ELSE END IF 
    IF V_COUNT = 0 THEN
        INSERT INTO JOBS VALUES(P_JOB_ID, P_JOB_TITLE, P_MIN_SALARY, P_MAX_SALARY);
        
        P_RESULT := '존재하지 않지 않기 때문에 INSERT 되었습니다.';
    ELSE
        UPDATE JOBS SET
            JOB_TITLE = P_JOB_TITLE,
            MIN_SALARY = P_MIN_SALARY,
            MAX_SALARY = P_MAX_SALARY
        WHERE JOB_ID = P_JOB_ID;
        
        P_RESULT := '존재하는 값이기 때문에 UPDATE 되었습니다.';
    END IF;
END;

-- OUT변수를 사용할때는 익명블록에서 호출
DECLARE
   STR VARCHAR2(100);
BEGIN
    -- 프로시저 호출시에 OUT변수를 받아올 지역변수를 전달
    NEW_JOB_PROC('TEST1', '~~~~~~~~~', 10000, 20000, STR);
    
    DBMS_OUTPUT.PUT_LINE('실행결과: ' || STR);
END;
ROLLBACK;

--------------------------------------------------------------------------------
-- IN OUT (IN과 OUT의 형태를 둘다 사용가능)
CREATE OR REPLACE PROCEDURE NEW_TEST_PROC
( 
    VAR1 IN VARCHAR2,  --입력변수
    VAR2 OUT VARCHAR2, --출력변수(OUT변수는 프로시저 종료전까지 할당X)
    VAR3 IN OUT VARCHAR2  --입출력변수
)
IS
BEGIN
    DBMS_OUTPUT.PUT_LINE('VAR1: ' || VAR1);
    DBMS_OUTPUT.PUT_LINE('VAR2: ' || VAR2);
    DBMS_OUTPUT.PUT_LINE('VAR3: ' || VAR3);
    
    --VAR1 := '결과~1'; --IN(프로시저 안에서 값의 변경이 불가)
    VAR2 := '결과~2'; --OUT
    VAR3 := '결과~3'; --IN OUT
END;

DECLARE
    V1 VARCHAR2(100) := 'A';
    V2 VARCHAR2(100) := 'B';
    V3 VARCHAR2(100) := 'C';
BEGIN
    NEW_TEST_PROC(V1, V2, V3);
    DBMS_OUTPUT.PUT_LINE('V2: ' || V2);
    DBMS_OUTPUT.PUT_LINE('V3: ' || V3);
    
    --예외
    EXCEPTION WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('예외발생');
END;

--------------------------------------------------------------------------------
--실습문제
--1. DEPARTMENTS 테이블의 복사본을 DEPTS를 생성하는 구문을 작성
CREATE TABLE DEPTS AS (SELECT * FROM DEPARTMENTS WHERE 1 = 1);
--2. 부서번호, 부서명, 작업 FLAG(I:INSERT, U:UPDATE, D:DELETE)을 매개변수로 받아 DEPTS 테이블에
--   각각 INSERT, UPDATE, DELETE하는 DEPTSPROC란 이름의 프로시저를 생성하는 구문을 작성
--3. 정상종료라면 COMMIT, 예외라면 롤백 처리
CREATE OR REPLACE PROCEDURE DEPTS_PROC
(
    DEPTS_ID IN DEPARTMENTS.DEPARTMENT_ID%TYPE,
    DEPTS_NAME IN DEPARTMENTS.DEPARTMENT_NAME%TYPE,
    DEPTS_FLAG IN VARCHAR2
)
IS
BEGIN
    IF DEPTS_FLAG = 'I' THEN
        INSERT INTO DEPTS(DEPARTMENT_ID, DEPARTMENT_NAME) 
        VALUES(DEPTS_ID, DEPTS_NAME);
    ELSIF DEPTS_FLAG = 'U' THEN
        UPDATE DEPTS SET 
        DEPARTMENT_NAME = DEPTS_NAME 
        WHERE DEPARTMENT_ID = DEPTS_ID;
    ELSIF DEPTS_FLAG = 'D' THEN
        DELETE FROM DEPTS 
        WHERE DEPARTMENT_ID = DEPTS_ID;
    ELSE
        DBMS_OUTPUT.PUT_LINE('I, U, D 중 하나를 전달하세요');
    END IF;
    
    COMMIT;
    
    EXCEPTION WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('예외발생');
        ROLLBACK;
END;

EXECUTE DEPTS_PROC(300, '인사부', 'I');
EXECUTE DEPTS_PROC(300, '회계부', 'U');
EXECUTE DEPTS_PROC(300, '회계부', 'D');

SELECT * FROM DEPTS;

--------------------------------------------------------------------------------
--실습2
-- 프로시저명 = EMP_HIREDATE_PROC
-- EMPLOYEE_ID를 입력받아 EMPLOYEES에 존재하면,
-- 근속년수 OUT하는 프로시저를 작성하세요.
--  없다면 EXCEPTION 처리
-- (IN, OUT)변수를 사용

CREATE OR REPLACE PROCEDURE EMP_HIREDATE_PROC
(
    EMPS_ID IN EMPLOYEES.EMPLOYEE_ID%TYPE,
    EMPS_YEARS OUT NUMBER
)
IS
    V_CNT NUMBER := 0;
BEGIN
    SELECT TRUNC((SYSDATE - HIRE_DATE) / 365) AS CNT
    INTO V_CNT
    FROM EMPLOYEES
    WHERE EMPLOYEE_ID = EMPS_ID;
    
    EMPS_YEARS := V_CNT;
    
    EXCEPTION WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('해당 키는 없음');
END;

DECLARE
    P_NUM NUMBER(10);
BEGIN
    EMP_HIREDATE_PROC(100, P_NUM);
    DBMS_OUTPUT.PUT_LINE(P_NUM);
END;