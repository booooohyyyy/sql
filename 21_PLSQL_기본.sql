DROP TABLE USERS;
DROP TABLE ORDER_LIST;
DROP TABLE PRODUCT; 
DROP TABLE PAYMENT;
DROP TABLE DELIVERY_ADDR;
DROP TABLE ORDER; -- ���콺�� ���̺� ����
-------------------------------------------����

/*
PL/SQL - ���α׷���� SPL
    >> ����, IF, WHILE, LOOP, FOR, �Լ� ��� ���α׷��� ����� ����� �� �ִ� ���
    
������ - �����ų ����� SHIFT + �������� �ؼ�, F5 or CTRL + ENTER



�͸���
DECLARE
    -- ������ ����
BEGIN
    -- �����ų PL/SQL��
END;

��¹���� ����
SET SERVEROUTPUT ON;
*/

DECLARE
    -- �̸� Ÿ��;
    A NUMBER;
    B NUMBER := 20;
BEGIN
    -- := ����
    A := 10;
    
    -- ��¹�
    DBMS_OUTPUT.PUT_LINE( A );
    DBMS_OUTPUT.PUT_LINE( B );
END;

-- ������
-- =, >, <, >=, <=, <>, +, -, /, *, MOD(��, ������), **(����)

DECLARE
    A NUMBER := 3**2 + 3*2;
BEGIN
    DBMS_OUTPUT.PUT_LINE( A );
    DBMS_OUTPUT.PUT_LINE('A��:' || A);
END;

--------------------------------------------------------------------------------

/*
BEGIN�� �Ʒ��� DML�� ����� �����ϴ�. (DDL���� ���Ұ�)
��ȸ�� ����� ������ ��� �ʹٸ� INTO���� ���
*/

DECLARE
    EMP_NAME VARCHAR(50);
    DEPTS_NAME VARCHAR(50);
BEGIN
    SELECT CONCAT(FIRST_NAME || ' ', LAST_NAME) AS EMP_NAME,
           D.DEPARTMENT_NAME
    INTO EMP_NAME, DEPTS_NAME -- ������ ����(�÷��� ��Ī�Ǵ� ������ ���� ��ġ)
    FROM EMPLOYEES E
    LEFT OUTER JOIN DEPARTMENTS D
    ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
    WHERE EMPLOYEE_ID = 100;
    
    DBMS_OUTPUT.PUT_LINE(EMP_NAME || ' ' || DEPTS_NAME);
END;

-- �÷���%TYPE
-- Ư�� ���̺��� �÷��� ������ Ÿ���� �����ϴ� ���
DECLARE
    EMP_NAME VARCHAR(50);
    DEPTS_NAME DEPARTMENTS.DEPARTMENT_NAME%TYPE; -- �ش� �÷��� ������ Ÿ�� ����
BEGIN
    SELECT CONCAT(FIRST_NAME || ' ', LAST_NAME) AS EMP_NAME,
           D.DEPARTMENT_NAME
    INTO EMP_NAME, DEPTS_NAME -- ������ ����(�÷��� ��Ī�Ǵ� ������ ���� ��ġ)
    FROM EMPLOYEES E
    LEFT OUTER JOIN DEPARTMENTS D
    ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
    WHERE EMPLOYEE_ID = 100;
    
    DBMS_OUTPUT.PUT_LINE(EMP_NAME || ' ' || DEPTS_NAME);
END;

--------------------------------------------------------------------------------
-- SELECT�� ����� INSERT
CREATE TABLE EMP_SAL(
    EMP_YEARS VARCHAR2(50),
    EMP_SALARY NUMBER(10)
);

-- 08�� �Ի��� ����� SALARY ���� ���ؼ� ���̺� INSERT
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
