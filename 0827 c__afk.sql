-- DDL
-- Table 생성
create table 고객(
    고객아이디 VARCHAR(20) not null PRIMARY KEY,
    고객이름 VARCHAR(20) not null,
    나이 INT,
    등급 VARCHAR(10) not null,
    직업 VARCHAR(20),
    적립금 INT default 0
);

create table 제품(
    제품번호 char(3) not null,
    제품명 varchar(20),
    재고량 int,
    단가 int,
    제조업체 varchar(20),
    primary key(제품번호),
    check (재고량 >=0 and 재고량 <= 10000)
);

-- foreign key 
create table 주문(
    주문번호 varchar(10) not null primary key,
    주문고객 varchar(20),
    주문제품 char(3),
    수량 int,
    배송지 varchar(50),
    주문일자 date,
   foreign key(주문고객) REFERENCES 고객(고객아이디),
   foreign key(주문제품) REFERENCES 제품(제품번호)
);

create table 배송업체(
    업체번호 char(3) not null primary key,
    업체명 varchar(20),
    주소 varchar(100),
    전화번호 varchar(20)
);
