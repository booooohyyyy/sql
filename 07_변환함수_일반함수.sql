-- NVL, NVL2
SELECT FIRST_NAME, COMMISSION_PCT * SALARY FROM EMPLOYEES; -- NULL�� ������ ����Ǿ NULL

-- NVL(Į��, NULL ó��)
SELECT NVL(NULL, 'NULL�Դϴ�') FROM DUAL;
SELECT FIRST_NAME, NVL(COMMISSION_PCT, 0) AS COMMISSION_PCT FROM EMPLOYEES;
SELECT FIRST_NAME, NVL(COMMISSION_PCT, 0) + SALARY AS COMMISSION_PCT FROM EMPLOYEES;

-- NVL(Į��, NULL�� �ƴ� ��� ó��, NULL ó��)
SELECT NVL2(NULL, 'NULL�� �ƴ�', 'NULL��'),
       NVL2(4412, 'NULL�� �ƴ�', 'NULL��')
FROM DUAL;

SELECT FIRST_NAME, NVL2(COMMISSION_PCT, 'FALSE', 'TRUE') FROM EMPLOYEES;
SELECT FIRST_NAME,
       SALARY,
       COMMISSION_PCT,
       NVL2(COMMISSION_PCT, COMMISSION_PCT * SALARY + SALARY, SALARY) AS sal 
FROM EMPLOYEES;

-- DECODE(Į��, �񱳰�, ����� .......)
SELECT DECODE('C', 'A', 'A�Դϴ�',
                   'B', 'B�Դϴ�',
                   'C', 'C�Դϴ�',
                   'A~C�� �ƴմϴ�')
FROM DUAL;

SELECT FIRST_NAME,
       JOB_ID,
       DECODE(JOB_ID, 'IT_PROG',    SALARY * 1.1,
                      'FI_MGR',    SALARY * 1,2,
                      'FI_ACCOUNT', SALARY * 1.3,
                      'AD_VP',      SALARY * 1.4,
                                    SALARY) AS result
FROM EMPLOYEES;

-- CASE �÷� WHEN �񱳰� THEN ��� END
SELECT FIRST_NAME,
       JOB_ID,
       SALARY,
       CASE JOB_ID  WHEN 'IT_PROG'  THEN SALARY * 1.1
                    WHEN 'FI_MGR'  THEN SALARY * 1.2
                    WHEN 'FI_ACCOUNT'  THEN SALARY * 1.3
                    WHEN 'AD_VP'  THEN SALARY * 1.4
                    ELSE SALARY
       END AS result
FROM EMPLOYEES;
-- 2ND (������ ��, ���δٸ� Į���� ���밡��)
SELECT FIRST_NAME,
       JOB_ID,
       SALARY,
       CASE  WHEN JOB_ID = 'IT_PROG'  THEN SALARY * 1.1
             WHEN JOB_ID = 'FI_MGR'  THEN SALARY * 1.2
             WHEN JOB_ID = 'FI_ACCOUNT'  THEN SALARY * 1.3
             WHEN JOB_ID = 'AD_VP'  THEN SALARY * 1.4
             ELSE SALARY
       END AS result
FROM EMPLOYEES;

--��������-------------------------------------------------
--���� 1.
--�������ڸ� �������� EMPLOYEE���̺��� �Ի�����(hire_date)�� �����ؼ� �ټӳ���� 10�� �̻���
--����� ������ ���� ������ ����� ����ϵ��� ������ �ۼ��� ������. 
SELECT EMPLOYEE_ID AS �����ȣ,
       FIRST_NAME || ' ' || LAST_NAME AS �����,
       HIRE_DATE AS �Ի�����,
       TRUNC((SYSDATE - HIRE_DATE)/365) AS �ټӳ��
FROM EMPLOYEES
WHERE TRUNC((SYSDATE - HIRE_DATE)/365) >= 10
ORDER BY �ټӳ�� DESC;

--���� 2.
--EMPLOYEE ���̺��� manager_id�÷��� Ȯ���Ͽ� first_name, manager_id, ������ ����մϴ�.
--100�̶�� �������,
--120�̶�� �����ӡ�
--121�̶�� ���븮��
--122��� �����塯
--�������� ���ӿ��� ���� ����մϴ�.
--���� 1) DIPARTMENT_ID�� 50�� ������� ������θ� ��ȸ�մϴ�
SELECT FIRST_NAME, MANAGER_ID, 
  CASE MANAGER_ID WHEN 100    THEN '���'
                  WHEN 120    THEN '����'
                  WHEN 121    THEN '�븮'
                  WHEN 122    THEN '����'
                  ELSE '�ӿ�'
   END AS ����
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 50;

SELECT FIRST_NAME, MANAGER_ID, 
  CASE WHEN MANAGER_ID = 100    THEN '���'
       WHEN MANAGER_ID = 120    THEN '����'
       WHEN MANAGER_ID = 121    THEN '�븮'
       WHEN MANAGER_ID = 122    THEN '����'
       ELSE '�ӿ�'
   END AS ����
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 50;

SELECT FIRST_NAME, MANAGER_ID,
       DECODE(MANAGER_ID,   100,    '���',
                            120,    '����',
                            121,    '�븮',
                            122,    '����',
                                    '�ӿ�') AS ����
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 50;
                                    
