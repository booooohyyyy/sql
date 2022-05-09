-- ���� ���� ********
-- ���������� SELECT�� �ȿ� SELECT���� ���� ��
-- ���������� �ݵ�� () ���´�, ������ �����ʿ� ����Ѵ�.

-- ������ �������� - SELECT�� ��ȸ����� 1�� ������ ����
SELECT SALARY
FROM EMPLOYEES
WHERE FIRST_NAME = 'Nancy';

SELECT *
FROM EMPLOYEES
WHERE SALARY >= (SELECT SALARY
                 FROM EMPLOYEES
                 WHERE FIRST_NAME = 'Nancy');
                 
-- EMPLOYEE_ID�� 103���� ����� ������ ���� ���
SELECT *
FROM EMPLOYEES
WHERE JOB_ID = (SELECT JOB_ID
                     FROM EMPLOYEES
                     WHERE EMPLOYEE_ID = 103);
                     
-- EMPLOYEE_ID 107���� ����� �μ��� ���� �����
SELECT *
FROM EMPLOYEES
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID
                       FROM EMPLOYEES
                       WHERE EMPLOYEE_ID = 107);
                       
--------------------------------
-- ���� �� ���������� ����� ������ ��� ����� �� ����
-- �̷� ���� ���� �� ���������� �̿��ؼ� ó��
SELECT EMPLOYEE_ID
FROM EMPLOYEES
WHERE JOB_ID = 'IT_PROG';

SELECT *
FROM EMPLOYEES
WHERE EMPLOYEE_ID = (SELECT EMPLOYEE_ID
                     FROM EMPLOYEES
                     WHERE JOB_ID = 'IT_PROG');


