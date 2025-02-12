SET ECHO ON
SET LINESIZE 200
DROP TABLE membership CASCADE CONSTRAINTS;
DROP TABLE Rental CASCADE CONSTRAINTS;
DROP TABLE detailrental CASCADE CONSTRAINTS;
DROP TABLE Gamecopy CASCADE CONSTRAINTS;
DROP TABLE Game CASCADE CONSTRAINTS;
DROP TABLE price CASCADE CONSTRAINTS;

Create TABLE membership(
    mem_num CHAR(4) NOT NULL,
    fname VARCHAR2(30) NOT NULL,
    lname VARCHAR2(30) NOT NULL,
    street VARCHAR2(120),
    city VARCHAR2(50),
    prov CHAR(2),
    postal CHAR(7),
    balance NUMBER(10,2)
);

CREATE TABLE price(
    price_code CHAR(2) NOT NULL,
    description VARCHAR2(20) NOT NULL,
    rent_fee NUMBER(5,2) NOT NULL,
    daily_late_fee NUMBER(5,2) NOT NULL
);

CREATE TABLE game(
    ga_num CHAR(5) NOT NULL,
    title VARCHAR2(75) NOT NULL,
    year CHAR(4) NOT NULL,
    cost NUMBER(5,2) NOT NULL,
    genre VARCHAR2(50) NOT NULL,
    price_code CHAR(2) NOT NULL
);

CREATE TABLE rental(
    rent_num CHAR(5) NOT NULL,
    rent_date DATE NOT NULL ,
    mem_num CHAR(4) NOT NULL 
);

CREATE TABLE gamecopy(
    gc_num CHAR(6) NOT NULL,
    indate DATE NOT NULL,
    ga_num CHAR(5)
);

CREATE TABLE detailrental(
    rent_num CHAR(5) NOT NULL,
    gc_num CHAR(6) NOT NULL,
    fee NUMBER(5,2) NOT NULL,
    due_date DATE NOT NULL,
    return_date DATE,
    daily_late_fee NUMBER(5,2) NOT NULL
);

ALTER TABLE membership ADD CONSTRAINT PK_MEM_NUM PRIMARY KEY (mem_num);
ALTER TABLE rental ADD CONSTRAINT PK_RENT_NUM PRIMARY KEY (rent_num);
ALTER TABLE gamecopy ADD CONSTRAINT PK_GC_NUM PRIMARY KEY (gc_num);
ALTER TABLE game ADD CONSTRAINT PK_GA_NUM PRIMARY KEY (ga_num);
ALTER TABLE price ADD CONSTRAINT PK_PRICE_CODE PRIMARY KEY (price_code);
ALTER TABLE detailrental ADD CONSTRAINT PK_RENT_NUM_DETAILED_GC_NUM PRIMARY KEY (rent_num, GC_NUM);

--ALTER TABLE detailrental ADD CONSTRAINT PK_GC_NUM_DETAILED PRIMARY KEY (GC_NUM);

ALTER TABLE rental ADD CONSTRAINT FK_MEM_NUM FOREIGN KEY (mem_num) REFERENCES membership (mem_num);
ALTER TABLE gamecopy ADD CONSTRAINT FK_GA_NUM FOREIGN KEY (ga_num) REFERENCES game (ga_num);
ALTER TABLE game ADD CONSTRAINT FK_PRICE_CODE FOREIGN KEY (price_code) REFERENCES price (price_code);
ALTER TABLE detailrental ADD CONSTRAINT FK_RENT_NUM FOREIGN KEY (rent_num) REFERENCES rental (rent_num);
ALTER TABLE detailrental ADD CONSTRAINT FK_GC_NUM FOREIGN KEY (gc_num) REFERENCES gamecopy (gc_num);


---1
--a
ALTER TABLE membership ADD CONSTRAINT CK_CHECK_BALANCE CHECK (balance >= 0);
--e
ALTER TABLE game ADD CONSTRAINT CK_YEAR CHECK (year >= 1970);
--f
ALTER TABLE price ADD CONSTRAINT CK_RENT_FEE CHECK (rent_fee >= 0);
ALTER TABLE price ADD CONSTRAINT CK_DAILY_LATE_FEE CHECK (daily_late_fee >= 0);

--2
alter session set nls_date_format='yyyy-mm-dd';

--3
commit;

--4
UPDATE game set YEAR = '2013' where GA_NUM = '1245';
commit;
--SELECT * FROM game;

--5
UPDATE GAME set PRICE_CODE = '4' where GENRE = 'SIMULATION';
commit;
--SELECT * from game;

