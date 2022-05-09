-- LOWER() - 소문자로 변경, UPPER() - 대문자로 변경, INITCAP() - 첫 글자만 대문자로 변경
SELECT LOWER('ABC'), UPPER('abc'), INITCAP('abcdef') FROM DUAL;
SELECT LAST_NAME, LOWER(LAST_NAME), UPPER(LAST_NAME), INITCAP(LAST_NAME) FROM EMPLOYEES;
-- 함수는 WHERE조건에도 적용 가능
SELECT * FROM EMPLOYEES WHERE LOWER(FIRST_NAME) = 'jack';

-- LENGTH() - 문자열 길이, INSTR() - 특정문자 위치찾기
SELECT LENGTH('abcdef') AS LEN, INSTR('abcedf', 'e') FROM DUAL;
SELECT FIRST_NAME, 
       LENGTH(FIRST_NAME),
       INSTR(FIRST_NAME, 'a')
FROM EMPLOYEES;

-- SUBSTR() - 문자열 자르기, CONCAT() - 문자열 합치기
SELECT SUBSTR('abcdef', 1, 3), SUBSTR('abcdef', 3), CONCAT('abc', 'def') FROM DUAL;
SELECT FIRST_NAME,
       SUBSTR(FIRST_NAME, 1, 3) 추출,
       SUBSTR(FIRST_NAME, 3) 앞부분절삭,
       CONCAT(FIRST_NAME || ' ', LAST_NAME) 풀네임
FROM EMPLOYEES;

-- LPAD(칼럼, 공간, 채울문자), RPAD(칼럼, 공간, 채울문자)
SELECT LPAD('ABC', 5, '*') AS L, RPAD('ABC', 5, '*')AS R FROM DUAL;
SELECT FIRST_NAME,
       LPAD(FIRST_NAME, 10, '-') AS L,
       RPAD(FIRST_NAME, 10, '-') AS R
FROM EMPLOYEES;

-- LTRIM() - 왼쪽부터 문자제거, RTRIM() - 오른쪽부터 문자제거, TRIM - 공백제거
SELECT LTRIM(' JAVASCRIPT_JAVA') FROM DUAL; -- 왼쪽 공백제거
SELECT LTRIM('JAVASCRIPT_JAVA', 'JAVA') FROM DUAL; -- 왼쪽 문자제거
SELECT RTRIM('JAVASCRIPT_JAVA', 'JAVA') FROM DUAL; -- 오른쪽 문자제거
SELECT TRIM('    JAVA    ') FROM DUAL; -- 양측 공백제거

-- REPLACE() - 문자열 변경
SELECT REPLACE('MY DREAM IS PRESIDENT', 'PRESIDENT', 'DOCTOR') FROM DUAL;
SELECT REPLACE('MY DREAM IS PRESIENT', ' ', '') FROM DUAL;
-- 함수의 중첩
SELECT REPLACE(REPLACE('MY DREAM IS PRESIDENT', 'PRESIDENT', 'DOCTOR'), ' ', '') FROM DUAL;

----------------------------------------------------------

--문제 1.
--EMPLOYEES 테이블 에서 이름, 입사일자 컬럼으로 변경해서 이름순으로 오름차순 출력 합니다.
--조건 1) 이름 컬럼은 first_name, last_name을 붙여서 출력합니다.
--조건 2) 입사일자 컬럼은 xx/xx/xx로 저장되어 있습니다. xxxxxx형태로 변경해서 출력합니다.
SELECT CONCAT(FIRST_NAME || ' ', LAST_NAME) AS FULL_NAME, 
       REPLACE(HIRE_DATE, '/', '') AS HIRE_DATE
FROM EMPLOYEES 
ORDER BY FULL_NAME ASC;

--문제 2.
--EMPLOYEES 테이블 에서 phone_number컬럼은 ###.###.####형태로 저장되어 있다
--여기서 처음 세 자리 숫자 대신 서울 지역변호 (02)를 붙여 전화 번호를 출력하도록 쿼리를 작성하세요
SELECT REPLACE(PHONE_NUMBER, SUBSTR(PHONE_NUMBER,1,3),'(02)') FROM EMPLOYEES;
SELECT CONCAT('(02)', SUBSTR(PHONE_NUMBER,4,LENGTH(PHONE_NUMBER))) FROM EMPLOYEES;

--문제 3. 
--EMPLOYEES 테이블에서 JOB_ID가 it_prog인 사원의 이름(first_name)과 급여(salary)를 출력하세요.
--조건 1) 비교하기 위한 값은 소문자로 입력해야 합니다.(힌트 : lower 이용)
--조건 2) 이름은 앞 3문자까지 출력하고 나머지는 *로 출력합니다. 
       --이 열의 열 별칭은 name입니다.(힌트 : rpad와 substr 또는 substr 그리고 length 이용)
--조건 3) 급여는 전체 10자리로 출력하되 나머지 자리는 *로 출력합니다. 
--이 열의 열 별칭은 salary입니다.(힌트 : lpad 이용)
SELECT RPAD(SUBSTR(FIRST_NAME, 1, 3), LENGTH(FIRST_NAME), '*') AS name, 
       LPAD(SALARY, 10, '*') AS salary 
FROM EMPLOYEES 
WHERE LOWER(JOB_ID) = 'it_prog';
