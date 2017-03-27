-- 도서 관리 프로젝트
DROP SCHEMA IF EXISTS book_project;
 
-- 도서 관리 프로젝트
CREATE SCHEMA book_project;
 
-- 도서
CREATE TABLE bookInfo (
   b_code      CHAR(4)     NOT NULL, -- 도서코드
   b_sub_code  INTEGER(2)  NOT NULL, -- 도서중복코드
   c_name      VARCHAR(50) NULL,     -- 분류
   b_name      VARCHAR(20) NULL,     -- 도서명
   author      VARCHAR(20) NULL,     -- 저자
   p_code      CHAR(4)     NULL,     -- 출판사코드
   price       INTEGER     NULL,     -- 가격
   insert_date DATE        NULL,     -- 도서등록일
   is_del      BOOLEAN     null     DEFAULT false, -- 도서폐기여부
	PRIMARY KEY (b_code,b_sub_code),
	FOREIGN KEY (p_code) REFERENCES publisherInfo(p_code) ON UPDATE cascade,
	FOREIGN KEY (c_name) REFERENCES coden (c_name) ON UPDATE cascade
);
 
-- 도서 대여 정보
CREATE TABLE bookLend (
   b_code       CHAR(4)    NOT NULL, -- 도서코드
   b_sub_code   INTEGER(2) NOT NULL, -- 도서중복코드
   is_lending   BOOLEAN    NULL     DEFAULT false, -- 대여여부
   b_lend_count INTEGER    NULL     DEFAULT 0, -- 총 대여횟수
	  PRIMARY KEY (b_code,b_sub_code),
	FOREIGN KEY (b_code)references bookInfo (b_code) ON UPDATE CASCADE,
	FOREIGN KEY (b_code,b_sub_code) REFERENCES bookInfo (b_code,b_sub_code) on update cascade
);
 
-- 도서분류
CREATE TABLE coden (
	c_name VARCHAR(50) NOT NULL, -- 분류
	c_code CHAR(2)     NOT null,  -- 코드
	PRIMARY KEY (c_name)
);
 
-- 출판사
CREATE table publisherInfo (
   p_code     CHAR(4)     NOT NULL, -- 출판사코드
   publisher  VARCHAR(50) NULL,     -- 출판사명
   p_name     VARCHAR(20) NULL,     -- 담당자명
   p_tel      VARCHAR(13) NULL,     -- 연락처
   p_zip_code INTEGER(5)  NULL,     -- 우편번호
   p_address  VARCHAR(50) null,      -- 주소
	PRIMARY KEY (p_code)
);
 
-- 회원
CREATE TABLE memberInfo (
   m_code     CHAR(4)     NOT NULL, -- 회원코드
   m_pass     VARCHAR(20) NULL,     -- 비밀번호
   m_name     VARCHAR(20) NULL,     -- 성명
   m_tel      CHAR(13)    NULL,     -- 연락처
   m_zip_code INTEGER(5)  NULL,     -- 우편번호
   m_address  VARCHAR(50) NULL,     -- 주소
   is_manager BOOLEAN     NULL,     -- 관리자모드
   is_secsn   BOOLEAN     null    DEFAULT false, -- 탈퇴여부
	PRIMARY KEY (m_code)
);
 
-- 회원 대여 정보
CREATE TABLE memberLend (
   m_code       CHAR(4) NOT NULL, -- 회원코드
   is_posbl     BOOLEAN NULL     DEFAULT true, -- 대여가능여부
   delay_count  INTEGER NULL     DEFAULT 0, -- 연체 횟수
   m_lend_count INTEGER NULL     DEFAULT 0, -- 총 대여권수
   m_now_count  INTEGER NULL     DEFAULT 0, -- 현재 대여권수
   black_date   DATE    null,      -- 대여금지일
	PRIMARY KEY (m_code),
	FOREIGN KEY (m_code) REFERENCES memberInfo(m_code)
	ON UPDATE cascade
);
 
