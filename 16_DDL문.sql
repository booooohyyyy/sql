-- DDL문 
-- CREATE문

CREATE TABLE DEPT2 (
    DEPT_NO     NUMBER(2), -- 자리수
    DEPT_NAME   VARCHAR2(20), -- 가변문자 (20BYTE, 한글 10글자/영어 20글자)
    DEPT_YN     CHAR(1),    -- 고정문자 1BYTE
    DEPT_DATE   DATE,
    DEPT_BONUS  NUMBER(10,3) -- 10자리, 소수부 3자리
);

DESC DEPT2;
INSERT INTO DEPT2 VALUES(99, '영업', 'Y', SYSDATE, 3.14);
INSERT INTO DEPT2 VALUES(100, '회계', 'Y', SYSDATE, 14.123); -- 자리수 문제

SELECT * FROM DEPT2;
COMMIT;

--------------------------------------------------------------------------------
-- ALTER

-- 열 추가
ALTER TABLE DEPT2
ADD (DEPT_COUNT NUMBER(3));

-- 열 이름 변경
ALTER TABLE DEPT2
RENAME COLUMN DEPT_COUNT TO EMP_COUNT;

DESC DEPT2;

-- 열 타입 수정
ALTER TABLE DEPT2
MODIFY (EMP_COUNT NUMBER(10));

DESC DEPT2;

-- 열 삭제
ALTER TABLE DEPT2
DROP COLUMN EMP_COUNT;

DESC DEPT2;

--------------------------------------------------------------------------------
-- 테이블 삭제 (삭제 후에는 복구 불가)
DROP TABLE DEPT2;
-- DROP TABLE DEPT2 CASCADE CONSTRAINTS 제약조건명