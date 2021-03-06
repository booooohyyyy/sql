-------------------------조인에 대한 간단한 실습-------------------------
--CREATE TABLE INFO (
--  ID NUMBER(10, 0) NOT NULL PRIMARY KEY
--, TITLE VARCHAR2(50 BYTE) 
--, CONTENT VARCHAR2(50 BYTE) 
--, REGDATE DATE DEFAULT SYSDATE 
--, AUTH_ID NUMBER(10, 0) 
--);
--
--CREATE TABLE INFO (
--      ID NUMBER(10, 0) NOT NULL PRIMARY KEY
--    , TITLE VARCHAR2(50 BYTE) 
--    , CONTENT VARCHAR2(50 BYTE) 
--    , REGDATE DATE DEFAULT SYSDATE 
--    , USER_ID NUMBER(10, 0)
--);

--------------------------------------------------------------------------------

SELECT * FROM INFO;
SELECT * FROM AUTH;

-- INNER JOIN
SELECT * FROM INFO JOIN AUTH ON INFO.AUTH_ID = AUTH.AUTH_ID;

-- 컬럼 지정 출력
-- 양측의 키 컬럼을 직접 기술하면, 모호하다 에러가 나옴. ( = 키 컬럼에 테이블 이름을 붙여서 처리)
SELECT ID, TITLE, CONTENT, REGDATE,
       INFO.AUTH_ID,
       NAME,
       JOB
FROM INFO
JOIN AUTH ON INFO.AUTH_ID = AUTH.AUTH_ID;

-- 엘리어스 사용
SELECT I.*,
       A.NAME,
       A.JOB
FROM INFO I
JOIN AUTH A ON I.AUTH_ID = A.AUTH_ID;

-- WHERE
SELECT I.*,
       A.NAME,
       A.JOB
FROM INFO I
JOIN AUTH A ON I.AUTH_ID = A.AUTH_ID
WHERE I.ID IN(1,2,3);

-- LEFT OUTER JOIN
SELECT I.*,
       A.NAME,
       A.JOB
FROM INFO I
LEFT OUTER JOIN AUTH A ON I.AUTH_ID = A.AUTH_ID;

-- RIGHT OUTER JOIN
SELECT *
FROM INFO I
RIGHT OUTER JOIN AUTH A ON I.AUTH_ID = A.AUTH_ID;

-- FULL OUTER JOIN
SELECT *
FROM INFO I
FULL OUTER JOIN AUTH A ON I.AUTH_ID = A.AUTH_ID;

-- CROSS JOIN (조인 조건Z) - 카디시안 프로딕트
SELECT *
FROM INFO I
CROSS JOIN AUTH A;

-- USING 절을 이용한 INNER조인
SELECT *
FROM INFO I
JOIN AUTH A
USING (AUTH_ID);

-- 조인은 여러 개 사용가능
SELECT *
FROM EMPLOYEES E
LEFT OUTER JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
LEFT OUTER JOIN LOCATIONS L ON D.LOCATION_ID =  L.LOCATION_ID;


