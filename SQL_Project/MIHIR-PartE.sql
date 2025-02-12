--1--
SELECT SUM(p.cost) AS TOTAL_REVENUE
from MEMBER m
join PLAN p
ON M.MEMPLAN = p.MEMPLAN;

--2--
SELECT count(MEMPLAN)  from MEMBER WHERE MEMPLAN = 'T';

--3--
SELECT description, SUM(p.cost) AS TOTAL_REVENUE
from MEMBER m
join PLAN p
ON M.MEMPLAN = p.MEMPLAN
GROUP BY DESCRIPTION
ORDER BY description ASC;

--4--
SELECT description, SUM(p.cost) AS TOTAL_REVENUE
from MEMBER m
join PLAN p
ON M.MEMPLAN = p.MEMPLAN
WHERE M.PROV= 'NB'
GROUP BY DESCRIPTION
ORDER BY description ASC;

--5--
SELECT description, SUM(p.cost) AS TOTAL_REVENUE
from MEMBER m
join PLAN p
ON M.MEMPLAN = p.MEMPLAN
GROUP BY DESCRIPTION
HAVING SUM(p.cost) >= 5000
ORDER BY description ASC;

--6--
SELECT LNAME||', '||FNAME AS Member_Name , M.CITY , description
from MEMBER m
join PLAN p
ON m.MEMPLAN = p.MEMPLAN
where (m.memplan = 'P' or  m.memplan = 'S') AND m.prov = 'ON'
ORDER BY CITY DESC, LNAME ASC;