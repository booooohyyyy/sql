-- LOWER() - �ҹ��ڷ� ����, UPPER() - �빮�ڷ� ����, INITCAP() - ù ���ڸ� �빮�ڷ� ����
SELECT LOWER('ABC'), UPPER('abc'), INITCAP('abcdef') FROM DUAL;
SELECT LAST_NAME, LOWER(LAST_NAME), UPPER(LAST_NAME), INITCAP(LAST_NAME) FROM EMPLOYEES;
-- �Լ��� WHERE���ǿ��� ���� ����
SELECT * FROM EMPLOYEES WHERE LOWER(FIRST_NAME) = 'jack';

-- LENGTH() - ���ڿ� ����, INSTR() - Ư������ ��ġã��
SELECT LENGTH('abcdef') AS LEN, INSTR('abcedf', 'e') FROM DUAL;
SELECT FIRST_NAME, 
       LENGTH(FIRST_NAME),
       INSTR(FIRST_NAME, 'a')
FROM EMPLOYEES;

-- SUBSTR() - ���ڿ� �ڸ���, CONCAT() - ���ڿ� ��ġ��
SELECT SUBSTR('abcdef', 1, 3), SUBSTR('abcdef', 3), CONCAT('abc', 'def') FROM DUAL;
SELECT FIRST_NAME,
       SUBSTR(FIRST_NAME, 1, 3) ����,
       SUBSTR(FIRST_NAME, 3) �պκ�����,
       CONCAT(FIRST_NAME || ' ', LAST_NAME) Ǯ����
FROM EMPLOYEES;

-- LPAD(Į��, ����, ä�﹮��), RPAD(Į��, ����, ä�﹮��)
SELECT LPAD('ABC', 5, '*') AS L, RPAD('ABC', 5, '*')AS R FROM DUAL;
SELECT FIRST_NAME,
       LPAD(FIRST_NAME, 10, '-') AS L,
       RPAD(FIRST_NAME, 10, '-') AS R
FROM EMPLOYEES;

-- LTRIM() - ���ʺ��� ��������, RTRIM() - �����ʺ��� ��������, TRIM - ��������
SELECT LTRIM(' JAVASCRIPT_JAVA') FROM DUAL; -- ���� ��������
SELECT LTRIM('JAVASCRIPT_JAVA', 'JAVA') FROM DUAL; -- ���� ��������
SELECT RTRIM('JAVASCRIPT_JAVA', 'JAVA') FROM DUAL; -- ������ ��������
SELECT TRIM('    JAVA    ') FROM DUAL; -- ���� ��������

-- REPLACE() - ���ڿ� ����
SELECT REPLACE('MY DREAM IS PRESIDENT', 'PRESIDENT', 'DOCTOR') FROM DUAL;
SELECT REPLACE('MY DREAM IS PRESIENT', ' ', '') FROM DUAL;
-- �Լ��� ��ø
SELECT REPLACE(REPLACE('MY DREAM IS PRESIDENT', 'PRESIDENT', 'DOCTOR'), ' ', '') FROM DUAL;

----------------------------------------------------------

--���� 1.
--EMPLOYEES ���̺� ���� �̸�, �Ի����� �÷����� �����ؼ� �̸������� �������� ��� �մϴ�.
--���� 1) �̸� �÷��� first_name, last_name�� �ٿ��� ����մϴ�.
--���� 2) �Ի����� �÷��� xx/xx/xx�� ����Ǿ� �ֽ��ϴ�. xxxxxx���·� �����ؼ� ����մϴ�.
SELECT CONCAT(FIRST_NAME || ' ', LAST_NAME) AS FULL_NAME, 
       REPLACE(HIRE_DATE, '/', '') AS HIRE_DATE
FROM EMPLOYEES 
ORDER BY FULL_NAME ASC;

--���� 2.
--EMPLOYEES ���̺� ���� phone_number�÷��� ###.###.####���·� ����Ǿ� �ִ�
--���⼭ ó�� �� �ڸ� ���� ��� ���� ������ȣ (02)�� �ٿ� ��ȭ ��ȣ�� ����ϵ��� ������ �ۼ��ϼ���
SELECT REPLACE(PHONE_NUMBER, SUBSTR(PHONE_NUMBER,1,3),'(02)') FROM EMPLOYEES;
SELECT CONCAT('(02)', SUBSTR(PHONE_NUMBER,4,LENGTH(PHONE_NUMBER))) FROM EMPLOYEES;

--���� 3. 
--EMPLOYEES ���̺��� JOB_ID�� it_prog�� ����� �̸�(first_name)�� �޿�(salary)�� ����ϼ���.
--���� 1) ���ϱ� ���� ���� �ҹ��ڷ� �Է��ؾ� �մϴ�.(��Ʈ : lower �̿�)
--���� 2) �̸��� �� 3���ڱ��� ����ϰ� �������� *�� ����մϴ�. 
       --�� ���� �� ��Ī�� name�Դϴ�.(��Ʈ : rpad�� substr �Ǵ� substr �׸��� length �̿�)
--���� 3) �޿��� ��ü 10�ڸ��� ����ϵ� ������ �ڸ��� *�� ����մϴ�. 
--�� ���� �� ��Ī�� salary�Դϴ�.(��Ʈ : lpad �̿�)
SELECT RPAD(SUBSTR(FIRST_NAME, 1, 3), LENGTH(FIRST_NAME), '*') AS name, 
       LPAD(SALARY, 10, '*') AS salary 
FROM EMPLOYEES 
WHERE LOWER(JOB_ID) = 'it_prog';
