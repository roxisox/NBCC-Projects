DELETE FROM MEMBER
WHERE memplan = 'T' OR email LIKE '%@bigcartel.com' OR email LIKE '%@weibo.com';

UPDATE MEMBER
SET MEMPLAN = 'P' 
where PROV = 'NS' AND memplan = 'S';

UPDATE MEMBER
SET MEMPLAN = 'S'
WHERE CITY= 'Fredericton' AND PROV = 'NB' AND MEMPLAN = 'B';

UPDATE MEMBER
SET MEMPLAN = 'P'
WHERE MEMID = 107825;