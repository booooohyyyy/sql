-- XEPDB1 -> SYS�������� ����

SELECT * FROM ALL_USERS;
SELECT * FROM HR.EMPLOYEES;

-- ���ο� ���� ����
CREATE USER USER01 IDENTIFIED BY USER01; -- ID,PASSWORD: USER01
CREATE USER COM03 IDENTIFIED BY COM03;
DROP USER COM03 CASCADE;

-- ���� �ο�
GRANT CREATE SESSION, CREATE TABLE, CREATE VIEW, CREATE SEQUENCE, CREATE PROCEDURE TO USER01;

-- ���̺����̽� ����� ���
-- ������ -> DBA�� ���� -> ���̺����̽� ��Ŭ�� -> ���� 

-- ���� ����� ���
-- PDB�� ���� -> �ٸ� ����� ��Ŭ�� -> ���� -> ������, ���̺����̽�, �� �ο�

-- ���̺� �����̽� ����
ALTER USER USER01 DEFAULT TABLESPACE USERS QUOTA UNLIMITED ON USERS;

-- ���� ����
DROP USER USER01 CASCADE; -- USER01�� ������� ���̺�, ������ ��� �����۾��� ����.