-- 출납
CREATE TABLE paymentIO (
   no          INTEGER    NOT NULL, -- 출납번호
   b_code      CHAR(4)    NOT NULL, -- 도서코드
   b_sub_code  INTEGER(2) NULL,     -- 도서중복코드
   m_code      CHAR(4)    NOT NULL, -- 회원코드
   lend_date   DATE       NULL,     -- 대여일
   return_date DATE       null    DEFAULT null, -- 반납일
	PRIMARY KEY (no),
	FOREIGN KEY (b_code) references bookInfo (b_code) ON UPDATE cascade,
	FOREIGN KEY (m_code) references memberInfo (m_code) ON UPDATE cascade,
	FOREIGN KEY (b_code,b_sub_code) REFERENCES bookInfo (b_code,b_sub_code) ON UPDATE CASCADE
);
 
drop table bookInfo;
drop table coden;
drop table publisherInfo;
drop table bookLend;
drop table paymentIO;
drop table memberInfo;
drop table memberLend;
 
select*from bookInfo;
select*from coden;
select*from publisherInfo;
select*from bookLend;
select*from paymentIO;
select*from memberInfo;
select*from memberLend;

INSERT into bookInfo(b_code, b_sub_code, c_name,b_name,author,p_code, price,insert_date) values
('T001',00, 'IT','이것이자바다', '신용권', 'P001', 30000,'2016-01-01'),
('T001',01, 'IT','이것이자바다', '신용권', 'P001', 30000,'2016-01-01'),
('T001',02, 'IT','이것이자바다', '신용권', 'P001', 30000,'2016-04-01'),
('T002',00,'IT', '자바+안드로이드를다루는기술', '정재곤', 'P002', 40000,'2016-01-10'),
('T003',00,'IT', '인사이드자바스크립트','송형주','P023',18000,'2016-01-15'),
('T004',00,'IT', '자바스크립트&제이쿼리','존두켓','P003',36000,'2016-01-20'),
('T005',00,'IT', '퀄리티 코드', '스티븐 밴스', 'P021', 30000,'2016-01-31'),
('H001',00,'인문', '어떻게죽음을마주할것인가','모니카렌츠','P004',13950,'2016-02-03'),
('H002',00,'인문','공부할권리','정여울','P005',16500,'2016-02-10'),
('H003',00,'인문','미움받을용기','기시미이치로','P006',14900,'2016-02-15'),
('H004',00,'인문','나는생각이너무많아','크리스텔프리콜랭','P007',14800,'2016-02-20'),
('S001',00,'사회','국가란무엇인가','유시민','P008',15000,'2016-02-28'),
('S002',00,'사회','정의란무엇인가','마이클샌델','P009',15000,'2016-03-01'),
('S002',01,'사회','정의란무엇인가','마이클샌델','P009',15000,'2016-03-01'),
('S002',02,'사회','정의란무엇인가','마이클샌델','P009',15000,'2016-03-15'),
('S003',00,'사회','한국사회어디로','김우창','P010',16000,'2016-03-01'),
('S004',00,'사회','페페의희망교육','로베르트프란시스가르시아','P011',15000,'2016-03-05'),
('S005',00,'사회','국가가 할 일은 무엇인가','이헌재,이원재','P020',12500,'2016-03-05'),
('S006',00,'사회', '기록 너머에 사람이 있다 ', '안종오', 'P022', 13800,'2016-03-14'),
('J001',00,'여행','여행이아니면알수없는것들','손미나','P012',15000,'2016-03-15'),
('J001',01,'여행','여행이아니면알수없는것들','손미나','P012',15000,'2016-03-15'),
('J002',00,'여행','후쿠오카여행가는길','김남규','P015',14000,'2016-03-20'),
('J003',00,'여행','런던여행백서','정꽃나래','P014',18000,'2016-03-07'),
('J003',01,'여행','런던여행백서','정꽃나래','P014',18000,'2016-03-17'),
('D001',00,'자기계발', '쓸모없는짓의행복', '크리스길아보', 'P016', 15000,'2016-03-22'),
('D002',00,'자기계발', '버리고시작하라', '위르겐볼프', 'P017', 12000,'2016-04-03');
 
