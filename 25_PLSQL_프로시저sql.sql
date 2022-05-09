-- ���� ���ν��� : �ϳ��� �Լ�ó�� �����ϱ� ���� SQL���� ���� (��, �Լ�X)
-- ����� ����, ȣ���ؼ� ����ϴ� ����

-- ���ν��� ����
--CREATE OR REPLACE PROCEDURE NEW_JOB_PROC -- �Ű�����
--IS -- ��������
--BEGIN -- ���࿵��
--    DBMS_OUTPUT.PUT_LINE('���ν��� ����');
--    DBMS_OUTPUT.PUT_LINE('HELLO WORLD');
--END;

-- ���ν��� ȣ��
EXECUTE NEW_JOB_PROC;

-- ���ν��� ����
--DROP PROCEDURE NEW_JOB_PROC;

--------------------------------------------------------------------------------
-- ���ν����� �Ű�����: IN, OUT, IN OUT
--CREATE OR REPLACE PROCEDURE NEW_JOB_PROC
--( 
--    P_JOB_ID IN JOBS.JOB_ID%TYPE,
--    P_JOB_TITLE IN JOBS.JOB_TITLE%TYPE,
--    P_MIN_SALARY IN JOBS.MIN_SALARY%TYPE,
--    P_MAX_SALARY IN JOBS.MAX_SALARY%TYPE
--)
--IS
--    V_COUNT NUMBER := 0; -- ��������
--BEGIN
--    DBMS_OUTPUT.PUT_LINE(P_JOB_ID);
--    DBMS_OUTPUT.PUT_LINE(P_JOB_TITLE);
--    DBMS_OUTPUT.PUT_LINE(P_MIN_SALARY);
--    DBMS_OUTPUT.PUT_LINE(P_MAX_SALARY);
--    DBMS_OUTPUT.PUT_LINE(V_COUNT);
--END;

-- �Ű������� ������ ��Ȯ�� ����
EXECUTE NEW_JOB_PROC('SI_MAN', '~~~~~~', 1000, 20000);

-- JOBS���̺� �ش簪�� �ִٸ� UPDATE, ���ٸ� INSERT�������� ���ν��� ����
--CREATE OR REPLACE PROCEDURE NEW_JOB_PROC
--( 
--    P_JOB_ID IN JOBS.JOB_ID%TYPE,
--    P_JOB_TITLE IN JOBS.JOB_TITLE%TYPE,
--    P_MIN_SALARY IN JOBS.MIN_SALARY%TYPE,
--    P_MAX_SALARY IN JOBS.MAX_SALARY%TYPE
--)
--IS
--    V_COUNT NUMBER := 0; -- ��������
--BEGIN
--    --1. SELECT �̿��ؼ� P_JOB_ID�� �����ϴ��� Ȯ��
--    --2. ������ �������� V_COUNT�� ��ȸ�� ������ ����
--    SELECT COUNT(*)
--    INTO V_COUNT -- ��ȸ�� ������ ����
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

-- ȣ��
EXECUTE NEW_JOB_PROC('SA_MAN1', 'SAMPLE', 1100, 2200);
SELECT * FROM JOBS;
ROLLBACK;

--------------------------------------------------------------------------------
-- �Ű������� �⺻�� := 0 // PARAM := 0
--CREATE OR REPLACE PROCEDURE NEW_JOB_PROC
--( 
--    P_JOB_ID IN JOBS.JOB_ID%TYPE,
--    P_JOB_TITLE IN JOBS.JOB_TITLE%TYPE,
--    P_MIN_SALARY IN JOBS.MIN_SALARY%TYPE := 1000, -- �Ű������� �⺻��
--    P_MAX_SALARY IN JOBS.MAX_SALARY%TYPE := 10000 -- �Ű������� �⺻��
--)
--IS
--    V_COUNT NUMBER := 0; -- ��������
--BEGIN
--    --1. SELECT �̿��ؼ� P_JOB_ID�� �����ϴ��� Ȯ��
--    --2. ������ �������� V_COUNT�� ��ȸ�� ������ ����
--    SELECT COUNT(*)
--    INTO V_COUNT -- ��ȸ�� ������ ����
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

-- ȣ��
EXECUTE NEW_JOB_PROC('TEST', '~~~~~'); -- �⺻���� ���� �Ű������� ����
SELECT * FROM JOBS;
ROLLBACK;

--------------------------------------------------------------------------------
-- OUT ���� : ���ν������� �ܺη� ������ �� �ִ� �Ű���
CREATE OR REPLACE PROCEDURE NEW_JOB_PROC
( 
    P_JOB_ID IN JOBS.JOB_ID%TYPE,
    P_JOB_TITLE IN JOBS.JOB_TITLE%TYPE,
    P_MIN_SALARY IN JOBS.MIN_SALARY%TYPE := 1000, -- �Ű������� �⺻��
    P_MAX_SALARY IN JOBS.MAX_SALARY%TYPE := 10000,-- �Ű������� �⺻��
    P_RESULT OUT VARCHAR2 -- OUT����
)
IS
    V_COUNT NUMBER := 0; -- ��������
