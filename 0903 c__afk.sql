-- DDL(데이터 정의어)
-- 테이블 변경
-- 컬럼(속성) 추가
alter table 고객
            add 가입날짜 date;
            
-- 컬럼 삭제
alter table 고객
            drop column 가입날짜;
            
-- 제약조건 추가
alter table 고객
            add constraint check_age check(나이 >= 20);

-- 제약조건 삭제
alter table 고객
            drop constraint check_age;
            
--테이블 삭제
drop table 배송업체;

-- DML(데이터 조작어)
-- insert(테이블에 데이터를 삽입

-- 고객 테이블에 데이터행 삽입
-- 모든컬럼에 값이 삽입
-- 1번 방법: 테이블명()안에 모든 컬럼리스트를 나열
insert into 고객(고객아이디, 고객이름, 나이, 등급, 직업, 적립금)
        values ('banana','김선우', 25, 'vip', '간호사', 2500);
        
-- 2번 방법: 테이블명()안에 모든 컬럼리스트 생략
insert into 고객
        values ('carrot','고명석', 28, 'gold', '교사', 4500);
        
-- 3번 방법: 컬럼의 순서를 변경
insert into 고객(고객아이디, 고객이름, 직업, 등급, 적립금, 나이)
        values ('orange','김용욱', '학생', 'silver', 0, 22);
            
-- 4번 방법: 컬럼의 일부를 리스트에서 생략
insert into 고객(고객아이디, 고객이름, 등급, 직업)
        values ('melon', '성원용',  'gold', '회사원');

insert into 고객(고객아이디, 고객이름, 등급, 직업, 적립금)
        values ('peach','오형준', 'silver', '의사', 300);
    
 insert into 고객
        values ('pear','최광주', 31, 'silver', '회사원', 500);      
        
 insert into 고객
        values ('strawberry','최유경', 30, 'vip', '공무원', 100);
        
        
-- insert into 테이블명 (컬럼1, 컬럼2, 컬럼3)
-- values
-- ('값a1', '값a2', '값a3'),
-- ('값b1', '값b2', '값b3'),
-- ('값c1', '값c2', '값c3');

-- 제품 테이블에 데이터 삽입
INSERT ALL
INTO 제품 VALUES ('p02','매운쫄면',2500,5500,'민국푸드')
INTO 제품 VALUES ('p03','쿵떡파이',3600,2600,'한빛제과')
INTO 제품 VALUES ('p04','맛난초컬릿',1250,2500,'한빛제과')
INTO 제품 VALUES ('p05','얼큰라면',2200,1200,'대한식품')
INTO 제품 VALUES ('p06','통통우동',1100,1550,'민국푸드')
INTO 제품 VALUES ('p07','달콤비스킷',1650,1500,'한빛제과')
SELECT * FROM dual;

-- 주문 테이블에 데이터 삽입

insert all
into 주문 values('o03', 'banana', 'p06', 45, '경기도 부천시', '26/09/01')
into 주문 values('o04', 'carrot', 'p02', 8, '부산시 금정구', '26/07/30')
into 주문 values('o05', 'melon', 'p06', 36, '경기도 용인시', '26/08/01')
into 주문 values('o06', 'banana', 'p01', 19, '충천북도 보은군', '26/07/07')
into 주문 values('o07', 'apple', 'p03', 22, '서울시 영등포구', '26/09/03')
into 주문 values('o08', 'pear', 'p02', 50, '강원도 춘천시', '26/06/03')
into 주문 values('o09', 'banana', 'p04', 15, '전라남도 목포시', '26/07/08')
into 주문 values('o10', 'carrot', 'p03', 20, '경기도 안양시', '26/08/20')
select* from dual;

select * from 고객;

select * from 제품;

select * from 주문;