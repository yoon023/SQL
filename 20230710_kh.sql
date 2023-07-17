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
-- 20230712
-- 16. EMPLOYEE테이블에서 사원명, 주민번호 조회 (단, 주민번호는 생년월일만 보이게하고, '-'다음 값은 '*'로 바꾸기)
select emp_id, emp_no, substr(emp_no, 1, 7), RPAD(substr(emp_no, 1, 7),14, '*')
    from employee
;
select * from employee;
select dept_code, job_code, manager_id , floor(avg(salary))
from employee
group by grouping sets((dept_code,job_code,manager_id),(dept_code,manager_id),(job_code,manager_id));

create table user_unique(
    user_no number,
    user_id varchar2(20) unique,
    user_pwd varchar2(30) not null,
    user_name varchar2(30),
    gender varchar2(10),
    phone varchar2(30),
    email varchar2(50)
    );
insert into user_unique values(1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@kh.or.kr');
--insert into user_unique values(1, 'user01', 'pass01', null, null, '010-1234-5678', 'hong123@kh.or.kr');
create table user_unique2(
    user_no number,
    user_id varchar2(20),
    user_pwd varchar2(30) not null,
    user_name varchar2(30),
    gender varchar2(10),
    phone varchar2(30),
    email varchar2(50),
    unique(user_id)
    );
--insert into user_unique2 values(1, 'user01', 'pass01', null, null, '010-1234-5678', 'hong123@kh.or.kr');   
insert into user_unique2 values(1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@kh.or.kr');
create table user_unique3(
    user_no number,
    user_id varchar2(20) unique,
    user_pwd varchar2(30) not null,
    user_name varchar2(30),
    gender varchar2(10),
    phone varchar2(30),
    email varchar2(50),
    unique(user_no,user_id)
    );
insert into user_unique3 values(1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@kh.or.kr');
--insert into user_unique3 values(2, 'user01', 'pass01', null, null, '010-1234-5678', 'hong123@kh.or.kr'); 
insert into user_unique3 values(2, 'user02', 'pass02', '홍길동', '남', '010-1234-5678', 'hong123@kh.or.kr');
--insert into user_unique3 values(1, 'user01', 'pass01', null, null, '010-1234-5678', 'hong123@kh.or.kr');
create table user_primarykey(
    user_no number primary key,
    user_id varchar2(20) unique,
    user_pwd varchar2(30) not null,
    user_name varchar(30),
    gender varchar2(10),
    phone varchar2(30),
    email varchar2(50)
    );
insert into user_primarykey values(1,'user01','pass01','홍길동','남','010-1234-5678','hong123@kh.or.kr');
--insert into user_primarykey values(1,'user02','pass02','이순신','남','010-5678-9012','lee123@kh.or.kr');
--insert into user_primarykey values(null,'user03','pass03','유관순','여','010-3131-3131','yoo123@kh.or.kr');
--오류 보고 -
--ORA-01400: NULL을 ("KH"."USER_PRIMARYKEY"."USER_NO") 안에 삽입할 수 없습니다

create table user_primarykey2(
    user_no number,
    user_id varchar2(20),
    user_pwd varchar2(30) not null,
    user_name varchar(30),
    gender varchar2(10),
    phone varchar2(30),
    email varchar2(50),
    primary key(user_no, user_id)
    );
insert into user_primarykey2 values(1,'user01','pass01','홍길동','남','010-1234-5678','hong123@kh.or.kr');
insert into user_primarykey2 values(1,'user02','pass02','이순신','남','010-5678-9012','lee123@kh.or.kr');
insert into user_primarykey2 values(2,'user01','pass01','유관순','여','010-3131-3131','yoo123@kh.or.kr');
--insert into user_primarykey2 values(1,'user01','pass01','신사임당','여','010-1111-1111','shin123@kh.or.kr');

create table user_grade(
    grade_code number primary key,
    grade_name varchar2(30) not null
    );
insert into user_grade values(10,'일반회원');
insert into user_grade values(20,'우수회원');
insert into user_grade values(30,'특별회원');
select * from user_grade;
create table user_foreignkey(
    user_no number primary key,
    user_id varchar2(20) unique,
    user_pwd varchar2(30) not null,
    user_name varchar2(30),
    gender varchar2(10),
    phone varchar2(30),
    email varchar2(50),
    grade_code number,
    foreign key(grade_code) references user_grade(grade_code)
);
insert into user_foreignkey values(1,'user01','pass01','홍길동','남','010-1234-5678','hong123@kh.or.kr',10);
insert into user_foreignkey values(2,'user02','pass02','이순신','남','010-5678-9012','lee123@kh.or.kr',20);
insert into user_foreignkey values(3,'user03','pass03','유관순','여','010-3131-3131','yoo123@kh.or.kr',30);

--20230713
--insert into emp (칼럼명1, 칼럼명2 ,...) values (값1, 값2 ,...);

insert into employee
values(1,'홍길동','820114-1010101','hong_kd@kh.or.kr','01099998888','D5','J2','S4',3800000,null,'200',sysdate,null,default);

update employee
set emp_id = 290
where emp_name = '홍길동';

delete from employee
where emp_name = '홍길동';

select *
from employee;

insert into employee
values(900,'장채현','901123-1080503','jang_ch@kh.or.kr','01055569512','D1','J8','S3',4300000,0.2,'200',sysdate,null,default);

create table emp_01( emp_id number, emp_name varchar2(30), dept_title varchar2(20));
insert into emp_01(
    select emp_id,
            emp_name,
            dept_title
            from employee
            left join department on (dept_code = dept_id) );
select * from emp_01;

--insert all
create table emp_dept_d1
as select emp_id, emp_name, dept_code, hire_date
    from employee
    where 1 = 0;
create table emp_manager
as select emp_id, emp_name, manager_id
    from employee
    where 1 = 0; -- 1<>1;
--where 1=1;모든 레코드 copy 
--where 1<>1; 레코드(행)은 copy 안함 



insert all
 into emp_dept_d1 values(emp_id, emp_name, dept_code, hire_date)
 into emp_manager values(emp_id, emp_name, manager_id)
    select emp_id, emp_name, dept_code, hire_date, manager_id
    from employee
    where dept_code = 'D1';
    
select * from employee;
select * from emp_dept_d1;
select * from emp_manager;

--insert all 2
create table emp_old
as select emp_id,
            emp_name,
            hire_date,
            salary
        from employee
        where 1 =0;
create table emp_new
as select emp_id,
            emp_name,
            hire_date,
            salary
        from employee
        where 1= 0;
-- EMPLOYEE테이블의 입사일 기준으로 2000년 1월 1일 이전에 입사한 사원의 사번,
--이름, 입사일, 급여를 조회해서 EMP_OLD테이블에 삽입하고
--그 후에 입사한 사원의 정보는 EMP_NEW테이블에 삽입
insert all
when hire_date < '2000/01/01' then
        into emp_old values(emp_id, emp_name, hire_date, salary)
when hire_date >= '2000/01/01' then
        into emp_new values(emp_id, emp_name, hire_date, salary)
select emp_id, emp_name, hire_date, salary
from employee;

select * from emp_old;
select * from emp_new;

--update WHERE 조건을 설정하지 않으면 모든 행의 컬럼 값이 변경됨
create table dept_copy
as select * from department;
update dept_copy
set dept_title = '전략기획팀'
where dept_id = 'D9';
select * from dept_copy;

--update2 방명수 사원의 급여와 보너스율을 유재식 사원과 동일하게 변경
create table emp_salary
as select emp_id,
        emp_name,
        dept_code,
        salary,
        bonus
    from employee;
update emp_salary
set salary = ( select salary
                from emp_salary
                where emp_name = '유재식'),
    bonus = ( select bonus
                from emp_salary
                where emp_name = '유재식')
    where emp_name = '방명수';
select * from emp_salary
where emp_name in ('유재식', '방명수');

--update3 - 각각 쿼리문 작성한 것을 다중 행 다중 열 서브쿼리로 변경
update emp_salary
 set(salary,bonus) = (select salary, bonus
                        from emp_salary
                        where emp_name = '유재식')
    where emp_name = '방명수';
    
select * from emp_salary
where emp_name in('유재식', '방명수');

--update4 - EMP_SALARY테이블에서 아시아 지역에 근무하는 직원의 보너스 포인트 0.3으로 변경
update emp_salary
 set bonus = 0.3
 where emp_id in ( select emp_id
                    from employee
                    join department on(dept_id = dept_code)
                    join location on(location_id = local_code)
                    where local_name like 'ASIA%');
select * from emp_salary;

--delete 테이블의 행을 삭제하는 구문으로 테이블의 행 개수가 줄어듦
delete from employee
where emp_name = '장채현';

delete from department
where dept_id = 'D1';

--delete foreign key
--delete from department 
--where dept_id = 'D1';
-- 비활성화
--alter table employee
--disable constraint emp_deptcode_fk cascade;
--활성화
--alter table employee
--enable constraint emp_deptcode_fk;

--Transaction 하나의 일처리 단위
--DDL 구조정의 - 명령어 실행시 commit 자동 발생함  

--trunkcate 모든 행 없앨 때 롤백 불가능 
truncate table emp_salary;
select * from emp_salary;

rollback; --복구안됨

--alter칼럼추가
alter table dept_copy
add(cname varchar2(20));

alter table dept_copy
add(lname varchar2(40) default '한국');

select * from dept_copy;

--alter 제약조건추가 따로따로 해야함 . constrain 이 객체여서 
ALTER TABLE DEPT_COPY
ADD CONSTRAINT DCOPY_DID_PK PRIMARY KEY(DEPT_ID);
ALTER TABLE DEPT_COPY
ADD CONSTRAINT DCOPY_DTITLE_UNQ UNIQUE(DEPT_TITLE);
ALTER TABLE DEPT_COPY
MODIFY LNAME CONSTRAINT DCOPY_LNAME_NN NOT NULL;

--alter 컬럼수정
alter table dept_copy
modify dept_id char(3)
modify dept_title varchar(30)
modify location_id varchar2(2)
modify cname char(20)
modify lname default '미국';

--alter 컬럼 삭제
alter table dept_copy
 drop column dept_id;

--alter 제약조건 삭제 
alter table dept_copy
drop constraint dcopy_did_pk
drop constraint dcopy_dtitle_unq
modify lname null;

--컬럼 이름 변경
alter table dept_copy
rename column dept_title to dept_name;

--제약조건 이름 변경
alter table user_foreignkey
rename constraint sys_c007211 to uf_up_nn;
--ORA-23292: 제약 조건이 존재하지 않음
--23292. 00000 -  "The constraint does not exist"
--*Cause:    The given constraint name does not exist.
--*Action:   Give an existing constraint's name.

--테이블 이름 변경
alter table dept_copy
rename to dept_test;

rename dept_
--view 1
create or replace view v_employee
as select emp_id, emp_name, dept_title, national_name
    from employee
    left join department on(dept_id = dept_code)
    left join location on(location_id = local_code)
    left join national using(national_code);
select * from v_employee;

--view 2
create or replace view v_emp_job(사번, 이름, 직급, 성별, 근무년수)
as select emp_id, emp_name, job_name,
    decode(substr(emp_no, 8, 1), 1, '남', 2, '여'),
    extract(year from sysdate)-extract(year from hire_date)
from employee
join job using(job_code);
select * from v_emp_job;

--view3
create or replace view v_job(사번, 이름, 직급, 성별, 근무년수)
as select job_code, job_name
    from job 
    join job using(job_code);
    
insert into v_job values('j8','인턴');
select * from v_job;

create or replace view v_dt_emp
as select distinct job_code
    from employee;
insert into v_dt_emp values('J9');
--오류 보고 -
--SQL 오류: ORA-01732: 뷰에 대한 데이터 조작이 부적합합니다
--01732. 00000 -  "data manipulation operation not legal on this view"
--*Cause:    
--*Action:
--distinct 사용하면 insert update delete 시 에러 발생

create or replace view v_joinemp
as select emp_id, emp_name, dept_title
    from employee
    join department on (dept_code = dept_id);

insert into v_joinemp values(888, '조세오', '인사관리부');
--    오류 발생 명령행: 543 열: 1
--오류 보고 -
--SQL 오류: ORA-01776: 조인 뷰에 의하여 하나 이상의 기본 테이블을 수정할 수 없습니다.
--01776. 00000 -  "cannot modify more than one base table through a join view"
--*Cause:    Columns belonging to more than one underlying table were either
--           inserted into or updated.
--*Action:   Phrase the statement as two or more separate statements.
select * from user_views;

--2.나이 상 가장 막내의 사원코드, 사원 명, 나이, 부서 명, 직급 명 조회
select * from
(select emp_id, emp_name, d.dept_title, j.job_name, extract(year from sysdate) - extract(year from emp_no) "나이"
    from employee e
    join department d on ( e.dept_code = d.dept_id)
    join "JOB" j using (job_code)
    ) tb1
    where age = minage
; 
select
    from employee;

select extract(year from sysdate)
        -extract(year from to_Date(substr(emp_no,1,2), 'yy'))
    from employee
;
--한국이나 일본에서 근무중인 사원의 사원명, 부서명, 지역명 국가명

select emp_name, d.date_title, j.job_name, c.local_name, n.national_name
    from employee e
    join department d on(e.dep-code = d.dept_id)
    join "JOB" j using(job_code)
    join location c on(d.location_id = c.local_code)
    join national n using(national_code)
    ;
select emp_name, dept_code,
    substr(emp_no,1,2)||'년'||substr(emp_no,3,2)||'월'||substr(emp_no,5,2)||'일' "생년월일"
--    "만나이"
    ,extract(year from sysdate) - extract(year from to_date(substr(emp_no,1,2),'rr')) "만나이"
from employee
;
select to_date(substr(emp_no,1,6), 'rrmmdd')
    , to_char(to_Date(substr(emp_no,1,6),'rrmmdd'), 'yy"년" mm"월" dd"일"') "생년월일"
    , (sysdate - to_date(substr(emp_no,1,6),'rrmmdd'))/365
    from employee;

create synonym emp for employee;
select * from emp;
select * from dept2_public;

grant select on department to scott;

--20230717
--group by 꼭 지켜져야하는 룰 : group by 컬럼명, 컬럼명만 select로 선택할 수 있음. 또는 그룹함수 사용.
--rollup 전체 집계
--dept_code로 묶인게 없음
select dept_code, job_code, sum(salary)
from employee
group by rollup(job_code, dept_code)
;
--job_code로 묶인게 없음
select dept_code, job_code, sum(salary)
from employee
group by rollup(dept_code, job_code)
;
--위 아래 같은 결과를 나오게 하기 위해서는 cube(c1, c2) = rollup(c1, c2)+ rollup(c2)
select dept_code, job_code, sum(salary)
from employee
group by cube(dept_code, job_code)
;

select dept_code, sum(salary)
from employee
group by dept_code;

select dept_code 부서코드, sum(salary) 합계, floor(avg(salary)) 평균, count(*) 인원수
    from employee
    group by dept_code
    order by dept_code asc;

select dept_code 부서코드, count(bonus) 인원수
    from employee
    where bonus is not null
    group by dept_code
    order by dept_code asc;

select decode(substr(emp_no,8,1),1,'남',2,'여') 성별, florr(avg(sala))

