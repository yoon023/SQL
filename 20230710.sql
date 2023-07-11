select * from DEPARTMENT;
select * from EMPLOYEE;
select * from JOB;
select * from LOCATION;
select * from NATIONAL;
select * from SAL_GRADE;


-- SYSDATE는 함수 아니나 명령어가 실행되는 시점에 결과값을 출력해주므로 함수호출과 같이 동작함.
SELECT SYSDATE FROM DUAL;
SELECT HIREDATE FROM EMP;

--2023.07.10
SELECT SYSDATE, TO_CHAR(SYSDATE, 'YYY.MM.DD (DY) HH24:MI:SS') FROM DUAL;
SELECT SYSDATE, TO_CHAR(SYSDATE, 'YYY.MM.DD (Day) HH24:MI:SS') FROM DUAL;

ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS'; 
SELECT SYSDATE FROM DUAL;
SELECT * FROM EMP;

--YEAR 2023 MONTH 09 DAY 11 HOUR 13
SELECT ADD_MONTHS(TO_DATE('2023091113', 'YYYYMMDDHH24'), 5) FROM DUAL;
SELECT NEXT_DAY(TO_DATE('2023091113', 'YYYYMMDDHH24'), '수') FROM DUAL;
SELECT ADD_MONTHS(TO_DATE('2023091113', 'YYYYMMDDHH24'), 4) FROM DUAL;
--1:일요일, 2:월요일, 3:수요일 ...
SELECT LAST_DAY(TO_DATE('2023091113', 'YYYYMMDDHH24')) FROM DUAL;
SELECT LAST_DAY('2023091113', 4) FROM DUAL;

-- 오류 SELECT LAST_DAY('2023091113', 4) FROM DUAL;

SELECT TO_CHAR(EMPNO, '000000'), '$'||TRIM(TO_CHAR(SAL, '999,999,999,999'))
    FROM EMP;
SELECT TO_CHAR(EMPNO, '000000'), TRIM(TO_CHAR(SAL, 'L999,999,999,999'))
    FROM EMP;

SELECT TO_NUMBER ('123,4567,8901', '999,9999,9999')*5 FROM DUAL;
--오류 SELECT '123,4567,8901'*5 FROM DUAL;



-- 결과값 1로 시작 1234... 
SELECT EMAIL, INSTR(EMAIL, '@', 2)위치
    FROM EMPLOYEE
;
-- email 은 @ 이후에 . 1개 이상 있어야 함.
SELECT EMAIL, INSTR(EMAIL, '@'),INSTR(EMAIL, '.', INSTR(EMAIL, '@')) 위치
    FROM EMPLOYEE
    WHERE INSTR(EMAIL, '.', INSTR(EMAIL, '@')) <> 0
;

--
select INSTR('AORACLEWELCOME', 'O', 2)
    from dual 
;
select INSTR('AORACLEWELCOME', 'O', 1, 2)
    from dual 
;
select INSTR('AORACLEWELCOMEOKEY', 'O', 1, 3)
    from dual 
;
select INSTR('AORACLEWELCOMEOKEY', 'O', 3, 2)
    from dual 
;
select INSTR('AORACLEWELCOMEOKEY', 'O', 3, 3)
    from dual 
;





--급여를 3500000보다 많이 받고 6000000보다 적게 받는 직원 이름과 급여 조회
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
WHERE SALARY >= 3500000 AND SALARY <= 6000000;

--'전'씨 성을 가진 직원 이름과 급여 조회
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
WHERE EMP_NAME LIKE '전%';

--핸드폰의 앞 네 자리 중 첫 번호가 7인 직원 이름과 전화번호 조회
SELECT EMP_NAME, PHONE
FROM EMPLOYEE
WHERE PHONE LIKE'___7%'
;

SELECT * FROM EMP;

--EMAIL ID 중 '_'의 앞이 3자리인 직원 이름, 이메일 조회



--'이'씨 성이 아닌 직원 사번, 이름, 이메일 조회

--관리자도 없고 부서 배치도 받지 않은 직원 조회

