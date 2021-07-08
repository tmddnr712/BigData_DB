/*member
memberid NAME 		addr
			유재석	서울
			김제동	경남
			이범수	충북
			김성주	충북
			배두나	전남
			고현정	전남
			
memberclubtbl
uniqueid memberid, clubid
			유재석 : 바둑, 축구
			김제동 : 상담, 바둑
			이범수 : 축구
			김성주 : 축구
			배두나 : 상담, 바둑
			고현정 : 바둑
			
clubtbl
clubid clubname
		 바둑  1003호 성공빌딩
		 축구  1201호 성공빌딩
		 상담  1101호 영원빌딩
		 
		 
-- 1) 회원수는 몇명
-- 2) 클럽수는 몇개 
-- 3) 회원명단과 회원이 속한 클럽을 출력 
-- 4) 축구를 취미로 가지고 있는 회원의 이름 주소 출력
-- 5) 상담 클럽에 속한 회원은 몇명 
-- 6) 축구를 취미로 둔 사람의 이름과 가야할 빌딩이름과 룸번호 출력
-- 7) 유재석이 속해 있는 클럽의 클럽이름과 방번호와 빌딩이름 출력*/

INSERT INTO member (memberid, NAME, addr)
VALUES
('A01', '유재석', '서울'),
('A02', '김제동', '경남'),
('A03', '이범수', '충북'),
('A04', '김성주', '충북'),
('A05', '배두나', '전남'),
('A06', '고현정', '전남');

INSERT INTO clubtbl (clubid, clubname, roomno, loc)
VALUES
('CL01', '바둑', '1103호', '성공빌딩'),
('CL02', '축구', '1201호', '성공빌딩'),
('CL03', '상담', '1101호', '성공빌딩');

INSERT INTO memberclubtbl (UniqueId, memberid, clubid)
VALUES
('UC01', 'A01', 'CL01'),
('UC02', 'A02', 'CL03'),
('UC03', 'A03', 'CL02'),
('UC04', 'A04', 'CL02'),
('UC05', 'A05', 'CL03'),
('UC06', 'A06', 'CL01');

SELECT * FROM member;
SELECT * FROM clubtbl;
SELECT * FROM memberclubtbl;