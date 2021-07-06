SELECT * FROM emp WHERE deptno = 10; -- 부서번호(deptno)가 10번인 사원 정보출력
SELECT * FROM emp WHERE sal >= 2000; -- 급여(sal)가 2000 이상이 되는 사람 출력
SELECT ename, hiredate FROM emp WHERE hiredate >= '1982/01/01'; -- hiredate가 '1982/01/01'보다 큰 사원의 사원이름과 채용일을 출력
SELECT * FROM emp WHERE ename = 'CLARK' AND deptno = 10;
SELECT * FROM emp WHERE hiredate >= '1982/01/01' OR job = 'MANAGER'; -- 입사일이 '1982/01/01'이후 이거나 job이 'MANAGER'인 직원을 출력
SELECT * FROM emp WHERE deptno <> 10; -- 부서번호가 10이 아닌 직원을 출력
SELECT * FROM emp sal >= 2000 AND sal <= 3000; -- 급여가 2000에서 3000사이의 급여를 받는 사원을 출력
SELECT * FROM emp sal BETWEEN 2000 AND 3000;
SELECT * FROM emp WHERE comm = 300 OR comm = 500 OR comm == 1400; -- 커미션이 300이거나 500이거나 1400인 사원을 검색(IN 사용)
SELECT * FROM emp WHERE comm IN(300, 500, 1400);
SELECT * FROM emp ORDER BY ename DESC; --사원을 이름(ename)순으로 내림차순(DESC)으로 정렬하여 출력
SELECT * FROM emp ORDER BY sal DESC, ename DESC; -- 사원을 급여와 이름수능로 정렬하여 출력
SELECT deptno, MAX(sal), MIN(sal) FROM emp GROUP BY deptno; -- 부서 그룹별로 급여의 최고액(MAX)와 최저액(MIN)을 출력
SELECT COUNT(comm) FROM emp WHERE comm > 0; -- 사원 테이블의 사원들 중에서 커미션(COMM)을 받는 사원수(COUNT) 구하시요
SELECT COUNT(comm) FROM emp WHERE comm IS NOT NULL;
SELECT COUNT(DISTINCT job) FROM emp; -- 직업(JOB)의 종류가 몇개인지 즉 중복되지 않는 직업의 개수를 카운트 하세요
SELECT DISTINCT job FROM emp;
SELECT job, COUNT(empno), AVG(sal), MAX(sal), MIN(sal), SUM(sal), FROM emp GROUP BY job; -- 업무별(job)fh 그룹화하여 업무, 인원수, 평균급여액, 최고급여액, 최저그여액 및 급여 합계액을 출력
SELECT job, SUM(sal) FROM emp GROUP BY job HAVING SUM(sal) > 5000 ORDER BY sam(sal);-- 전체 월급이 5000을 초과하는 각 업무에 대해서 업무와 월급여의 합계를 출력
-- 단 판매원은 제외하고 우러급여 합꼐로 내림차순으로 정렬
SELECT deptno, MAX(sal), MIN(sal) FROM emp GROUP BY deptno HAVING MAX(sal) >= 2900; -- 부서의 최대값과 최소값을 구하되 최대 급여가 2900 이상인 부서만 출력
SELECT e.deptno, dname, ename, sal FROM emp e, dept d WHERE e.deptno = d.deptno; -- emp 테이블과 dept 테ㅣ블을 조인하여 부서번호, 부서명, 이름, 급여를 출력
SELECT e.deptno, dname, ename, sal FROM emp e inner JOIN dept d ON e.deptno = d.deptno;
SELECT ename, dname FROM emp e, dept d WHERE e.deptno = d.deptno AND ename = 'ALLEN'; -- 사원의 이름이 ALLEN 인 사원의 부서명을 출력
SELECT ename, dname FROM emp e JOIN dept d ONE e.deptno = deptno AND ename = 'ALLEN';
SELECT ename, deptno, dname, sal FROM emp e LEFT dept d ON e.deptno = d.deptno; -- 모든 사원의 이름, 부서번호, 부서명, 급여를 출력하세요, 단 테이블에 없는 부서도명이 없어도 출력