--6
UPDATE price set RENT_FEE = RENT_FEE + .50;
commit;
--SELECT * from price;

--7 
--As you said i commit everything after the query for 7;

--8
SELECT GENRE, TITLE, YEAR, cost FROM GAME 
ORDER by GENRE ASC,YEAR DESC;

--9
SELECT MEM_NUM AS "Member #", LNAME||','||FNAME AS "Member Name", TO_CHAR(BALANCE, '$9999.99') as BALANCE FROM MEMBERSHIP;

--10
ALTER TABLE MEMBERSHIP ADD  STATUS CHAR(8) CHECK (Status IN ('ACTIVE', 'SUSPEND', 'CLOSED')); 
SELECT MEM_NUM AS "Member #", LNAME||','||FNAME AS "Member Name", TO_CHAR(BALANCE, '$9999.99') as BALANCE, STATUS  FROM MEMBERSHIP;

--11
update MEMBERSHIP SET status = 'ACTIVE' 
where mem_num IN(SELECT MEM_NUM FROM RENTAL );
SELECT MEM_NUM AS "Member #", LNAME||','||FNAME AS "Member Name", TO_CHAR(BALANCE, '$9999.99') as BALANCE, STATUS  FROM MEMBERSHIP;

--12
SELECT GENRE, TITLE, YEAR, COST 
FROM  GAME 
where lower(TITLE) LIKE '%ef%'
ORDER by GENRE ASC, YEAR DESC;

--13
SELECT GENRE, TITLE, year, COST 
FROM GAME 
WHERE COST =any(SELECT COST FROM GAME where COST < 60) 
AND GENRE in ('RPG','RACING')
ORDER by GENRE ASC, TITLE ASC;

--14
SELECT GENRE, COUNT(GENRE) AS "# IN STOCK" FROM GAME
GROUP BY GENRE; 

--15 
SELECT TO_CHAR(AVG(COST), '$9999.99') AS "AVG. GAM"  FROM GAME;

--16
SELECT GENRE, AVG(COST) AS "AVG. GAME COST" FROM GAME
GROUP BY GENRE 
ORDER BY GENRE ASC;

--17
SELECT 
g.TITLE AS "Game Title", 
g.GENRE AS "Genre", 
DESCRIPTION AS "Pricing Description", 
TO_CHAR(RENT_FEE, '$9999.99') AS "Rental Fee",
TO_CHAR(g.COST, '$9999.99') AS "Game Cost" 
FROM price p
join game g ON p.PRICE_CODE = g.PRICE_CODE; 

--18
SELECT g.GENRE as "Genre",TO_CHAR(avg(RENT_FEE), '$9999.99') AS "Avg. Fee"
FROM price p
join game g ON p.PRICE_CODE = g.PRICE_CODE
GROUP by GENRE
order by genre ASC; 

--19
SELECT GENRE, TITLE, COST FROM GAME g where cost >any (SELECT avg(cost) FROM GAME where GENRE = g.GENRE);

--20
UPDATE game g set cost = cost - 2.50 where cost > any (select avg(cost) from game where GENRE = g.genre);
SELECT GENRE, TITLE, COST FROM GAME g where cost >any (SELECT avg(cost) FROM GAME where GENRE = g.GENRE);
commit;

--21
SELECT TITLE, YEAR, TO_CHAR(COST/p.RENT_FEE, '9999.99') as "BER#" FROM GAME g join price p on g.PRICE_CODE = p.PRICE_CODE ORDER by G.TITLE;

--22
SELECT MEM_NUM as "Member #", FNAME||','||LNAME as "Customer Name", TO_CHAR(BALANCE, '$9999.99') AS "BALANCE" 
FROM MEMBERSHIP 
where mem_num in(SELECT MEM_NUM FROM RENTAL)
ORDER BY LNAME asc;

--23
SELECT
r.RENT_NUM as "Rental #", 
TO_CHAR(r.RENT_DATE, 'yyyy-mm-dd') as "Rented On", 
g.TITLE as "Game Title", 
TO_CHAR(p.RENT_FEE, '$9999.99') as "Rental Fee" 
FROM RENTAL r
join DETAILRENTAL dl on r.RENT_NUM = dl.RENT_NUM
join GAMECOPY gc on dl.GC_NUM = gc.GC_NUM
join game g on gc.ga_num = g.GA_NUM
join price p on g.PRICE_CODE = p.PRICE_CODE
where dl.return_date <= all (SELECT DL.DUE_DATE from RENTAL);

