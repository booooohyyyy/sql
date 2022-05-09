-- ���
-- ���ǹ� : IF, �ݺ���: WHILE, FOR, Ż�⹮: EXIT

SET SERVEROUTPUT ON;

-- �������� ����ϴ� ���
DECLARE
    V_NUM NUMBER := DBMS_RANDOM.VALUE(); -- 0~1�̸� �����Ǽ�
    RAN NUMBER := ROUND(DBMS_RANDOM.VALUE(0, 10)); -- 0~10���� ��������
BEGIN
    DBMS_OUTPUT.PUT_LINE(V_NUM);
    DBMS_OUTPUT.PUT_LINE(RAN);
END;

-- IF�� (IF ~ END IF)
-- PL/SQL���� ������ ��Ÿ���� ������ END
DECLARE
    NUM1 NUMBER := 5;
    NUM2 NUMBER := ROUND(DBMS_RANDOM.VALUE(0, 10));
BEGIN
--    IF NUM1 >= NUM2 THEN
--        DBMS_OUTPUT.PUT_LINE(NUM1 || '�� ū �� �Դϴ�.');
--    END IF;
    IF NUM1 >= NUM2 THEN
        DBMS_OUTPUT.PUT_LINE(NUM1 || '�� ū �� �Դϴ�.');
    ELSE
        DBMS_OUTPUT.PUT_LINE(NUM2 || '�� ū �� �Դϴ�.');
    END IF;

END;

-- IF ~ ELSIF THEN
DECLARE
    RAN NUMBER := ROUND(DBMS_RANDOM.VALUE(0, 100));
BEGIN
    DBMS_OUTPUT.PUT_LINE('����: ' || RAN);
    
    IF RAN >= 90 THEN
        DBMS_OUTPUT.PUT_LINE('A����');
    ELSIF RAN >= 80 THEN
        DBMS_OUTPUT.PUT_LINE('B����');
    ELSIF RAN >= 70 THEN
        DBMS_OUTPUT.PUT_LINE('C����');
    ELSE
        DBMS_OUTPUT.PUT_LINE('D����');
    END IF;
END;

--------------------------------------------------------------------------------
-- IF�� �ǽ� (EMPLOYEES ���̺�)
-- ù��° ���� ROWNUM�� �̿��ϸ� ��
-- 10~120������ �ʴ��� ������ ��ȣ�� �̿��ؼ� ���� DEPARTMENT_ID�� ù��° �ุ SELECT
-- ���� ����� SALARY�� 9000�̻��̸� ����, 5000�̻��̸� �߰�, �������� �������� ���
SELECT ROUND(DBMS_RANDOM.VALUE(10, 120), -1) FROM DUAL;

DECLARE
    RAN NUMBER := ROUND(DBMS_RANDOM.VALUE(10, 120), -1);
    EMP_SALARY EMPLOYEES.SALARY%TYPE;
BEGIN
    
    SELECT SALARY
    INTO EMP_SALARY
    FROM EMPLOYEES 
    WHERE DEPARTMENT_ID = RAN AND ROWNUM = 1;
    
    DBMS_OUTPUT.PUT_LINE(EMP_SALARY);
    
    IF EMP_SALARY >= 9000 THEN
        DBMS_OUTPUT.PUT_LINE('����');
    ELSIF EMP_SALARY >= 5000 THEN
        DBMS_OUTPUT.PUT_LINE('�߰�');
    ELSE
        DBMS_OUTPUT.PUT_LINE('����');
    END IF;
END;
