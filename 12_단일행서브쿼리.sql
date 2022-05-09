-- 서브 쿼리 ********
-- 서브쿼리란 SELECT문 안에 SELECT문이 들어가는 것
-- 서브쿼리는 반드시 () 묶는다, 조건절 오른쪽에 기술한다.

-- 단일행 서브쿼리 - SELECT의 조회결과가 1행 이하인 쿼리
SELECT SALARY
FROM EMPLOYEES
WHERE FIRST_NAME = 'Nancy';

SELECT *
FROM EMPLOYEES
WHERE SALARY >= (SELECT SALARY
                 FROM EMPLOYEES
                 WHERE FIRST_NAME = 'Nancy');
                 
-- EMPLOYEE_ID가 103번인 사람과 직업이 같은 사람
SELECT *
FROM EMPLOYEES
WHERE JOB_ID = (SELECT JOB_ID
                     FROM EMPLOYEES
                     WHERE EMPLOYEE_ID = 103);
                     
-- EMPLOYEE_ID 107번인 사람과 부서가 같은 사람들
SELECT *
FROM EMPLOYEES
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID
                       FROM EMPLOYEES
                       WHERE EMPLOYEE_ID = 107);
                       
--------------------------------
-- 단일 행 서브쿼리의 결과가 여러개 라면 사용할 수 없음
-- 이런 경우는 다중 행 서브쿼리를 이용해서 처리
SELECT EMPLOYEE_ID
FROM EMPLOYEES
WHERE JOB_ID = 'IT_PROG';

SELECT *
FROM EMPLOYEES
WHERE EMPLOYEE_ID = (SELECT EMPLOYEE_ID
                     FROM EMPLOYEES
                     WHERE JOB_ID = 'IT_PROG');