BEGIN
    --1. SELECT �̿��ؼ� P_JOB_ID�� �����ϴ��� Ȯ��
    --2. ������ �������� V_COUNT�� ��ȸ�� ������ ����
    SELECT COUNT(*)
    INTO V_COUNT -- ��ȸ�� ������ ����
    FROM JOBS
    WHERE JOB_ID = P_JOB_ID;
    --3. IF ~ ELSE END IF 
    IF V_COUNT = 0 THEN
        INSERT INTO JOBS VALUES(P_JOB_ID, P_JOB_TITLE, P_MIN_SALARY, P_MAX_SALARY);
        
        P_RESULT := '�������� ���� �ʱ� ������ INSERT �Ǿ����ϴ�.';
    ELSE
        UPDATE JOBS SET
            JOB_TITLE = P_JOB_TITLE,
            MIN_SALARY = P_MIN_SALARY,
            MAX_SALARY = P_MAX_SALARY
        WHERE JOB_ID = P_JOB_ID;
        
        P_RESULT := '�����ϴ� ���̱� ������ UPDATE �Ǿ����ϴ�.';
    END IF;
END;

-- OUT������ ����Ҷ��� �͸��Ͽ��� ȣ��
DECLARE
   STR VARCHAR2(100);
BEGIN
    -- ���ν��� ȣ��ÿ� OUT������ �޾ƿ� ���������� ����
    NEW_JOB_PROC('TEST1', '~~~~~~~~~', 10000, 20000, STR);
    
    DBMS_OUTPUT.PUT_LINE('������: ' || STR);
END;
ROLLBACK;

--------------------------------------------------------------------------------
-- IN OUT (IN�� OUT�� ���¸� �Ѵ� ��밡��)
CREATE OR REPLACE PROCEDURE NEW_TEST_PROC
( 
    VAR1 IN VARCHAR2,  --�Էº���
    VAR2 OUT VARCHAR2, --��º���(OUT������ ���ν��� ���������� �Ҵ�X)
    VAR3 IN OUT VARCHAR2  --����º���
)
IS
BEGIN
    DBMS_OUTPUT.PUT_LINE('VAR1: ' || VAR1);
    DBMS_OUTPUT.PUT_LINE('VAR2: ' || VAR2);
    DBMS_OUTPUT.PUT_LINE('VAR3: ' || VAR3);
    
    --VAR1 := '���~1'; --IN(���ν��� �ȿ��� ���� ������ �Ұ�)
    VAR2 := '���~2'; --OUT
    VAR3 := '���~3'; --IN OUT
END;

DECLARE
    V1 VARCHAR2(100) := 'A';
    V2 VARCHAR2(100) := 'B';
    V3 VARCHAR2(100) := 'C';
BEGIN
    NEW_TEST_PROC(V1, V2, V3);
    DBMS_OUTPUT.PUT_LINE('V2: ' || V2);
    DBMS_OUTPUT.PUT_LINE('V3: ' || V3);
    
    --����
    EXCEPTION WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('���ܹ߻�');
END;

--------------------------------------------------------------------------------
--�ǽ�����
--1. DEPARTMENTS ���̺��� ���纻�� DEPTS�� �����ϴ� ������ �ۼ�
CREATE TABLE DEPTS AS (SELECT * FROM DEPARTMENTS WHERE 1 = 1);
--2. �μ���ȣ, �μ���, �۾� FLAG(I:INSERT, U:UPDATE, D:DELETE)�� �Ű������� �޾� DEPTS ���̺�
--   ���� INSERT, UPDATE, DELETE�ϴ� DEPTSPROC�� �̸��� ���ν����� �����ϴ� ������ �ۼ�
--3. ���������� COMMIT, ���ܶ�� �ѹ� ó��
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
        DBMS_OUTPUT.PUT_LINE('I, U, D �� �ϳ��� �����ϼ���');
    END IF;
    
    COMMIT;
    
    EXCEPTION WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('���ܹ߻�');
        ROLLBACK;
END;

EXECUTE DEPTS_PROC(300, '�λ��', 'I');
EXECUTE DEPTS_PROC(300, 'ȸ���', 'U');
EXECUTE DEPTS_PROC(300, 'ȸ���', 'D');

SELECT * FROM DEPTS;

--------------------------------------------------------------------------------
--�ǽ�2
-- ���ν����� = EMP_HIREDATE_PROC
-- EMPLOYEE_ID�� �Է¹޾� EMPLOYEES�� �����ϸ�,
-- �ټӳ�� OUT�ϴ� ���ν����� �ۼ��ϼ���.
--  ���ٸ� EXCEPTION ó��
-- (IN, OUT)������ ���

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
        DBMS_OUTPUT.PUT_LINE('�ش� Ű�� ����');
END;

DECLARE
    P_NUM NUMBER(10);
BEGIN
    EMP_HIREDATE_PROC(100, P_NUM);
    DBMS_OUTPUT.PUT_LINE(P_NUM);
END;