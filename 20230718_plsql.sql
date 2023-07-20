SET SERVEROUTPUT ON; 
SET SERVEROUTPUT OFF; 
BEGIN 
    DBMS_OUTPUT.PUT_LINE('HELLO WORLD');
    DBMS_OUTPUT.PUT_LINE('HELLO WORLD2');
    DBMS_OUTPUT.PUT('HELLO WORLD3');
    DBMS_OUTPUT.PUT('HELLO WORLD4');
    DBMS_OUTPUT.PUT_LINE();
END;
/
DECLARE
    EMP_ID NUMBER;
    EMP_NAME VARCHAR2(30);
BEGIN
    EMP_ID := 888;
    EMP_NAME :='배장남';
    DBMS_OUTPUT.PUT_LINE('EMP_ID :' || EMP_ID);
    DBMS_OUTPUT.PUT_LINE('EMP_NAME : '||EMP_NAME);
END;
/
DECLARE
    EMP_ID EMPLOYEE.EMP_ID%TYPE;
    EMP_NAME EMPLOYEE.EMP_NAME%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME
    INTO EMP_ID, EMP_NAME
    FROM EMPLOYEE
    WHERE EMP_ID = '&EMP_ID';
    DBMS_OUTPUT.PUT_LINE('EMP_ID: ' || EMP_ID);
    DBMS_OUTPUT.PUT_LINE('EMP_NAME: '|| EMP_NAME);
END;
/
CREATE OR REPLACE PROCEDURE PRO_DEPT_INSERT
--DECLARE
IS
    MAXDNO DEPT.DEPTNO%TYPE;
    DNO DEPT.DEPTNO%TYPE;
BEGIN
SELECT MAX(DEPTNO) INTO MAXDNO FROM DEPT;
    insert  into DEPT (dname, DEPTNO, LOC) values ('EJ5', maxDNO+1, '서울');
    INSERT into DEPT (dname, DEPTNO, LOC) values ('EJ5', maxDNO+2, '서울');
    COMMIT;
END;
/
DECLARE
    E EMPLOYEE%ROWTYPE;
BEGIN 
    SELECT * INTO E
    FROM EMPLOYEE
    WHERE EMP_ID = '&EMP_ID';
    DBMS_OUTPUT.PUT_LINE('EMP_ID: '|| E.EMP_ID);
    DBMS_OUTPUT.PUT_LINE('EMP_NAME: '|| E.EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('EMP_NO: '|| E.EMP_NO);
    DBMS_OUTPUT.PUT_LINE('SALARY: '|| E.SALARY);
END;
/
DECLARE
TYPE EMP_ID_TABLE_TYPE IS TABLE OF EMPLOYEE.EMP_ID%TYPE
INDEX BY BINARY_INTEGER;
TYPE EMP_NAME_TABLE_TYPE IS TABLE OF EMPLOYEE.EMP_NAME%TYPE INDEX BY BINARY_INTEGER;

BEGIN

EMP_ID_TABLE EMP_ID_TABLE_TYPE; 
EMP_NAME_TABLE EMP_NAME_TABLE_TYPE;

I BINARY_INTEGER := 0;

FOR K IN (SELECT EMP_ID, EMP_NAME FROM EMPLOYEE) LOOP I := I + 1;

EMP_ID_TABLE(I) := K.EMP_ID;

EMP_NAME_TABLE(I) := K.EMP_NAME; END LOOP;

FOR J IN 1..I LOOP
DBMS_OUTPUT.PUT_LINE('EMP_ID : ' || EMP_ID_TABLE(J) || ',

EMP_NAME : ' || EMP_NAME_TABLE(J));

END LOOP; END;

/
DECLARE
    TYPE EMP_RECODE_TYPE IS RECORD(
        EMP_ID EMPLOYEE.EMP_ID%TYPE,
        EMP_NAME EMPLOYEE.EMP_NAME%TYPE,
        DEPT_TITLE DEPARTMENT/DEPT_TITLE%TYPE,
        JOB_NAME JOB.JOB_NAME%TYPE
        );
        EMP_RECORD EMP_RECORD_TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME,DEPT_TITLE,JOB_NAME INTO EMP_RECORD
    FROM EMPLOYEE E, DEPARTMENT D, JOB J
    WHERE E.DEPT_CODE = D.DEPT_ID
        AND E.JOB_CODE = J.JOB_CODE
        AND EMP_NAME = '&EMP_NAME'
    DBMS_OUTPUT.PUT_LINE('사번 :'|| EMP_ID);
    DBMS_OUTPUT.PUT_LINE('이름 :'|| EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('급여 :'|| SALARY);
    
    IF(BONUS = 0)
        THEN DBMS_OUTPUT.PUT_LINE('보너스를 지급받지 않는 사원입니다.');
    END IF;
    DBMS_OUTPUT.PUT_LINE('보너스율 : '||BONUS * 100|| '%');
END;
/
BEGIN 
    FOR N IN 1..5 LOOP
        DBMS_OUTPUT.PUT_LINE(N);
        END LOOP;
END;
/
DECLARE
    N NUMBER := 1;
BEGIN   
       WHILE N <= 5 LOOP
           DBMS_OUTPUT.PUT_LINE(N);
           N := N +1;
       END LOOP;
END;
/
DECLARE
    DUP_EMPNO EXCEPTION;
    PRAGMA EXCEPTION_INIT(DUP_EMPNO,-00001);
BEGIN
    UPDATE EMPLOYEE
    SET EMP_ID = '&사번'
    WHERE EMP_ID = 200;
EXCEPTION
    WHEN DUP_EMPNO   THEN 
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      DBMS_OUTPUT.PUT_LINE('이미 존재하는 사번입니다.');
END;
/
SELECT * FROM USER_SOURCE;

--PROCEDURE만들기
--사원번호를 전달받아서 이름, 급여, 업무를 반환함.
CREATE OR REPLACE PROCEDURE PRO_EMP_ARG_TEST
        ( ARG_EMPNO EMP.EMPNO%TYPE, ARG_ENAME OUT EMP.ENAME%TYPE )
IS
BEGIN
    DBMS_OUTPUT.PUT_LINE('ARG_EMPNO: ' || ARG_EMPNO);
    ARG_ENAME := '아무거나 리턴되나 확인';
    --PROCEDURE 는 RETURN 없음 대신 매개변수에 IN OUT을 설정해서 OUT로 설정하면 리턴
    --FUNCTION에는 리턴이 있음
END;
/
VARIABLE VAR_EMP_NAME VARCHAR2(30);

CREATE OR REPLACE PROCEDURE PRO_ALL_EMP
IS
BEGIN
    FOR E IN (SELECT EMP_ID FROM EMPLOYEE) LOOP
    END LOOP;
END;
/