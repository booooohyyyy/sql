-- DDL�� 
-- CREATE��

CREATE TABLE DEPT2 (
    DEPT_NO     NUMBER(2), -- �ڸ���
    DEPT_NAME   VARCHAR2(20), -- �������� (20BYTE, �ѱ� 10����/���� 20����)
    DEPT_YN     CHAR(1),    -- �������� 1BYTE
    DEPT_DATE   DATE,
    DEPT_BONUS  NUMBER(10,3) -- 10�ڸ�, �Ҽ��� 3�ڸ�
);

DESC DEPT2;
INSERT INTO DEPT2 VALUES(99, '����', 'Y', SYSDATE, 3.14);
INSERT INTO DEPT2 VALUES(100, 'ȸ��', 'Y', SYSDATE, 14.123); -- �ڸ��� ����

SELECT * FROM DEPT2;
COMMIT;

--------------------------------------------------------------------------------
-- ALTER

-- �� �߰�
ALTER TABLE DEPT2
ADD (DEPT_COUNT NUMBER(3));

-- �� �̸� ����
ALTER TABLE DEPT2
RENAME COLUMN DEPT_COUNT TO EMP_COUNT;

DESC DEPT2;

-- �� Ÿ�� ����
ALTER TABLE DEPT2
MODIFY (EMP_COUNT NUMBER(10));

DESC DEPT2;

-- �� ����
ALTER TABLE DEPT2
DROP COLUMN EMP_COUNT;

DESC DEPT2;

--------------------------------------------------------------------------------
-- ���̺� ���� (���� �Ŀ��� ���� �Ұ�)
DROP TABLE DEPT2;
-- DROP TABLE DEPT2 CASCADE CONSTRAINTS �������Ǹ