INSERT INTO publisherInfo (p_code, publisher, p_name, p_tel, p_zip_code, p_address) VALUES 
('P001','한빛미디어', '교보문고', '123-456-7890',04029,'서울특별시 마포구 양화로7길 83'),
('P002','길벗', '교보문고', '123-456-7890',04003,'서울특별시 마포구 월드컵로10길 56'),
('P003','제이펍', '교보문고', '123-456-7890',10881,'경기도 파주시 회동길 159 3층 3-B호'),
('P004','책세상', '교보문고', '123-456-7890',03176,'서울특별시 종로구 경희궁길 33 내자빌딩'),
('P005','민음사', '교보문고', '123-456-7890',06027,'서울특별시 강남구 도산대로1길 62'),
('P006','인플루엔셜', '교보문고', '123-456-7890',04511,'서울특별시 중구 통일로2길 16 에이아이에이타워 8층'),
('P007','부키', '교보문고', '123-456-7890',03785,'서울특별시 서대문구 신촌로3길 15 산성빌딩'),
('P008','돌베개', '교보문고', '123-456-7890',10881,'경기도 파주시 회동길 77-20'),
('P009','와이즈베리', '교보문고', '123-456-7890',06532,'서울특별시 서초구 신반포로 321'),
('P010','아시아', '교보문고', '123-456-7890',06972,'서울특별시 동작구 서달로 161-1'),
('P011','학이시습', '교보문고', '123-456-7890',37186,'경상북도 상주시 서문길 111-24'),
('P012','씨네21북스', '교보문고', '123-456-7890',04550,'서울특별시 중구 충무로5길 2 '),
('P013','문학동네', '교보문고', '123-456-7890',10881,'경기도 파주시 회동길 210'),
('P014','나무자전거', '교보문고', '123-456-7890',10441,'경기도 고양시 덕양구 강매로 256-21 1층'),
('P015','연두', '교보문고', '123-456-7890',03911,'서울특별시 마포구 매봉산로 18'),
('P016','더퀘스트', '교보문고', '123-456-7890',04558,'서울특별시 중구 창경궁로 17'),
('P017','흐름출판', '교보문고', '123-456-7890',55019,'전라북도 전주시 덕진구 정언신로 59'),
('P018','21세기북스', '교보문고', '123-456-7890',04560,'서울특별시 중구 퇴계로 293-1'),
('P019','보문사', '교보문고', '123-456-7890',23007,'인천광역시 강화군 삼산면 삼산남로828번길 44'),
('P020','메디치미디어', '교보문고', '123-456-7890',03027,'서울특별시 종로구 사직로9길 22'),
('P021','에이콘출판사', '교보문고', '123-456-7890',07967,'서울특별시 양천구 국회대로 287 2층'),
('P022','다산지식하우스', '교보문고', '123-456-7890',07626,'서울특별시 강서구 공항대로8길 77-24'),
('P023','한빛미디어', '교보문고', '123-456-7890',04768,'서울특별시 성동구 서울숲4길 28');
 
insert into coden (c_name, c_code) values 
('IT', 'T'),
('인문', 'H'),
('사회', 'S'),
('여행', 'J'),
('자기계발', 'D');
 
INSERT INTO booklend (b_code, b_sub_code, is_lending, b_lend_count) values 
('T001',00, true, 1),('T001',01, true, 2),('T001',02, true, 0),
('T002',00, true, 1),('T003',00, true, 4),('T004',00, true, 1),
('T005',00, true, 2),('H001',00, true, 2),('H002',00, true, 2),
('H003',00, true, 2),('H004',00, true, 1),('S001',00, true, 1),
('S002',00, true, 3),('S002',01, true, 1),('S002',02, true, 1),
('S003',00, true, 2),('S004',00, true, 1),('S005',00, true, 1),
('S006',00, true, 2),('J001',00, false, 0),('J001',01, false, 4),
('J002',00, true, 2),('J003',00, true, 1),('J003',01, true, 0),
('D001',00, true, 1),('D002',00, true, 1);
 
