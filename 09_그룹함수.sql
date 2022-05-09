-- �׷��Լ� SUM, AVG, MAX, MIN, COUNT
SELECT SUM(SALARY), AVG(SALARY), MAX(SALARY), MIN(SALARY), COUNT(*), COUNT(SALARY) FROM EMPLOYEES;

SELECT COUNT(*) FROM EMPLOYEES; -- ��ü �ళ��
SELECT COUNT(FIRST_NAME) FROM EMPLOYEES; -- NULL�� �ƴ� ���� ����
SELECT COUNT(COMMISSION_PCT) FROM EMPLOYEES;

SELECT SUM(SALARY), AVG(SALARY)
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 60; -- 60�μ��� ���� ��� ��

-- ��������: �׷��Լ��� �Ϲ� �÷��� ���� ��� �Ұ�
--SELECT FIRST_NAME, SUM(SALARY)
--FROM EMPLOYEES;

--------------------------------------------------------------------------------
-- GROUP BY �÷�
-- GRUOP BY�� ������ ���� �÷��� SELECT�������� ����� �Ұ���
SELECT DEPARTMENT_ID, SUM(SALARY), AVG(SALARY), COUNT(SALARY) 
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID;

SELECT JOB_ID, SUM(SALARY), AVG(SALARY)
FROM EMPLOYEES
GROUP BY JOB_ID;

-- 2�� �̻��� �׷�ȭ
SELECT DEPARTMENT_ID, JOB_ID, SUM(SALARY), AVG(SALARY), COUNT(SALARY)
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID, JOB_ID
ORDER BY DEPARTMENT_ID;

-- GROUP BY �Լ��� WHERE ������ ������ �� ����.
--SELECT DEPARTMENT_ID,
--       SUM(SALARY)
--FROM EMPLOYEES
--WHERE SUM(SALARY) >= 5000
--GROUP BY DEPARTMENT_ID;

--------------------------------------------------------------------------------
-- HAVING : GROUP BY�� ����
SELECT DEPARTMENT_ID,
       SUM(SALARY),
       AVG(SALARY)
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID
HAVING SUM(SALARY) >= 5000 -- �׷�ȭ�� ����� ���� ����
ORDER BY SUM(SALARY) DESC;

SELECT JOB_ID,
       COUNT(*)
FROM EMPLOYEES
GROUP BY JOB_ID
HAVING COUNT(*) >= 20; -- �׷�ȭ�� ����� ���� ����

-- �μ����̵� 50�̻��� ROW�����͸� �μ����� �׷�ȭ ��Ű��, ��ձ޿��� ���(��ձ޿��� 5000�̻�)
SELECT DEPARTMENT_ID,
       TRUNC(AVG(SALARY))
FROM EMPLOYEES
WHERE DEPARTMENT_ID >= 50
GROUP BY DEPARTMENT_ID
HAVING AVG(SALARY) >= 5000
ORDER BY AVG(SALARY);

--------------------------------------------------------------------------------
-- GRUOP BY �Ѿ�, ť��, �׷���
SELECT DEPARTMENT_ID, JOB_ID, COUNT(*), SUM(SALARY)
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID, JOB_ID
ORDER BY DEPARTMENT_ID;

SELECT DEPARTMENT_ID, JOB_ID, COUNT(*), SUM(SALARY)
FROM EMPLOYEES
GROUP BY ROLLUP(DEPARTMENT_ID, JOB_ID)
ORDER BY DEPARTMENT_ID;

-- ROLLUP �׷��� �Ѱ� (�Ѱ� ���)
SELECT DEPARTMENT_ID,  
       SUM(SALARY)
FROM EMPLOYEES
GROUP BY ROLLUP(DEPARTMENT_ID)
ORDER BY DEPARTMENT_ID;

-- CUBE
-- �� �׷캰 �Ұ踦 ���, + ���� �׷��� �Ұ踦 ǥ��
SELECT DEPARTMENT_ID, JOB_ID, SUM(SALARY)
FROM EMPLOYEES
GROUP BY CUBE(DEPARTMENT_ID, JOB_ID)
ORDER BY DEPARTMENT_ID;

