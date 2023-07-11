select * from user_tables;

-- 주석
-- ctrl + / 
--create 명령어 - DDL 데이터 정의어
create user c##scott identified by tiger;
drop user c##scott;
--21g xe 버전,"_ORACLE_SCRIPT"=true; 셋 해줘야함.
alter session set "_ORACLE_SCRIPT"=true;
create user kh identified by kh;
create user scott identified by tiger;
--상태: 실패 -테스트 실패: ORA-01017: 사용자명/비밀번호가 부적합, 로그온할 수 없습니다.
--상태: 실패 -테스트 실패: ORA-01045: 사용자 SCOTT는 CREATE SESSION 권한을 가지고있지 않음; 로그온이 거절되었습니다

--DCL
--create sessoin, create table 처럼 각각의 권한명을 모두 나열하여 적기 어려움..
--권한들을 묶어서 만들어둔 롤 role 을 사용하여 권한을 부여함.
--connect 접속관련 권한들이 있는 role
--connect 자원(table, view등 객체)관련 권한들이 있는 role
grant connect, resource to c##scott, kh;
revoke connect, resource from kh;
grant connect, resource to scott, kh;

--21g xe 버전, dba 추가
grant connect, resource, dba to scott, kh;

--20번 부서를 제외한 사원 중 comm이 널이 아닌 사원 정보를 조회
select*
    from emp
    where not deptno = 20
--        and comm is not null
--오류        comm = null      and not comm = null
; 

select *
    from emp
    where mgr is null
        and comm is not null
;

-- 20 부서와 30 부서원들의 이름, 부서코드 급여 조회
-- in 
select ename, deptno, sal
    from emp
    where deptno in(20, 30)
    --deptno = 20 and or deptno = 30
    ;

--ANALYST 또는 SALESMAN 인 사원 중 급여를 2500보다 많이 받는 직원의 이름, 급여, job 조회
select ename, sal, job
    from emp
    where job in('ANALYST', 'SALESMAN')
        and sal >= 2500
        ;
-- 사원명의 길이와 byte크기를 조회
select length(ename), length(ename)
    from emp
    ;

--select 'a안녕b', length('a안녕b'), lengthb('a안녕b')
select trim ('a안 녕b', 'a'), length (trim('a안 녕b')), lengthb(trim('a안 녕b'))
   -- from emp
   from dual 
   -- 테이블 dual은 임시테이블로 연산이나 간단한 함수 결과값을 조회할 때 사용함.
;

--사원명의 시작부분 S와 끝나는 부분 S 모두 제거해주세요.
select  Rtrim (Ltrim(ename,'S'), 'S') from emp;
--Ltrim 예시 010 제거

--Lpad / Rpad 채워넣기 ename이 10글자가 되도록 왼쪽에 'S' 채워넣기 
select Lpad(ename, 10, 'S') from emp;

select Lpad(ename, 10) from emp;

--문자(칼럼) 이어붙이기.
select concat(ename, comm) from emp;
select ename || comm from emp;
select sal || '달러' from emp;
select concat(sal, '달러') from emp;
-- substr 엄청 중요!!
-- replace
select replace (ename, 'AM', 'X') from emp;

SELECT MAX(SAL) 평균급여 FROM EMP; 
SELECT AVG(SAL)  AVG FROM EMP; 
SELECT SUM(SAL) SUM FROM EMP; 
SELECT MIN(SAL) MIN FROM EMP; 
--부서별 평균 급여 조회 
SELECT MAX(SAL) 평균급여, DEPTNO FROM EMP GROUP BY DEPTNO; 
SELECT AVG(SAL) AVG, DEPTNO FROM EMP GROUP BY DEPTNO ; 
SELECT SUM(SAL) SUM, DEPTNO FROM EMP GROUP BY DEPTNO; 
SELECT MIN(SAL)  MIN, DEPTNO FROM EMP GROUP BY DEPTNO;
--JOB이 ANALYST인 직원의 평균 급여 조회
SELECT AVG(SAL) 평균급여
    --오류 , JOB 
    FROM EMP
    WHERE JOB= 'ANALYST'
    ;
    SELECT AVG(SAL) 평균급여, JOB
    FROM EMP
    GROUP BY JOB
    HAVING JOB= 'ANALYST'
    ;
--JOB이 ANALYST인 부서별 직원의 평균 급여 조회
SELECT JOB, DEPTNO, AVG(SAL) 
--ENAME
FROM EMP
WHERE JOB ='CLERK'
GROUP BY DEPTNO, JOB
;
SELECT * FROM EMP
    ORDER BY SAL DESC, ENAME ASC
;
SELECT SAL, SAL*12 + NVL(COMM,0) SALCOMM
    FROM EMP
    ORDER BY SALCOMM DESC, ENAME ASC
    ;
--JOB 오름차순
SELECT * FROM EMP
    ORDER BY 3;
--EMPLOYEE 에서 부서코드, 그룹 별 급여의 합계, 그룹 별 급여의 평균, 인원 수를 조회하고 부서 코드 순으로 정렬
SELECT  AVG(SAL), SUM(SAL)
    FROM EMP
    GROUP BY DEPTNO
;

---사원명, 부서번호, 부서명, 부서위치를 조회
SELECT EMPLOYEE.EMP_NAME, EMPLOYEE.DEPT_CODE, DEPT_NAME,
    FROM EMPLOYEE
;

SELECT * FROM DEPT;
SELECT * FROM EMP;
SELECT *
    FROM EMP
        JOIN DEPT ON EMP.DEPTNO = DEPT.DEPTNO
        ;

SELECT EMP.ENAME, EMP.DEPTNO, DEPT.DNAME, DEPT.LOC
    FROM EMP
        JOIN DEPT ON EMP.DEPTNO = DEPT.DEPTNO
;


