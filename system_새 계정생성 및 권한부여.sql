-- 새로운 오라클유저 생성
create user c##afk IDENTIFIED by 1234;

--새로운 유저에게 [권한] 부여
GRANT CONNECT, RESOURCE, DBA to c##afk;