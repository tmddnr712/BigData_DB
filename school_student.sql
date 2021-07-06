INSERT INTO school(schoolname,address, schoolcode, studentcount)
				VALUES("충주여자고등학교", "충주시", "CH00000001", 360);
INSERT INTO school(schoolname,address, schoolcode, studentcount)
				VALUES("서울여자고등학교", "서울시", "SE00000001", 1200);
INSERT INTO school(schoolname,address, schoolcode, studentcount)
				VALUES("아산고등학교", "아산시", "IC00000001", 560);
INSERT INTO school(schoolname,address, schoolcode, studentcount)
				VALUES("온양고등학교", "천안시", "IC00000002", 560);
				
SELECT * FROM school;
INSERT INTO student(NAME, kor, mat, eng, schoolcode) VALUES('김만덕',100, 99, 99, 'CH00000001');
INSERT INTO student(NAME, kor, mat, eng, schoolcode) VALUES('종로구',100, 80, 70, 'IC00000001');
SELECT NAME, kor, mat, eng FROM student WHERE NAME = '김만덕';
SELECT NAME, '이름', kor 국어 , mat 수학 , eng 영어 FROM student WHERE NAME = '종로구';
SELECT NAME, kor, mat, eng FROM student WHERE schoolcode IN ('CH0000001', 'SE00000001');


-- 성이 김씨인 사람의 이름 국어 영어 수학 점수를 출력 
SELECT NAME, kor, mat, eng FROM student WHERE NAME LIKE '김%';
SELECT NAME, kor, mat, eng FROM student WHERE NAME LIKE '김__';

-- 전공인 , 80,80,80,240, 80 'B' , 'SE00000001'
-- 전공이 , 80,80,80,240, 80 'B' , 'SE00000001'

INSERT INTO student(NAME, kor, mat , eng , total,average, grade, schoolcode) VALUES(
    '전공인' , 80,80,80,240, 80, 'B' , 'SE00000001');

INSERT INTO student(NAME, kor, mat , eng , total,average, grade, schoolcode) VALUES(
    '전공이' , 80,80,80,240, 80 ,'B' , 'SE00000001');

-- 국어 영어 수학 점수가 하나라도 90점 이상이 학생 출력 
SELECT * FROM student WHERE kor >= 90 OR mat >= 90 OR eng >= 90;
-- 국어 점수가 60에서 80점 사이인 사람중 2사람만 출력 단 내림차순
SELECT * FROM student WHERE kor BETWEEN 60 AND 80 ORDER BY kor DESC LIMIT 2;
-- 전체를 총점의 내림차순 출력  
SELECT * FROM student ORDER BY total DESC;

DELETE FROM student;
SELECT * FROM student;
SELECT DISTINCT NAME FROM student;
CREATE TABLE if NOT EXISTS student_backup AS SELECT * FROM student;
SELECT * FROM student_backup;
-- 학교코드 학교이름 학생이름 평균
SELECT sc.schoolcode, sc.schoolname, st.name, st.average FROM student st JOIN school sc ON st.schoolcode = sc.schoolcode;

UPDATE student SET total = kor + mat + eng, average = ROUND(kor + mat + eng)/3,2)
			grade = 
(		CASE WHEN average >= '90', THEN 'A'
		WHEN (average >= '80', AND average < '90') THEN 'B'
		WHEN (average >= '70', AND average < '80') THEN 'C'
		WHEN (average >= '60', AND average < '70') THEN 'D'
		ELSE 'F'
	END) WHERE NAME = "전공인";
UPDATE student SET total = kor + mat + eng, average = ROUND(kor + mat + eng)/3,2),
 grade = IF(average >= 90, 'A', IF(average >= 80, 'B', IF(average >= 70, 'C',
 If(average >= 60, 'D', 'F'))));
 
