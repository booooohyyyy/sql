-- ������ (���������� �����ϴ� �� - PK�� ���� ���)
SELECT * FROM USER_SEQUENCES;

-- ������ ����
--CREATE SEQUENCE DEPT3_SEQ; -- �ڵ�����
CREATE SEQUENCE DEPT3_SEQ
    INCREMENT BY 1
    START WITH 1
    MAXVALUE 10
    NOCACHE -- ĳ�ð����� ���X
    NOCYCLE; -- ����Ŭ ���X
    
-- ������ ����
DROP SEQUENCE DEPT3_SEQ;

-- ������ ���̺�
CREATE TABLE DEPT3 (
    DEPT_NO NUMBER(2),
    DEPT_NAME VARCHAR(20),
    LOCA VARCHAR2(20),
    DEPT_DATE DATE
);
ALTER TABLE DEPT3 ADD CONSTRAINT DEPT3_PK PRIMARY KEY (DEPT_NO); -- PK

DESC DEPT3;

-- �������� ��� (NEXTVAL, CURRVAL)
SELECT DEPT3_SEQ.CURRVAL FROM DUAL; -- NEXTVAL �ѹ� ����� ���Ŀ� ��� ����

-- MAXVALUE�� 10�̱� ������ 10�ʰ��ؼ� �������� �ʴ´�.
INSERT INTO DEPT3(DEPT_NO, DEPT_NAME, LOCA, DEPT_DATE)
VALUES (DEPT3_SEQ.NEXTVAL, 'TEST', 'TEST', SYSDATE);

SELECT * FROM DEPT3;

-- ������ ���� (���� ������ ����)
ALTER SEQUENCE DEPT3_SEQ MAXVALUE 9999; -- MAX�� ����
ALTER SEQUENCE DEPT3_SEQ INCREMENT BY 10; -- ������ ����
ALTER SEQUENCE DEPT3_SEQ MINVALUE 1; -- MIN�� ����

-- �������� ���̺��� ���ǰ� �ִ� ����� �������� DROP�ϸ� �ȵȴ�.
-- ������ �ʱ�ȭ
-- 1. ���� ������ Ȯ��
SELECT DEPT3_SEQ.CURRVAL FROM DUAL;
-- 2. �������� -���������
ALTER SEQUENCE DEPT3_SEQ INCREMENT BY -59;
-- 3. NEXTVAL�� ������� ó�� �������� �̵�
SELECT DEPT3_SEQ.NEXTVAL FROM DUAL;
-- 4. �������� �ٽ� +1�� ����
ALTER SEQUENCE DEPT3_SEQ INCREMENT BY 1;
-- ���Ŀ� NEXTVAL�� 2���� ����..

-- ������ ����� ����
-- PK���� VARCHAR2�� �����ϰ� 202201��������) ���·� ���

CREATE TABLE DEPT4(
    DEPT_NO VARCHAR2(30),
    DEPT_NAME VARCHAR2(30)
);
ALTER TABLE DEPT4 ADD CONSTRAINT DEPT4_PK PRIMARY KEY (DEPT_NO);
-- DPET4_SEQ���� �����ϰ�
CREATE SEQUENCE DEPT4_SEQ
    INCREMENT BY 1
    START WITH 1
    MAXVALUE 31
    MINVALUE 1
    NOCACHE
    NOCYCLE;
-- LPAD('��', '�ƽ�����', 'ä�ﰪ')�� �̿��ؼ� PK�� �����ϴ� ���� (���OOOO������)���·� INSERT
INSERT INTO DEPT4 (DEPT_NO, DEPT_NAME)
VALUES (TO_CHAR(SYSDATE, 'YYMM')||LPAD(DEPT4_SEQ.NEXTVAL, 6, 'O'), 'TEST');

SELECT * FROM DEPT4;
COMMIT;

--------------------------------------------------------------------------------
-- INDEX
-- INDEX�� PK, UNIQUE�� �ڵ����� �����ǰ� , ��ȸ�� ������ �ϴ� HINT ������ ��
-- INDEX�����δ� ����, ����� �ε����� �ִ�.
-- ���� �ε����� ����ũ�� �÷��� ����Ǵ� �ε����� �ǹ�
-- �Ϲ� �÷��� �ε����� �����Ϸ��� UNIQUE���� �����ϰ� ����

SELECT * FROM EMPS_IT WHERE FIRST_NAME = 'Nancy';

-- �ε��� ���� (�÷��� ����� ��밡��)
CREATE /*UNIQUE*/ INDEX EMPS_IT_IDX
ON EMPS_IT(FIRST_NAME);

-- �ε��� ���� (���̺� ū ���� ��ġ���� ����)
DROP INDEX EMPS_IT_IDX;

-- �ε��� ����(���� �ε���)
-- ù���� ����� �÷����� ��ȸ -> �ι�° ����� �÷����� ��ȸ
CREATE INDEX EMPS_NAME_INDX
ON EMPS_IT(FIRST_NAME, LAST_NAME);

SELECT * FROM EMPS_IT WHERE FIRST_NAME = 'Nancy';
SELECT * FROM EMPS_IT WHERE FIRST_NAME = 'Nancy' AND LAST_NAME = 'Greenberg';

-- SELECT���� INDEX������� ��Ʈ�� �ִ� ���
CREATE TABLE TBL_BOARD(
    BNO NUMBER(10),
    WRITER VARCHAR(20)
);
ALTER TABLE TBL_BOARD ADD CONSTRAINT TBL_BOARD_PK PRIMARY KEY(BNO);
CREATE SEQUENCE TBL_BOARD_SEQ NOCACHE;

INSERT INTO TBL_BOARD VALUES (TBL_BOARD_SEQ.NEXTVAL, 'TEST1');
INSERT INTO TBL_BOARD VALUES (TBL_BOARD_SEQ.NEXTVAL, 'TEST2');
INSERT INTO TBL_BOARD VALUES (TBL_BOARD_SEQ.NEXTVAL, 'TEST3');
INSERT INTO TBL_BOARD VALUES (TBL_BOARD_SEQ.NEXTVAL, 'TEST4');
INSERT INTO TBL_BOARD VALUES (TBL_BOARD_SEQ.NEXTVAL, 'TEST5');
INSERT INTO TBL_BOARD VALUES (TBL_BOARD_SEQ.NEXTVAL, 'TEST6');
INSERT INTO TBL_BOARD VALUES (TBL_BOARD_SEQ.NEXTVAL, 'TEST7');
COMMIT;
SELECT * FROM TBL_BOARD;

--
SELECT *
FROM (SELECT ROWNUM AS RN,
             A.*
      FROM (SELECT *
            FROM TBL_BOARD
            ORDER BY BNO DESC) A
)
WHERE RN BETWEEN 11 AND 20;
--
SELECT *
FROM (SELECT /* +INDEX_DESC(TBL_BOARD_IDX) */
             ROWNUM RN,
             BNO,
             WRITER
      FROM TBL_BOARD
      ORDER BY BNO DESC
)
WHERE RN BETWEEN 11 AND 20;
