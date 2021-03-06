-- WHERE 조건절
SELECT * FROM EMPLOYEES WHERE EMPLOYEE_ID = 100; --PK
SELECT * FROM EMPLOYEES WHERE JOB_ID = 'IT_PRG';
SELECT * FROM EMPLOYEES WHERE DEPARTMENT_ID >= 90;
SELECT * FROM EMPLOYEES WHERE SALARY <= 15000;
SELECT FIRST_NAME, 
       LAST_NAME, 
       EMPLOYEE_ID, 
       HIRE_DATE
FROM EMPLOYEES
WHERE HIRE_DATE = '01/01/13'; -- 날짜도 문자열의 형태로 비교가능
SELECT * FROM EMPLOYEES WHERE HIRE_DATE <= '07/01/01'; -- 날짜 또한 비교연산이 가능

-- BETWEEN, IN, LIKE
SELECT * FROM EMPLOYEES WHERE SALARY BETWEEN 10000 AND 20000; -- 10000이상 20000이하
SELECT * FROM EMPLOYEES WHERE HIRE_DATE BETWEEN '01/01/01' AND '07/01/01'; -- 01/01/01~07/01/01

-- IN (포함되는 값)
SELECT * FROM EMPLOYEES WHERE EMPLOYEE_ID IN (101, 102, 103, 104);
SELECT * FROM EMPLOYEES WHERE JOB_ID IN ('AD_VP', 'IT_PROG');
SELECT * FROM EMPLOYEES WHERE DEPARTMENT_ID IN (60, 70, 80);

-- LIKE (검색에 자주 사용) %는 모든, _는 데이트의 위치를 찾아낼 때
SELECT * FROM EMPLOYEES WHERE HIRE_DATE LIKE '03%'; -- 03으로 시작하는
SELECT * FROM EMPLOYEES WHERE HIRE_DATE LIKE '%15'; -- 15로 끝나는
SELECT * FROM EMPLOYEES WHERE HIRE_DATE LIKE '%05%';
SELECT * FROM EMPLOYEES WHERE JOB_ID LIKE '%MAN%'; -- MAN이 들어있는 ROW
SELECT * FROM EMPLOYEES WHERE HIRE_DATE LIKE '___05%'; -- 4번째 자리가 05인 ROW
SELECT FIRST_NAME, 
       LAST_NAME, 
       EMPLOYEE_ID, 
       EMAIL 
FROM EMPLOYEES 
WHERE EMAIL LIKE '_A%'; -- A가 두번째

-- NULL 데이터의 확인 IS NULL, IS NOT NULL
-- SELECT FIRST_NAME, COMMISSION_PCT FROM EMPLOYEES WHERE COMMISSION_PCT = NULL;
SELECT FIRST_NAME, COMMISSION_PCT FROM EMPLOYEES WHERE COMMISSION_PCT IS NULL;
SELECT FIRST_NAME, COMMISSION_PCT FROM EMPLOYEES WHERE COMMISSION_PCT IS NOT NULL;
SELECT * FROM EMPLOYEES WHERE DEPARTMENT_ID IS NULL;

-- 다중 조건 AND, OR
-- AND가 OR보다 연산 우선순위가 빠르다
SELECT * FROM EMPLOYEES 
        WHERE JOB_ID = 'IT_PROG' 
           OR JOB_ID = 'FI_MGR' 
          AND SALARY >= 6000;
SELECT * FROM EMPLOYEES 
        WHERE (JOB_ID = 'IT_PROG' 
           OR JOB_ID = 'FI_MGR')
          AND SALARY >= 6000;
          
SELECT * FROM EMPLOYEES WHERE SALARY BETWEEN 15000 AND 20000;
SELECT * FROM EMPLOYEES WHERE SALARY >= 15000 AND SALARY <= 20000; -- 같은 표현

-- 데이터 정렬 ORDER BY (SELECT문의 가장 마지막)
SELECT * FROM EMPLOYEES ORDER BY HIRE_DATE DESC; -- 날짜기준 내림차순
SELECT * FROM EMPLOYEES ORDER BY HIRE_DATE ASC;  -- 날짜기준 오름차순
SELECT * FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG' ORDER BY FIRST_NAME;
SELECT * FROM EMPLOYEES WHERE SALARY BETWEEN 10000 AND 20000 ORDER BY SALARY DESC;
-- ORDER BY 조건은 2개 이상도 가능하다.
SELECT * FROM EMPLOYEES ORDER BY DEPARTMENT_ID DESC, FIRST_NAME ASC;
          
