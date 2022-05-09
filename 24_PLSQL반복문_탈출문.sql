-- �ݺ��� WHILE
-- ������ ��Ÿ���� ǥ�� LOOP ~ END LOOP
DECLARE
    A NUMBER := 1;
BEGIN
    WHILE A < 10
    LOOP
        DBMS_OUTPUT.PUT_LINE(A);
        A := A + 1; -- 1����
    END LOOP;
END;

-- 3�� ���
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

-- FOR�� FOR A IN 1..9
DECLARE
    NUM NUMBER := 3;
BEGIN
    FOR I IN 1..9
    LOOP
        DBMS_OUTPUT.PUT_LINE(NUM || ' * ' || I || ' = ' || NUM*I);
    END LOOP;
END;

--------------------------------------------------------------------------------
-- Ż�⹮
-- EXIT WHEN ����
-- CONTINUE WHEN ����
DECLARE
    A NUMBER := 1;
BEGIN
    WHILE A <= 100
    LOOP
        DBMS_OUTPUT.PUT_LINE(A);
        
        EXIT WHEN A = 10; -- A�� 10�̸� Ż��
                
        A := A + 1; -- 1����
        
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
--1. ��� �������� ����ϴ� �͸���
DECLARE
BEGIN
    FOR DAN IN 2..9
    LOOP
    DBMS_OUTPUT.PUT_LINE(DAN || '��');
        FOR I IN 1..9
        LOOP
            DBMS_OUTPUT.PUT_LINE(DAN || ' X ' || I || ' = ' || DAN*I);
        END LOOP;
    DBMS_OUTPUT.PUT_LINE('------------------');
    END LOOP;
END;

--2. EMPS���̺� INSERT�� 100�� �����ϴ� �͸���(�����ʹ� ����)
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