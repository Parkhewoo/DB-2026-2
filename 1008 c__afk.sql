-- 그룹별 검색
-- 주문테이블에서 각 주문고객별로 주문한 제품의 총 주문수량을 검색하시오
    select 주문고객, sum(수량) as "총 주문수량" from 주문
    group by 주문고객;
-- 주문테이블에서 각 주문고객이 주문한 제품의 총 주문수량을 주문제품별로 검색하시오
    select 주문제품, 주문고객, sum(수량) as "총 주문수량" from 주문
    group by 주문고객, 주문제품
    order by 주문제품;
-- 조인(join) 검색
-- 주문, 제품테이블 조인(부모테이블의 외래키(FK)와 자식테이블의 기본키(PK) 속성
-- 주문테이블과 제품테이블을 조인검색하시오
    select * from 주문, 제품
    where 주문제품 = 제품번호
    order by 주문번호;
--  주문테이블과 제품테이블을 검색하시오. (주문번호, 주문고객, 제품명, 단가 제조업체 만 출력)
select 주문번호, 주문고객, 제품명, 단가, 제조업체 from 주문, 제품
    where 주문제품 = 제품번호
    order by 주문번호;
    
-- 주문테이블과 제품, 고객 테이블을 조인검색하시오.(주문번호, 주문고객, 고객이름, 제품명, 단가, 수량, 제조업체만 출력)
 select 주문번호, 주문고객, 고객이름, 제품명, 단가, 수량, 제조업체 from 주문, 제품, 고객
     where 주문고객 = 고객아이디 and 주문제품 = 제품번호 
     order by 주문번호;
     
-- apple 고객이 주문한 제품의 이름을 검색하시오
select 주문고객, 주문제품 from 주문, 제품, 고객
    where 주문고객 = 고객아이디 and 주문제품 = 제품번호 and 고객아이디 = 'apple'
    order by 주문제품;
    
-- 감자만두를 주문한 고객의 이름을 검색하시오
select  distinct 주문고객 from 주문, 제품, 고객
    where 주문고객 = 고객아이디 and 주문제품 = 제품번호 and 제품명 = '감자만두'
    order by 주문고객;
    
select 고객아이디, 고객이름, 나이, 등급, 직업, 적립금, 제품번호, 제품명, 단가, 수량, 배송지, 주문일자 from 주문, 제품, 고객
     where 주문고객 = 고객아이디 and 주문제품 = 제품번호 and 제품명 = '감자만두'
    order by 주문고객;

-- 나이가 25세 이상인 고객이 주문한 제품의 번호, 주문일자, 고객이름을 검색하시오
select 주문제품, 주문일자, 고객이름 from 고객, 주문
    where 나이 >= 25 and 고객아이디 = 주문고객
    order by 주문제품;
    
--    고명석 고객이 주문한 제품의 제품명을 검색하시오
select 제품명 from 고객, 제품, 주문
    where 고객아이디 = 주문고객 and 주문제품 = 제품번호 and 고객이름 = '고명석';
--    정소화 고객이 주문한 제품의 제품명을 검색하시오(단 제품명이 한번씩만 나오게 하시오
select distinct 제품명 from 고객, 제품, 주문
    where 고객아이디 = 주문고객 and 주문제품 = 제품번호 and 고객이름 = '정소화';
    
--내부조인(Ineer Join)
--고객이 주문한 제품의 번호와 주문일자를 검색하시오.(단, 내부조인으로 작성하시오)
select 고객이름, 주문제품, 주문일자 from 고객 inner join 주문
                                                    on 고객아이디 = 주문고객;
                                                    
-- 고객이 성이 정또는 김또는 고인 고객이 주문한 제품의 번호와 주문일자를 검색하시오(단, 내부조인으로 작성하시오)
select 고객이름, 주문제품, 주문일자 from 고객 inner join 주문
                                                    on 고객아이디 = 주문고객
                                                    where 고객이름 like '정%'
                                                    or 고객이름 like '김%'
                                                    or 고객이름 like '고%'
                                                    order by 고객이름;

-- 외부조인(Outer Join)
-- 주문하지도 않은 고객도 포함해서 고객이름, 주문제품, 주문일자를 검색하시오.
select 고객이름, 주문제품, 주문일자 from 고객, 주문 where 고객아이디 = 주문고객;// 자연조인
select 고객이름, 주문제품, 주문일자 from 고객 left outer join 주문 on 고객아이디 = 주문고객;//왼쪽 외부조인
select 고객이름, 주문제품, 주문일자 from 주문 right outer join 고객 on 고객아이디 = 주문고객;//오른쪽 외부조인

--Sub Query (부속질의문)
--단일행 결과 부속질의문
--달콤비스킷을 생산한 제조업체가 만든 제품들의 제품명과 단가를 검색하시오

select 제품명, 단가 from 제품
    where 제조업체=(select 제조업체 from 제품 where 제품명 like '달콤비스킷');
    
--  집계함수를 이용한 Sub Query
--적립금이 가장 적은 고객의 고객이름과 적립금을 검색하시오
select 고객이름, 적립금 from 고객
    where 적립금=(select min (적립금) from 고객);
    
--다중행 부속질의문
--banana 고객이 주문한 제품의 제품명, 제조업체를 검색하시오
select 주문제품 from 주문 where 주문고객 = 'banana';//다중행 결과
select 제품명, 제조업체 from 제품
    where 제품번호 in (select 주문제품 from 주문 where 주문고객 = 'banana');
    
--banana 고객이 주문하지 않은 제품의 제품명 제조업체를 검색하시오
select 제품명, 제조업체 from 제품
    where 제품번호 not in (select 주문제품 from 주문 where 주문고객 = 'banana');
    
-- 대한식품이 제조한 모든 제품의 단가보다 비싼 제품의 제품명, 단가, 제조업체를 검색하시오
select 제품명, 단가, 제조업체 from 제품
    where 단가 > all (select 단가 from 제품 where 제조업체 = '대한식품');