INSERT INTO memberInfo (m_code, m_name, m_tel, m_zip_code, m_address, is_secsn, m_pass, is_manager) VALUES
('M001', '김유정', '010-1111-1234',04524,'서울특별시 중구 세종대로 110',false, '1234', false),
('M002', '박보영', '010-1234-2255',35242,'대전광역시 서구 둔산로 100',false, '4567', false), 
('M003', '박보영', '010-2222-4567',41911,'대구광역시 중구 공평로 88',false, '5864', false),
('M004', '전지현', '010-7777-2255',47545,'부산광역시 연제구 중앙대로 1001',false, 'aaba', true),
('M005', 'Emma Watson', '010-5555-4567',41908,'대구광역시 중구 국채보상로139길 1',false, 'bbbb', false),
('M006', '고수', '010-1234-1234',41185,'대구광역시 동구 아양로 207',true, '8888', false), -- 탈퇴상태
('M007', '박보검', '010-5432-1234',41777,'대구광역시 서구 국채보상로 257',false, '9595', true),
('M008', '박형식', '010-1234-9999',42429,'대구광역시 남구 이천로 51',false, '5555', false),
('M009', 'Dan Stevens', '010-9876-1200',41590,'대구광역시 북구 옥산로 65',false, '4444', false),
('M010', '원빈', '010-9876-5432',42424,'대구 남구 중앙대로 220 3층',false, '8811', false),
('M050', '원빈', '010-234-1234',42424,'대구 남구 중앙대로 220 3층',false, '8811', false);
 
 
INSERT INTO memberLend (m_code, is_posbl, delay_count, m_lend_count, m_now_count, black_date)VALUES
('M001', true, 0, 2, 2, null),
('M002', true, 1, 2, 2, null),
('M003', true, 0, 4, 1, null),      
('M004', true, 0, 5, 4, null),               -- 4권 빌린사람
('M005', false, 1, 7, 5, null),            -- 5권 빌린사람
('M006', false, 0, 1, 0, null),            -- 탈퇴회원
('M007', false, 1, 3, 1, null),            -- 책 연체 중인 사람(일반)
('M008', true, 2, 4, 2, null),               -- 곧 블랙.. 연체횟수 2번이나 연체중 아님
('M009', false, 2, 6, 2, null),             -- 곧 블랙리스트 될 사람.. 연체횟수2번에 연체중인사람
('M010', false, 3, 5, 0, '2017-03-23');       -- 현재 블랙리스트
	
 
 
INSERT INTO paymentIO (no, b_code, b_sub_code, m_code, lend_date, return_date) values
(1,'S002',02,'M003','2017-01-20' , '2017-01-21'),
(2,'J002',00,'M003','2017-01-22' , '2017-01-25'),
(3,'J001',01,'M007','2017-01-23' , '2017-01-25'),
(4,'S002',00,'M010','2017-01-23' , '2017-02-02'),   -- 연체도서
(5,'J001',01,'M010','2017-01-25' , '2017-02-05'),   -- 연체도서
(6,'S002',01,'M007','2017-01-31' , '2017-02-01'),
(7,'T003',00,'M010','2017-02-07' , '2017-02-08'),
(8,'J001',01,'M005','2017-02-10' , '2017-02-12'),
(9,'T003',00,'M009','2017-02-18' , '2017-02-19'),
(10,'S002',00,'M009','2017-02-19' , '2017-02-28'),   -- 연체도서
(11,'T003',00,'M004','2017-02-23' , '2017-02-24'),
(12,'J001',01,'M003','2017-02-28' , '2017-03-02'),
(13,'T005',00,'M005','2017-03-04' , '2017-03-06'),
(14,'H002',00,'M008','2017-03-05' , '2017-03-10'),   -- 연체도서
(15,'T001',01,'M010','2017-03-05' , '2017-03-06'),
(16,'S006',00,'M010','2017-03-08' , '2017-03-15'),  -- 연체도서
(17,'S003',00,'M009','2017-03-08' , '2017-03-09'),
(18,'T001',00,'M009','2017-03-09' , '2017-03-20'),   -- 연체도서
(19,'H003',00,'M008','2017-03-15' , '2017-03-20'),   -- 연체도서
(20,'H001',00,'M006','2017-03-19' , '2017-03-21'),
(21,'H002',00,'M009','2017-03-20' , null), -- 연체중
(22,'T001',01,'M001','2017-03-21' , null),
(23,'T003',00,'M002','2017-03-21' , null),
(24,'T004',00,'M002','2017-03-21' , null),
(25,'S004',00,'M003','2017-03-21' , null),
(26,'J002',00,'M004','2017-03-21' , null),
(27,'S001',00,'M005','2017-03-22' , null),
(28,'S006',00,'M005','2017-03-22' , null),
(29,'H001',00,'M004','2017-03-22' , null),
(30,'D002',00,'M004','2017-03-22' , null),
(31,'S005',00,'M005','2017-03-22' , null),
(32,'T005',00,'M005','2017-03-22' , null),
(33,'J003',00,'M005','2017-03-22' , null),
(34,'S002',00,'M007','2017-03-22' , null),
(35,'H004',00,'M008','2017-03-23' , null),
(36,'S003',00,'M008','2017-03-23' , null),
(37,'T002',00,'M001','2017-03-23' , null),
(38,'D001',00,'M004','2017-03-23' , null),
(39,'H003',00,'M009','2017-03-23' , null);
   
