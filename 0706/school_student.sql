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
-- 국어 점수가 60에서 80점 사이인 사람중 2사람만 출력 단 내림차순
-- 전체를 총점의 내림차순 출력  