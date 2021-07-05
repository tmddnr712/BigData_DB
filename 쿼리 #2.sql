DESC member;
-- 입력순서대로 저장
-- varchar 
INSERT INTO member(num,NAME,addr) VALUES(1,"지현","서울");
INSERT INTO member(num,NAME) VALUES ( 2, "Mark Down");
INSERT INTO member VALUES (3,"대한민국","서울");

INSERT INTO member VALUES (3, "대한민국" ," 서울 ");
INSERT INTO member VALUES (3, "민국" ," 서울 ");
DELETE FROM member;