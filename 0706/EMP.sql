-- DROP TABLE DEPT;
/*CREATE TABLE DEPT(
	deptno TINYINT PRIMARY KEY,
	dname VARCHAR(14),
	loc VARCHAR(13)
);

CREATE TABLE EMP(
empno SMALLINT PRIMARY KEY,
ename VARCHAR(10),
job VARCHAR(9),
mgr SMALLINT,
hiredate DATE,
sal FLOAT,
comm FLOAT,
deptno TINYINT,
foreign KEY(DEPTNO) REFERENCES DEPT(DEPTNO)
);

CREATE TABLE BONUS(
ename VARCHAR(10),
job VARCHAR(9),
sal INT,
comm INT
);

CREATE TABLE SALGRADE(
grade TINYINT,
losal SMALLINT,
hisal SMALLINT
);

INSERT INTO DEPT VALUES (10,'ACCOUNTING', 'NEW YORK');
INSERT INTO DEPT VALUES (20,'RESEARCH', 'DALLAS');
INSERT INTO DEPT VALUES (30,'SALES', 'CHICAGO');
INSERT INTO DEPT VALUES (40,'OPERATIONS', 'BOSTON');

INSERT INTO SALGRADE VALUES (1, 700, 1200);
INSERT INTO SALGRADE VALUES (2, 1201, 1400);
INSERT INTO SALGRADE VALUES (3, 1401, 2000);
INSERT INTO SALGRADE VALUES (4, 2001, 3000);
INSERT INTO SALGRADE VALUES (5, 3001, 9999);

INSERT INTO EMP VALUES
(7369,'SMITH','CLERK',7902,STR_TO_DATE('17-12-1980','%d-%m-%Y'),800,NULL,20);
INSERT INTO EMP VALUES
(7499,'ALLEN','SALESMAN',7698,STR_TO_DATE('20-2-1981','%d-%m-%Y'),1600,300,30);
INSERT INTO EMP VALUES
(7521,'WARD','SALESMAN',7698,STR_TO_DATE('22-2-1981','%d-%m-%Y'),1250,500,30);
INSERT INTO EMP VALUES
(7566,'JONES','MANAGER',7839,STR_TO_DATE('2-4-1981','%d-%m-%Y'),2975,NULL,20);
INSERT INTO EMP VALUES
(7654,'MARTIN','SALESMAN',7698,STR_TO_DATE('28-9-1981','%d-%m-%Y'),1250,1400,30);
INSERT INTO EMP VALUES
(7698,'BLAKE','MANAGER',7839,STR_TO_DATE('1-5-1981','%d-%m-%Y'),2850,NULL,30);
INSERT INTO EMP VALUES
(7782,'CLARK','MANAGER',7839,STR_TO_DATE('9-6-1981','%d-%m-%Y'),2450,NULL,10);
INSERT INTO EMP VALUES
(7788,'SCOTT','ANALYST',7566,STR_TO_DATE('1-3-1981','%d-%m-%Y'),3000,NULL,20);
INSERT INTO EMP VALUES
(7839,'KING','PRESIDENT',NULL,STR_TO_DATE('17-11-1981','%d-%m-%Y'),5000,NULL,10);
INSERT INTO EMP VALUES
(7844,'TURNER','SALESMAN',7698,STR_TO_DATE('8-9-1981','%d-%m-%Y'),1500,0,30);
*/
/*
-- fields, column(열)
SELECT empno, ename, job FROM emp;
SELECT * FROM emp;
-- emp 테이블에서 사원번호, 급여, 부서번호를 출력하세요 단 급여가 많은 순으로 출력하세요.
SELECT empno, sal, deptno FROM emp ORDER BY sal DESC;

-- emp 테이블에서 사원번호, 급여, 입사일을 출력해보세요 단 급여가 적은 순서대로
SELECT empno, sal, hiredate FROM emp ORDER BY sal ASC;

-- emp 테이블에서 직업, 급여를 출력해 보세요. 단 직업명으로 오름차순, 급여로 내림차순 정렬
SELECT job, sal FROM emp ORDER BY job ASC, sal DESC;
SELECT empno AS "사원번호", ename AS "사원이름" FROM emp;
-- SELECT empno AS 사원번호, ename AS 사원이름 FROM emp;

-- 조건절
-- SELECT sal 급여, sal*1.1 급여와 보너스 합 FROM emp WHERE deptno = 10;

-- 급여가 3000 이상인 사원들의 모든 정보를 출력
SELECT * FROM emp WHERE sal >= 3000;
SELECT ename, deptno FROM emp WHERE deptno != 30;

-- 논리 연산자
-- emp 테이블에서 부서번호가 10이고 급여가 3000이상인 사원들의 이름과 급여를 출력하세요.
SELECT ename, sal FROM emp WHERE deptno = 10 AND sal >= 3000;

SELECT empno, deptno FROM emp WHERE job='SALEMAN' of job = 'MANAGER';

-- in 연산자
-- 부서번호가 10번이거나 20번인 사원의 사원번호와 이름, 부서번호를 출력하세요.
SELECT empno, ename, deptno FROM emp deptno IN(10, 20);
SELECT empno, ename, deptno FROM emp deptno=10 OR deptno = 20;

-- between 연산자 : 범위 t
-- 급여가 1000과 2000 사이인 사원들의 사원번호, 이름, 급여를 출력하세요.
SELECT empno, ename, sal FROM emp WHERE sal BETWEEN 1000 AND 2000;
SELECT empno, ename, sal FROM emp WHERE sal >= 1000 AND SAL <= 2000;
*/

-- 사원이름이 'FORD'와 'SCOTT' 사이의 사원들의 사원번호, 이름을 출력해 보세요
SELECT empno, ename FROM emp WHERE ename BETWEEN 'FORD' AND 'SCOTT';