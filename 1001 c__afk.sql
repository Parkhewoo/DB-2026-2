--집계 함수: sum, avg <= 숫자데이터 컬럼만 사용가능
--count, min, max <= 모든데이터에 사용 가능
--select절 또는 having 절이 사용

--고객 테이블에서 나이의 평균을 검색해보자

select avg(나이) as 고객나이평균 from 고객;

--고객테이블에서 성이 '김' 또는 '최' 또는 '오'인 고객의 나이 평균을 검색하시오(단, 나이 평균은 소수점 이하 2째자리 까지 표시하시오)
select round (avg(나이),2) 평균 from 고객
        where 고객이름 like '김%' or 고객이름 like '최%' or 고객이름 like '오%';
--제품테이블에서 제조업체가 한빛제과 또는 대한식품인 제품의 단가 평균을 검색하시오
select round (avg(단가),3) as 평균 from 제품
        where 제조업체 in ('한빛제과', '대한식품');
select to_char(avg(단가), 'FM990.000') 단가평균 from 제품
        where 제조업체 in ('한빛제과', '대한식품');
--sum: 합계함수
-- 한빛제과에서 제조한 제품의 재고량 합계를 제품테이블에서 검색하시오
select sum(재고량) 합계 from 제품
    where 제조업체 like '한빛제과';
    
--count 함수
select * from 고객;
-- 고객테이블에서 고객의 수를 구하시오
select count(*) from 고객;
select count(고객이름) from 고객;
--나이 컬럼의 null값은 제외된다.
select count(나이) from 고객;

--제품테이블에서 제조업체가 대한식품인 제품의 개수를 구하시오
select count(재고량) from 제품
    where 제조업체 like '대한식품';
    
--주문테이블에서 apple 주문고객이 주문한 수량의 합계와 주문한 제품의 개수를 구하시오
select sum(수량) as 합계, count(주문번호) as 개수 from 주문
    where 주문고객 like 'apple';
select * from 주문;

--제품테이블에서 제조업체명을 표시하시오.(중복되는 제조업체는 제거하시오)
select distinct 제조업체 from 제품;

--제품 테이블에서 참여한 제조업체의 수를 구하시오.(중복되는 제조업체는 제거하시오)
select count(distinct 제조업체) 참여제조업체수 from 제품;

--제품테이블에서 제조업체명에 '한'이 포함된 참여한 제조업체의 수를 구하시오(중복되는 제조업체는 제거하시오)
select count(distinct 제조업체) "한이 들어간 제조업체" from 제품
    where 제조업체 like '%한%';
    
--주문테이블에서 주문고객별 수량의 합계를 구하시오
select 주문고객, sum(수량) 총주문수량 from 주문
    group by 주문고객;
    
--제품테이블에서 제조업체별로 제조한 제품의 개수와 제품 중 가장 비싼단가를 검색하되 
--제품의 개수는 재퓸수, 가장 비싼단가는 최고가라고 출력하시오
select 제조업체, count(*) 제품수, max(단가) 최고가 from 제품
    group by 제조업체;
    
--주문테이블에서 주문고객별로 주문한 제품의 개수와 주문수량 중 가장 작은 수량을 검색
--(단, 주문한 제품의 개수는 주문제품수, 가장 작은 수량은 최소수량으로 출력하시오
select 주문고객, count(*) 주문제품수, min(수량) 최소수량 from 주문
    group by 주문고객;
    
-- 제품테이블에서 제품을 3개이상 제조업체별로 제품의 개수와 가장 비싼 단가를 출력하시오
select 제조업체, count(*) 제품수, max(단가) 최고가 from 제품
    group by 제조업체
    having count(*) >= 3;
    
--고객테이블에서 적립금의 합계가 2000원 미만 직업별 최고령자의 나이와 최연소자의 나이를 출력하시오
select 직업, max(나이) 최고령나이, min(나이) 최연소나이 from 고객
    group by 직업
    having sum(적립금) < 2000;