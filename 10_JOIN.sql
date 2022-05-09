-------------------------���ο� ���� ������ �ǽ�-------------------------
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

-- �÷� ���� ���
-- ������ Ű �÷��� ���� ����ϸ�, ��ȣ�ϴ� ������ ����. ( = Ű �÷��� ���̺� �̸��� �ٿ��� ó��)
SELECT ID, TITLE, CONTENT, REGDATE,
       INFO.AUTH_ID,
       NAME,
       JOB
FROM INFO
JOIN AUTH ON INFO.AUTH_ID = AUTH.AUTH_ID;

-- ����� ���
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

-- CROSS JOIN (���� ����Z) - ī��þ� ���ε�Ʈ
SELECT *
FROM INFO I
CROSS JOIN AUTH A;

-- USING ���� �̿��� INNER����
SELECT *
FROM INFO I
JOIN AUTH A
USING (AUTH_ID);

-- ������ ���� �� ��밡��
SELECT *
FROM EMPLOYEES E
LEFT OUTER JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
LEFT OUTER JOIN LOCATIONS L ON D.LOCATION_ID =  L.LOCATION_ID;

