/*
VIEW�� �������� �ڷḦ ���� ���� ����ϴ� �������̺�
���� - �������̺��̱� ������ �ʿ��� �÷��� �����صθ� ������ ����
�並 ����ϸ� ���� �����ʹ� �����ϰ� ��ȣ�� �� �ִ�.
*/

-- �並 ������� ������ �ʿ�
SELECT * FROM USER_ROLE_PRIVS;
SELECT * FROM USER_SYS_PRIVS;

-- �ܼ� �� (�ϳ��� ���̺��� �̿��ؼ� ����� ��)
CREATE /*OR REPLACE*/ VIEW VIEW_EMP
AS (SELECT EMPLOYEE_ID,
           CONCAT(FIRST_NAME || ' ', LAST_NAME) AS NAME,
           JOB_ID,
           SALARY
    FROM EMPLOYEES
    WHERE DEPARTMENT_ID = 60);
    
SELECT * FROM VIEW_EMP;

-- ���� �� (���� ���̺��� �����ؼ� �ʿ��� �͸� ������ ����)
SELECT * FROM JOBS;
SELECT * FROM DEPARTMENTS;

CREATE VIEW VIEW_EMP_DEPT_JOBS
AS (SELECT E.EMPLOYEE_ID,
           CONCAT(FIRST_NAME || ' ', LAST_NAME) AS NAME,
           D.DEPARTMENT_NAME,
           J.JOB_TITLE
    FROM EMPLOYEES E
    LEFT OUTER JOIN DEPARTMENTS D
    ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
    LEFT OUTER JOIN JOBS J
    ON E.JOB_ID = J.JOB_ID);
    
SELECT * FROM VIEW_EMP_DEPT_JOBS;

-- ���� ���� (OR REPLACE)
-- ���� �̸����� �並 ����� ������ ����Ǹ鼭 �������
CREATE OR REPLACE VIEW VIEW_EMP_DEPT_JOBS
AS (SELECT E.EMPLOYEE_ID,
           E.HIRE_DATE, -- �߰�
           E.SALARY, -- �߰�
           CONCAT(FIRST_NAME || ' ', LAST_NAME) AS NAME,
           D.DEPARTMENT_NAME,
           J.JOB_TITLE
    FROM EMPLOYEES E
    LEFT OUTER JOIN DEPARTMENTS D
    ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
    LEFT OUTER JOIN JOBS J
    ON E.JOB_ID = J.JOB_ID);
    
SELECT * FROM VIEW_EMP_DEPT_JOBS;

SELECT AVG(SALARY), JOB_TITLE
FROM VIEW_EMP_DEPT_JOBS
GROUP BY JOB_TITLE
ORDER BY AVG(SALARY);

-- �� ����
DROP VIEW VIEW_EMP;
DROP VIEW VIEW_EMP_DEPT_JOBS;

--------------------------------------------------------------------------------
/*
�信���� DML������ �Ͼ�� ��� ���� ���̺� �ݿ��ȴ�.
������, VIEW�� CRUD�۾��� �Ͼ�� ��������� ���� ��

���� ���̺��� NOT NULL�� ���, VIEW���� ����� �̸��� ������ ��� ��� CRUD�۾��� �Ұ���
*/
SELECT * FROM VIEW_EMP_DEPT_JOBS;

-- �������̺��� NOT NULL.
INSERT INTO VIEW_EMP_DEPT_JOBS (EMPLOYEE_ID, HIRE_DATE) VALUES (300, SYSDATE);

-- JOIN���� �̷���� ���̺��� ������ �� ����.
INSERT INTO VIEW_EMP_DEPT_JOBS (EMPLOYEE_ID, JOB_TITLE, DEPARTMENT_NAME)
VALUES (300, 'TEST', 'TEST');

-- NAME = �����̱� ������ ������ �� ����.
UPDATE VIEW_EMP_DEPT_JOBS SET NAME = 'TEST' WHERE EMPLOYEE_ID = 100;

-- WITH CHECK OPTION - �並 ���� �� ���ǵ� ���� ��� �� �� ���� (�����÷�����)
CREATE OR REPLACE VIEW VIEW_EXP_TEST
AS (SELECT EMPLOYEE_ID,
           FIRST_NAME,
           LAST_NAME,
           JOB_ID,
           DEPARTMENT_ID
    FROM EMPLOYEES
    WHERE DEPARTMENT_ID IN (60,70,80))
--WITH CHECK OPTION;
WITH READ ONLY; -- SELECT�� ������ ��

SELECT * FROM VIEW_EXP_TEST;
-- 60, 70, 80�� �ƴϸ� INSERT �Ұ�
INSERT INTO VIEW_EXP_TEST VALUES (300, 'TEST', 'TEST', 'TEST', 100);