--24
SELECT r.RENT_NUM AS "Rental #", 
gc.GC_NUM as "Copy Number", 
g.TITLE as "Game Title",
TO_CHAR(r.RENT_DATE, 'yyyy-mm-dd') as "Rented On",
TO_CHAR(dl.DUE_DATE, 'yyyy-mm-dd') as "Due Back By", 
TO_CHAR(dl.RETURN_DATE, 'yyyy-mm-dd') as "Return On" 
FROM RENTAL r
join DETAILRENTAL dl on r.RENT_NUM = dl.RENT_NUM
join GAMECOPY gc on dl.GC_NUM = gc.GC_NUM
join game g on gc.ga_num = g.GA_NUM
join price p on g.PRICE_CODE = p.PRICE_CODE 
where dl.DUE_DATE < all (SELECT dl.RETURN_DATE from RENTAL)
ORder by r.RENT_NUM, G.TITLE;

--25
SELECT r.RENT_NUM AS "Rental #", 
gc.GC_NUM as "Copy Number", 
g.TITLE as "Game Title",
TO_CHAR(r.RENT_DATE, 'yyyy-mm-dd') as "Rented On",
TO_CHAR(dl.DUE_DATE, 'yyyy-mm-dd') as "Due Back By", 
TO_CHAR(dl.RETURN_DATE, 'yyyy-mm-dd') as "Return On",
(DL.RETURN_DATE - DL.DUE_DATE) AS "Days Late"
FROM RENTAL r
join DETAILRENTAL dl on r.RENT_NUM = dl.RENT_NUM
join GAMECOPY gc on dl.GC_NUM = gc.GC_NUM
join game g on gc.ga_num = g.GA_NUM
join price p on g.PRICE_CODE = p.PRICE_CODE
where dl.DUE_DATE < all (SELECT dl.RETURN_DATE from RENTAL) 
ORder by r.RENT_NUM, G.TITLE;

--26
SELECT r.RENT_NUM AS "Rental #", 
gc.GC_NUM as "Copy Number", 
g.TITLE as "Game Title",
TO_CHAR(r.RENT_DATE, 'yy-mm-dd') as "Rented On",
TO_CHAR(dl.DUE_DATE, 'yy-mm-dd') as "Due Back By", 
TO_CHAR(dl.RETURN_DATE, 'yy-mm-dd') as "Return On",
(DL.RETURN_DATE - DL.DUE_DATE) AS "Days Late",
TO_CHAR((DL.RETURN_DATE - DL.DUE_DATE) * DL.DAILY_LATE_FEE, '$9999.99') AS "Late Fees Paid"
FROM RENTAL r
join DETAILRENTAL dl on r.RENT_NUM = dl.RENT_NUM
join GAMECOPY gc on dl.GC_NUM = gc.GC_NUM
join game g on gc.ga_num = g.GA_NUM
join price p on g.PRICE_CODE = p.PRICE_CODE
where dl.DUE_DATE < all (SELECT dl.RETURN_DATE from RENTAL) 
ORder by r.RENT_NUM, G.TITLE;

--27
SELECT r.RENT_NUM AS "Rental #", 
gc.GC_NUM as "Copy Number", 
g.TITLE as "Game Title",
TO_CHAR(r.RENT_DATE, 'yy-mm-dd') as "Rented On",
TO_CHAR(dl.DUE_DATE, 'yy-mm-dd') as "Due Back By",
TO_CHAR((SYSDATE - dl.DUE_DATE), '99999') AS "Days Late",
TO_CHAR((SYSDATE - DL.DUE_DATE) * p.DAILY_LATE_FEE, '$9999.99') AS "Late Fees Owing"
FROM RENTAL r
join DETAILRENTAL dl on r.RENT_NUM = dl.RENT_NUM
join GAMECOPY gc on dl.GC_NUM = gc.GC_NUM
join game g on gc.ga_num = g.GA_NUM
join price p on g.PRICE_CODE = p.PRICE_CODE
where dl.RETURN_DATE IS NULL-- AND dl.DUE_DATE >= ANY (SELECT dl.RETURN_DATE from RENTAL) 
ORder by r.RENT_NUM, G.TITLE;

--28


--1

SELECT g.ga_num, g.title, COUNT(gc.gc_num) AS num_available_copies
FROM game g
JOIN gamecopy gc ON g.ga_num = gc.ga_num
LEFT JOIN detailrental dr ON gc.gc_num = dr.gc_num AND dr.return_date IS NULL
GROUP BY g.ga_num, g.title;
