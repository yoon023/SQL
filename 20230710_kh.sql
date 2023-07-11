select * from  EMPLOYEE;
select * from  DEPARTMENT;
select * from  JOB;
select * from  LOCATION;
select * from  NATIONAL;
select * from  SAL_GRADE;

select emp_name, length(emp_name) len, lengthb(emp_name) byteLen
    from employee
    ;
select * from employee where emp_name = '방_명수';

--
--ORA-00911: 문자가 부적합합니다
--00911. 00000 -  "invalid character"
--SELECT EMAIL, INSTR(EMAIL, '@', -1, 1) 위치
--SELECT EMAIL, INSTR(EMAIL, '@') 위치
-- instr - 1부터시작
SELECT EMAIL, INSTR(EMAIL, '@', 2) 위치
    FROM EMPLOYEE
;
-- email 은 @ 이후에 . 1개 이상있어야 함.
SELECT EMAIL, INSTR(EMAIL, '@'), INSTR(EMAIL, '.', INSTR(EMAIL, '@')) 위치
    FROM EMPLOYEE
    where INSTR(EMAIL, '.', INSTR(EMAIL, '@')) <> 0
;
--
select INSTR('AORACLEWELCOME', 'O', 1)   from dual;
select INSTR('AORACLEWELCOME', 'O', 1, 2)    from dual;
select INSTR('AORACLEWELCOMEOKEY', 'O', 1, 3)    from dual;
select INSTR('AORACLEWELCOMEOKEY', 'O', 3)   from dual;
select INSTR('AORACLEWELCOMEOKEY', 'O', 3, 2)    from dual;
select INSTR('AORACLEWELCOMEOKEY', 'O', 3, 3)    from dual;

-- 급여를 3500000보다 많이 받고 6000000보다 적게 받는 직원이름과 급여 조회
-- ‘전’씨 성을 가진 직원 이름과 급여 조회
-- 핸드폰의 앞 네 자리 중 첫 번호가 7인 직원 이름과 전화번호 조회
-- EMAIL ID 중 ‘_’의 앞이 3자리인 직원 이름, 이메일 조회
-- like '__*_' escape '*'
-- ‘이’씨 성이 아닌 직원 사번, 이름, 이메일 조회
-- 관리자도 없고 부서 배치도 받지 않은 직원 조회
-- 부서 배치를 받지 않았지만 보너스를 지급받는 직원 조회
-- D6 부서와 D8 부서원들의 이름, 부서코드, 급여 조회
-- ‘J2’ 또는 ‘J7’ 직급 코드 중 급여를 2000000보다 많이 받는 직원의 이름, 급여, 직급코드 조회

-- 모든 사원들의 남, 여 성별과 함께 이름과 주민번호
select emp_name, emp_no, 
        decode(substr(emp_no, 8,1), 2, '여', 4, '여', 1, '남', 3, '남', '그외')
        as "성 별"
    from employee
;
select emp_name, emp_no, 
        case
            when substr(emp_no, 8,1) = 2 then '여'
            when substr(emp_no, 8,1) > 1 then '남'
            when substr(emp_no, 8,1) > 4 then '여'
            when substr(emp_no, 8,1) > 3 then '남'
            else '그외'
        end
        as "성 별"
    from employee
;
select emp_name, emp_no, 
        case substr(emp_no, 8,1)
            when '2' then '여'
            when '1' then '남'
            when '4' then '여'
            when '3' then '남'
            else '그외'
        end
        as "성 별"
    from employee
;
select emp_name, emp_no, 
--ORA-00932: 일관성 없는 데이터 유형: CHAR이(가) 필요하지만 NUMBER임
--00932. 00000 -  "inconsistent datatypes: expected %s got %s"
--ORA-00932: 일관성 없는 데이터 유형: NUMBER이(가) 필요하지만 CHAR임
--00932. 00000 -  "inconsistent datatypes: expected %s got %s"
        case to_number(substr(emp_no, 8,1))
            when 2 then '여'
            when 1 then '남'
            when 4 then '여'
            when 3 then '남'
            else '그외'
        end
        as "성 별"
    from employee