/********************************************************************************************/
      
select m_code, count(*) from book_project.paymentio group by m_code; 


-- --------------------------------------------------------------------------------------
select b.b_code,b_name,m.m_code,m_name,lend_date,return_date, if(datediff(current_date,lend_date)>2,'Y','N') is_delay
from paymentIO i join memberInfo m on m.m_code = i.m_code
join bookInfo b on b.b_code = i.b_code;



-- 1. 반납필요 도서목록
select b.b_code,b_name,m.m_code,m_name,lend_date, if(datediff(current_date,lend_date)>2,'Y','N') is_delay
from paymentIO i join memberInfo m on m.m_code = i.m_code
join bookInfo b on b.b_code = i.b_code where return_date is null;
 
-- 2.반납필요 도서목록에서 누르면 그에 해당하는 데이터 정보 쫘아~~~~~
select b.b_code,b_name,author,p.p_code,bl.b_lend_count,m.m_code,m.m_name,m.m_tel,lend_date,return_date
from paymentIO i join bookInfo b on i.b_code=b.b_code join publisherInfo p on b.p_code=p.p_code
join bookLend bl on b.b_code=bl.b_code join memberInfo m on i.m_code=m.m_code
where i.b_code='H003' and m.m_code='M009';
 
-- 3.반납일이 대여일보다 작다면~
-- 이부분에 대해서는 자바로 처리할지 db할지 고민고민  0부터 양수는 맞음 음수가 나오면 오류로 돌려버림
select datediff('2017-03-22','2017-03-22');


-- 4반납버튼 트랜잭션 구문
-- 트랜잭션구분  4-1.출납 테이블에 입력된 반납일을 지정하여 저장!
UPDATE paymentIO
SET return_date='2017-03-23'
WHERE b_code='T001' and m_code='M001' and return_date is null;


/*UPDATE paymentIO
SET return_date = 1
WHERE b_code='T001' and m_code='M001' and return_date is null;*/
 
-- 4-1에 저장된거 확인
select*from paymentIO WHERE b_code='T001' and m_code='M001';
 
-- 4-2 도서 테이블의 대여기능여부를 대여가능으로 보이기
update bookLend
set is_lending = false
where b_code ='T001';

-- 4-2 저장된거 확인
select*from bookLend
where b_code ='T001';

-- 4-3반납필요 도서목록에서 해당도서 내용 표시 x
select b.b_code,b_name,m.m_code,m_name,lend_date, if(datediff(current_date,lend_date)>2,'Y','N') is_delay
from paymentIO i join memberInfo m on m.m_code = i.m_code
join bookInfo b on b.b_code = i.b_code where return_date is null;

call proc_paymentIO_update('H003','M009',current_date);


-- 트랜잭션
delimiter $$
create procedure book_project.proc_paymentIO_update(
	in _b_code char(4),
	in _m_code char(4),
	in _return_date date
)
begin	
	
	declare err int default 0;
	declare continue handler for sqlexception set err = -1;
	
	start transaction;

	UPDATE paymentIO SET return_date = _return_date 
	where b_code = _b_code and m_code= _m_code and return_date is null;
		
	UPDATE booklend SET is_lending = false WHERE b_code= _b_code;
	update memberLend set m_now_count=(m_now_count-1) where m_code = _m_code;
	
	
	
	if err < 0 then
		rollback;
	else
		commit;
	end if;
	
end $$
delimiter ;

select datediff('2017-03-25', '2017-03-24');

UPDATE paymentIO SET return_date = current_date
	where b_code = 'T003' and m_code= 'M002' and return_date is null;


call book_project.proc_paymentIO_update('T004','M002',current_date);

call book_project.proc_paymentIO_update('S001','M005','2017-03-24');

select *, if(datediff(return_date,lend_date)>2,'Y','N') 
from paymentio 
where b_code= 'T004' and m_code='M002' and lend_date = '2017-03-21';