--부서 배치를 받지 않았지만 보너스를 지급받는 직원 조회

--D6 부서와 D8 부서원들의 이름, 부서코드, 급여 조회

--'J2' 또는 'J7' 직급 코드 중 급여를 2000000보다 많이 받는 직원의 이름, 급여, 직급코드 조회

--사원들의 남, 여 성별과 함께 이름과 주민번호 모든 정보를 조회
SELECT EMP_NAME, EMP_NO, 
        DECODE(SUBSTR(EMP_NO, 8, 1), 1, '남' , '여')
        AS "성 별"
    FROM EMPLOYEE
    ;
SELECT EMP_NAME, EMP_NO, 
        CASE
            WHEN SUBSTR(EMP_NO, 8, 1) = 2 THEN '여'
             WHEN SUBSTR(EMP_NO, 8, 1) = 1 THEN '남'
              WHEN SUBSTR(EMP_NO, 8, 1) = 4 THEN '여'
               WHEN SUBSTR(EMP_NO, 8, 1) = 3 THEN '남'
               ELSE '그 외'
        END
        AS "성 별"
    FROM EMPLOYEE
    ;
SELECT EMP_NAME, EMP_NO, 
        CASE SUBSTR(EMP_NO, 8, 1)
            WHEN  '2' THEN '여'
             WHEN  '1' THEN '남'
              WHEN  '4' THEN '여'
               WHEN  '3' THEN '남'
               ELSE '그 외'
        END
        AS "성 별"
    FROM EMPLOYEE
    ;
    SELECT EMP_NAME, EMP_NO, 
        CASE TO_NUMBER(SUBSTR(EMP_NO, 8, 1))
            WHEN  2 THEN '여'
             WHEN  1 THEN '남'
              WHEN  4 THEN '여'
               WHEN  3 THEN '남'
               ELSE '그 외'
        END
        AS "성 별"
    FROM EMPLOYEE
    ;
  
--JAVA, JS 삼항연산자 
--STRING A = (SUBSTR(EMP_NO, 8, 1) == 2? '여' : '남');
--IF(SUBSTR(EMP_NO, 8, 1) == 2){
--    RETURN "여";
--}ELSE IF(SUBSTR(EMP_NO, 8, 1) == 4){
--    RETURN "여";
--}ELSE IF(SUBSTR(EMP_NO, 8, 1) == 1){
--    RETURN "남";
--}ELSE IF(SUBSTR(EMP_NO, 8, 1) == 3){
--    RETURN "남";
--}ELSE{
--    RETURN "그 외";
--}



SELECT SUBSTR(EMP_NO, 8, 3) FROM EMPLOYEE;

-- 직원들의 평균 급여는 얼마인지 조회
SELECT * FROM EMP;

SELECT FLOOR(AVG(SALARY)) 평균급여 FROM EMPLOYEE;
SELECT ROUND(AVG(SALARY)) 평균급여 FROM EMPLOYEE;
SELECT CEIL(AVG(SALARY)) 평균급여 FROM EMPLOYEE;
SELECT TRUNK(AVG(SALARY),4) 평균급여 FROM EMPLOYEE;

SELECT COUNT(DISTINCT DEPT_CODE) FROM EMPLOYEE;
SELECT COUNT(DEPT_CODE) FROM EMPLOYEE;
SELECT COUNT(*) FROM EMPLOYEE;

SELECT * --COUNT(*)
    FROM EMPLOYEE
    WHERE DEPT_CODE IS NULL;
    
-- COUNT 는 RESULTSET의 결과물에서 ROW 값이 NULL이라면 카운트 하지 않는다.
--COUNT (*) ROW 개수 
SELECT COUNT(DEPT_CODE), COUNT(BONUS), COUNT(EMP_ID), COUNT(MANAGER_ID), COUNT(*)
    FROM EMPLOYEE
    WHERE DEPT_CODE IS NULL;
SELECT  COUNT(DEPT_CODE), COUNT(DISTINCT DEPT_CODE)
    FROM EMPLOYEE;