;
-- java, js 삼항연산자
-- string a = ( substr(emp_no, 8,1) == 2 ? "여" : "남";
--if(substr(emp_no, 8,1) == 2){
--    return "여";
--} else {
--    return "남";
--}
--if(substr(emp_no, 8,1) == 2){
--    return "여";
--} else if(substr(emp_no, 8,1) == 4) {
--    return "여";
--} else if(substr(emp_no, 8,1) == 1) {
--    return "남";
--} else if(substr(emp_no, 8,1) == 3) {
--    return "남";
--} else {
--    return "그외";
--}
--switch(substr(emp_no, 8,1)){
--    case 1:
--        return "남";
--    case 2:
--        return "여";
--    case 3:
--        return "남";
--    case 4:
--        return "여";
--    default:
--        return "그외";
--}



select substr(emp_no, 8,3) from employee;

-- 직원들의 평균 급여는 얼마인지 조회
select (avg(salary)) 평균급여 from employee;
select floor(avg(salary)) 평균급여 from employee;
select trunc(avg(salary), 4) 평균급여 from employee;
select round(avg(salary)) 평균급여 from employee;
select ceil(avg(salary)) 평균급여 from employee;

SELECT COUNT(DISTINCT DEPT_CODE) 
    FROM EMPLOYEE;
SELECT COUNT(DEPT_CODE) 
    FROM EMPLOYEE;  -- 21
SELECT COUNT(*) 
    FROM EMPLOYEE; -- 23
SELECT * --COUNT(*) 
    FROM EMPLOYEE 
    where dept_code is null;
-- count 는 resultset의 row값이 null 이면 count 되지 않음.
-- count(*) row 개수
SELECT COUNT(dept_code), count(bonus), count(emp_id), count(manager_id), count(*)
    FROM EMPLOYEE 
    where dept_code is null;
    
SELECT COUNT(DEPT_CODE), COUNT(distinct DEPT_CODE)
    FROM EMPLOYEE; 

SELECT DEPT_CODE    FROM EMPLOYEE; 
SELECT distinct DEPT_CODE    FROM EMPLOYEE; 

SELECT distinct DEPT_CODE    FROM EMPLOYEE
    order by dept_code asc
; 
select *
from EMPLOYEE E
    , DEPARTMENT D
    WHERE E.DEPT_CODE = D.DEPT_ID(+)
;

select *
from EMPLOYEE E
    RIGHT OUTER JOIN DEPARTMENT D ON E.DEPT_CODE = D.DEPT_ID
;
select *
from EMPLOYEE E
    , DEPARTMENT D
    WHERE  E.DEPT_CODE(+) = D.DEPT_ID
;
select *
from EMPLOYEE E
    FULL OUTER JOIN DEPARTMENT D ON E.DEPT_CODE = D.DEPT_ID
;
select emp_id,emp_name,job_code,salary
from employee
where salary >= (select avg(salary)from employee);

(select avg(salary)from employee);

--전 직원의 급여 평균보다 많은 급여를 받는 직원의 이름, 직급, 부서, 급여조회
select emp_name, job_code,dept_code,salary
from employee e
where salary >=(select avg(salary)from employee)
order by 2;

--부서별 최고 급여를 받는 직원의 이름, 직급, 부서, 급여 조회
select emp_name, job_code, dept_code, salary
from employee
where salary in(select max(salary) from employee group by dept_code)
order by 3;

select emp_name, job_code, dept_code, hire_date
from employee
where (dept_code, job_code) in (select dept_code, job_code 
from employee 
where substr(emp_no,8,1)=2 and ent_yn='y');

--직급별 최소 급여를 받는 직원의 사번, 이름, 직급, 급여 조회
select emp_id, emp_name, job_code, salary
from employee
where(job_code, salary) in (select job_code, min(salary)
from employee
group by job_code)
order by 3; 

--낮은번호부터 <=5 중에서 사원 이름 , 급여 내림차순 
select rownum, emp_name, salary
    from employee
    where rownum <=5 
order by salary desc;                                     

--인라인뷰
select rownum, emp_name, salary
    from(select*
        from employee
        order by salary desc)
    where rownum<=5;

