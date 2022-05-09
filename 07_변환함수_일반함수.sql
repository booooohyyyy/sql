-- NVL, NVL2
SELECT FIRST_NAME, COMMISSION_PCT * SALARY FROM EMPLOYEES; -- NULL에 연산이 진행되어도 NULL

-- NVL(칼럼, NULL 처리)
SELECT NVL(NULL, 'NULL입니다') FROM DUAL;
SELECT FIRST_NAME, NVL(COMMISSION_PCT, 0) AS COMMISSION_PCT FROM EMPLOYEES;
SELECT FIRST_NAME, NVL(COMMISSION_PCT, 0) + SALARY AS COMMISSION_PCT FROM EMPLOYEES;

-- NVL(칼럼, NULL이 아닌 경우 처리, NULL 처리)
SELECT NVL2(NULL, 'NULL이 아님', 'NULL임'),
       NVL2(4412, 'NULL이 아님', 'NULL임')
FROM DUAL;

SELECT FIRST_NAME, NVL2(COMMISSION_PCT, 'FALSE', 'TRUE') FROM EMPLOYEES;
SELECT FIRST_NAME,
       SALARY,
       COMMISSION_PCT,
       NVL2(COMMISSION_PCT, COMMISSION_PCT * SALARY + SALARY, SALARY) AS sal 
FROM EMPLOYEES;

-- DECODE(칼럼, 비교값, 결과값 .......)
SELECT DECODE('C', 'A', 'A입니다',
                   'B', 'B입니다',
                   'C', 'C입니다',
                   'A~C가 아닙니다')
FROM DUAL;

SELECT FIRST_NAME,
       JOB_ID,
       DECODE(JOB_ID, 'IT_PROG',    SALARY * 1.1,
                      'FI_MGR',    SALARY * 1,2,
                      'FI_ACCOUNT', SALARY * 1.3,
                      'AD_VP',      SALARY * 1.4,
                                    SALARY) AS result
FROM EMPLOYEES;

-- CASE 컬럼 WHEN 비교값 THEN 결과 END
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
-- 2ND (조건의 비교, 서로다른 칼럼도 적용가능)
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

--연습문제-------------------------------------------------
--문제 1.
--현재일자를 기준으로 EMPLOYEE테이블의 입사일자(hire_date)를 참조해서 근속년수가 10년 이상인
--사원을 다음과 같은 형태의 결과를 출력하도록 쿼리를 작성해 보세요. 
SELECT EMPLOYEE_ID AS 사원번호,
       FIRST_NAME || ' ' || LAST_NAME AS 사원명,
       HIRE_DATE AS 입사일자,
       TRUNC((SYSDATE - HIRE_DATE)/365) AS 근속년수
FROM EMPLOYEES
WHERE TRUNC((SYSDATE - HIRE_DATE)/365) >= 10
ORDER BY 근속년수 DESC;

--문제 2.
--EMPLOYEE 테이블의 manager_id컬럼을 확인하여 first_name, manager_id, 직급을 출력합니다.
--100이라면 ‘사원’,
--120이라면 ‘주임’
--121이라면 ‘대리’
--122라면 ‘과장’
--나머지는 ‘임원’ 으로 출력합니다.
--조건 1) DIPARTMENT_ID가 50인 사람들을 대상으로만 조회합니다
SELECT FIRST_NAME, MANAGER_ID, 
  CASE MANAGER_ID WHEN 100    THEN '사원'
                  WHEN 120    THEN '주임'
                  WHEN 121    THEN '대리'
                  WHEN 122    THEN '과장'
                  ELSE '임원'
   END AS 직급
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 50;

SELECT FIRST_NAME, MANAGER_ID, 
  CASE WHEN MANAGER_ID = 100    THEN '사원'
       WHEN MANAGER_ID = 120    THEN '주임'
       WHEN MANAGER_ID = 121    THEN '대리'
       WHEN MANAGER_ID = 122    THEN '과장'
       ELSE '임원'
   END AS 직급
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 50;

SELECT FIRST_NAME, MANAGER_ID,
       DECODE(MANAGER_ID,   100,    '사원',
                            120,    '주임',
                            121,    '대리',
                            122,    '과장',
                                    '임원') AS 직급
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 50;
                                    
