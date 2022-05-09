--�ּ�
--PDB���� ����������� ����մϴ�. (hr)
ALTER USER HR ACCOUNT UNLOCK;
ALTER USER HR IDENTIFIED BY HR;

-- CTRL + ENTER�� SQL�� ����
-- ����Ŭ������ ��ҹ��ڸ� �������� �ʴ´�.
-- ������, ������, ��¥�� ũ�� 3����
SELECT * FROM EMPLOYEES;

SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, SALARY
FROM EMPLOYEES;

SELECT EMPLOYEE_ID, EMAIL, PHONE_NUMBER, HIRE_DATE
FROM EMPLOYEES;

-- �÷��� ��ȸ��ġ���� * / + - ������ ����� ������.
SELECT SALARY, COMMISSION_PCT
FROM EMPLOYEES;

-- NULL���� Ȯ��, NULL ���� ������ ����Ǿ NULL
SELECT SALARY, SALARY * 0.1, COMMISSION_PCT, COMMISSION_PCT * 100
FROM EMPLOYEES;

-- NULL, 0, ���� ���� �ٸ�
SELECT DEPARTMENT_ID, COMMISSION_PCT
FROM EMPLOYEES;

-- ALIAS (�� ��� �̸�����)
SELECT EMPLOYEE_ID AS �����ȣ,
       FIRST_NAME AS �̸�,
       LAST_NAME ��,
       SALARY �޿�
FROM EMPLOYEES;

-- ALIAS (Ư������, ���� �� ���Ե� ���) "" �̸�����
SELECT FIRST_NAME "���� ����",
       SALARY * 12 "����"
FROM EMPLOYEES;

-- ����Ŭ������ Ȭ����ǥ�� ���ڸ� ǥ���ϰ�, ���ڿ��ȿ� ȥ����ǥ�� ǥ���Ϸ��� '' �ι� �������� ���� �ȴ�.
-- ���ڿ��� ������ ||
SELECT FIRST_NAME || ' ' || LAST_NAME || '''s �޿��� $' || SALARY || '�Դϴ�.'
AS DETAIL
FROM EMPLOYEES;

-- �ߺ� �� ���� DISTINCT
SELECT DISTINCT DEPARTMENT_ID
FROM EMPLOYEES;

-- ROWNUM, ROWID
SELECT ROWID, ROWNUM, EMPLOYEE_ID
FROM EMPLOYEES;