-- GROUPING(Į��)
-- GROUP BY�� ���� ����Ǹ� 0, �հ� OR �Ұ��̸� 1 ��ȯ
SELECT DEPARTMENT_ID,
       DECODE(GROUPING(JOB_ID), 1, '�Ұ�', JOB_ID),
       SUM(SALARY),
       TRUNC(AVG(SALARY)),
       COUNT(*),
       GROUPING(DEPARTMENT_ID),
       GROUPING(JOB_ID)
FROM EMPLOYEES
GROUP BY ROLLUP(DEPARTMENT_ID, JOB_ID)
ORDER BY DEPARTMENT_ID;

--------------------------------------------------------------------------------
-- ��������
--���� 1.
--��� ���̺��� JOB_ID�� ��� ���� ���ϼ���.
--��� ���̺��� JOB_ID�� ������ ����� ���ϼ���. ������ ��� ������ �������� �����ϼ���.
SELECT JOB_ID,
       COUNT(*) AS �����,
       AVG(SALARY) AS ���������
FROM EMPLOYEES
GROUP BY JOB_ID
ORDER BY AVG(SALARY) DESC;

--���� 2.
--��� ���̺��� �Ի� �⵵ �� ��� ���� ���ϼ���.
SELECT SUBSTR(HIRE_DATE, 1, 2) || '�⵵' AS �Ի�⵵,
       COUNT(*) AS �����
FROM EMPLOYEES
GROUP BY SUBSTR(HIRE_DATE, 1, 2);

SELECT TO_CHAR(HIRE_DATE, 'YYYY"�⵵"') AS �Ի�⵵,
       COUNT(*) AS �����
FROM EMPLOYEES
GROUP BY TO_CHAR(HIRE_DATE, 'YYYY"�⵵"');

--���� 3.
--�޿��� 1000 �̻��� ������� �μ��� ��� �޿��� ����ϼ���. 
--��, �μ� ��� �޿��� 2000�̻��� �μ��� ���
SELECT DEPARTMENT_ID,
       AVG(SALARY)
FROM EMPLOYEES
WHERE SALARY >= 1000
GROUP BY DEPARTMENT_ID
HAVING AVG(SALARY) >= 2000;

--���� 4.
--��� ���̺��� commission_pct(Ŀ�̼�) �÷��� null�� �ƴ� �������
--department_id(�μ���) salary(����)�� ���, �հ�, count�� ���մϴ�.
--���� 1) ������ �հ�, ����� Ŀ�̼��� �����Ų �����Դϴ�.
--���� 2) ����� �Ҽ� 2° �ڸ����� ���� �ϼ���.
SELECT DEPARTMENT_ID, 
       TRUNC(AVG(SALARY * COMMISSION_PCT + SALARY), 2) AS AVG,
       SUM(SALARY * COMMISSION_PCT + SALARY)AS SUM ,
       COUNT(*)
FROM EMPLOYEES
WHERE COMMISSION_PCT IS NOT NULL
GROUP BY DEPARTMENT_ID;

--���� 5.
--������ ������, ���հ踦 ����ϼ���.
SELECT DECODE(GROUPING(JOB_ID), 1, '�հ�', JOB_ID),
       SUM(SALARY)
--       GROUPING(JOB_ID)
FROM EMPLOYEES
GROUP BY ROLLUP(JOB_ID);

SELECT JOB_ID, SUM(SALARY) FROM EMPLOYEES GROUP BY JOB_ID
UNION ALL
SELECT '�հ�', SUM(SALARY) FROM EMPLOYEES;

--���� 6.
--�μ���, JOB_ID�� �׷��� �Ͽ� ��Ż, �հ踦 ����ϼ���.
--GROUPING() �� �̿��Ͽ� �Ұ� �հ踦 ǥ���ϼ���.
SELECT DECODE(GROUPING(DEPARTMENT_ID), 1, '�հ�', DEPARTMENT_ID) AS DEPARTMENT_ID,
       DECODE(GROUPING(JOB_ID), 1, '�Ұ�', JOB_ID) AS JOB_ID,
       COUNT(*) AS TOTAL,
       SUM(SALARY) AS SUM
--       GROUPING(DEPARTMENT_ID),
--       GROUPING(JOB_ID)
FROM EMPLOYEES
GROUP BY ROLLUP(DEPARTMENT_ID, JOB_ID)
ORDER BY SUM;