select*from booklend where is_lending is false;


select*from coden;

insert into coden(c_name,c_code) values
('경제','E'),('스포츠','St');

UPDATE coden
SET c_code='T1'
WHERE c_name='스포츠';





















-- test
select 
if(datediff('2017-03-25','2017-03-22')>2,'Y','N'); 

select*from payment_io 
where if(datediff(current_date,lend_date)>2,'Y','N');


select current_date;

-- 도서랑 출판사 조인
select b.b_code,b_name,author,p.p_code,price
from book_info b join publisher_info p on p.p_code=b.p_code;
 
-- 도서랑 출납 대여일 보는거
select b.b_code,b_name,author,price,i.lend_date
from book_info b join payment_io i on b.b_code= i.b_code;
 
-- 도서랑 도서대여정보 조인
select b.b_code,b_name,author,bl.b_lend_count
from book_info b join b_lend_info bl;






-- 도서랑 출납 대여일 보는거
select b.b_code,b_name,author,price,i.lend_date
from book_info b join payment_io i on b.b_code= i.b_code;
 
-- 도서랑 도서대여정보 조인
select b.b_code,b_name,author,bl.b_lend_count
from book_info b join b_lend_info bl;
 

--  여기부터 ~~~~~~~~~~~~~~~~~~~~~~~~
-- 1.도서명으로 검색 : 도서코드, 도서명, 출판사, 저자, 가격 (도서정보) 출력
select b_code, b_name, p.publisher, author, price from bookInfo b 
left join publisherInfo p
on b.p_code = p.p_code where b_name like '%자바%'



-- 2. 도서명으로 검색 시, 책의 이름이 중복 될 경우
-- 2-1. 중복확인하기 : 동일한 책의 이름이 있는지, 몇 권인지 확인
select count(*) from bookInfo where b_name like '%런던%'

-- 2-2. 동일한 책 이름이 중복되어 나오면, 새창에서 클릭시, 도서 코드로 재 검색
select b_code, b_name, p.publisher, author, price from bookInfo b left join publisherInfo p
on b.p_code = p.p_code where b_code = ?



3. 도서코드로 검색 : 도서코드, 도서명, 출판사, 저자, 가격 (도서정보) 출력
select b_code, b_name, p.publisher, author, price from bookInfo b left join publisherInfo p
on b.p_code = p.p_code where b_code = ?



4. 출판사명으로 도서 검색
select b_code, b_name, p.publisher, author, price from bookInfo b left join publisherInfo p
on b.p_code = p.p_code where publisher like '%한빛%'

4-1. 동일한 출판사명이 있을 경우, 중복확인
select count(*) from publisherInfo where publisher like '%한빛%'

4-2. 중복확인 되어 새창에서 클릭시, 도서코드로 재 검색
select b_code, b_name, p.publisher, author, price from bookInfo b left join publisherInfo p
on b.p_code = p.p_code where b_code = ?

-- 5. 도서코드 검색 성공 시, [회원코드 성명 대여일 반납일 연체여부] 출력
select p.m_code, m.m_name, lend_date, return_date, if(datediff(return_date, lend_date)>2, 'Y', 'N')
from memberInfo m join paymentIO p on m.m_code=p.m_code where b_code = 'J001';


6. 도서명 검색 성공 시, [회원코드 성명 대여일 반납일 연체여부] 출력
select m.m_code, m.m_name, lend_date, return_date, if(datediff(current_date, lend_date)>2, 'Y', 'N')
from paymentIO p 
join memberInfo m on p.m_code = m.m_code
join bookInfo b on b.b_code = p.b_code where b.b_name like '%자바%'

6-1. 동일한 책 이름이 중복되어 나오면, 새창에서 클릭시, 도서 코드로 재 검색
select m.m_code, m.m_name, lend_date, return_date, if(datediff(current_date, lend_date)>3, 'Y', 'N')
from paymentIO p 
join memberInfo m on p.m_code = m.m_code
join bookInfo b on b.b_code = p.b_code where b.b_code=?


7. 총 대여 횟수
select b_lend_count from bookLend where b_code=?;
		
(앞장에서 자동으로 +1되도록 해놓음: update b_lend_info set b_lend_count=(b_lend_count+1) where b_code=?; )
 
