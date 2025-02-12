-- Membership records
INSERT INTO membership (mem_num, fname, lname, street, city, prov, postal, balance) VALUES ('102', 'TAMI','DAWSON','2632 TAKLI CIRCLE','FREDERICTON','NB','E4C 1X2',11);
INSERT INTO membership (mem_num, fname, lname, street, city, prov, postal, balance) VALUES ('103', 'CURT','KNIGHT','4025 CORNELL COURT','HALIFAX','NS','E2T 1T2',6);
INSERT INTO membership (mem_num, fname, lname, street, city, prov, postal, balance) VALUES ('104', 'JAMAL','MELENDEZ','788 EAST 145TH AVENUE','MONCTON','NB','E4T 1U2',0);
INSERT INTO membership (mem_num, fname, lname, street, city, prov, postal, balance) VALUES ('105', 'IVA','MCCLAIN','6045 MUSKET BALL CIRCLE','SUMMIT','NS','E4C 132',15);
INSERT INTO membership (mem_num, fname, lname, street, city, prov, postal, balance) VALUES ('106', 'MIRANDA','PARKS','4469 MAXWELL PLACE','GERMANTOWN','NB','E2H 152',0);
INSERT INTO membership (mem_num, fname, lname, street, city, prov, postal, balance) VALUES ('107', 'ROSARIO', 'ELLIOTT','7578 DANNER AVENUE','TRACEY','NB','E4C 1G2',5);
INSERT INTO membership (mem_num, fname, lname, street, city, prov, postal, balance) VALUES ('108', 'MATTIE','GUY','4390 EVERGREEN STREET','LILY','NS','E7C 1F2',0);
INSERT INTO membership (mem_num, fname, lname, street, city, prov, postal, balance) VALUES ('109', 'CLINT','OCHOA','1711 ELM STREET','GREENEVILLE','NB','E2K 1H2',10);
INSERT INTO membership (mem_num, fname, lname, street, city, prov, postal, balance) VALUES ('110', 'LEWIS','ROSALES','4524 SOUTHWIND CIRCLE','SUSSEX','NB','E7H 1X8',0);
INSERT INTO membership (mem_num, fname, lname, street, city, prov, postal, balance) VALUES ('111', 'STACY','MANN','2789 EAST COOK AVENUE ','DIEPPE','NB','E4C 1C2',8);
INSERT INTO membership (mem_num, fname, lname, street, city, prov, postal, balance) VALUES ('112', 'LUIS','TRUJILLO','7267 MELVIN AVENUE','ST. ANDREWS','NB','E4A 1X2',3);
INSERT INTO membership (mem_num, fname, lname, street, city, prov, postal, balance) VALUES ('113', 'MINNIE','GONZALES','6430 VASILI DRIVE','SAINT JOHN','NB','E3P 1X5',0);

-- Price records
insert into price (price_code, description, rent_fee, daily_late_fee) values ('1', 'Standard', 2, 1.5);
insert into price (price_code, description, rent_fee, daily_late_fee) values ('2', 'New Release', 3.5, 3);
insert into price (price_code, description, rent_fee, daily_late_fee) values ('3', 'Discount', 1.5, 1);
insert into price (price_code, description, rent_fee, daily_late_fee) values ('4', 'Weekly Special', 1, 0.5);

-- Game records
INSERT INTO game (ga_num, title, year, cost, genre, price_code) VALUES ('1234', 'BATTLEFIELD 1', '2016', 79.99, 'ACTION', '1');
INSERT INTO game (ga_num, title, year, cost, genre, price_code) VALUES ('1235', 'MASS Effect Andromeda','2017', 89.99, 'ACTION', '2');
INSERT INTO game (ga_num, title, year, cost, genre, price_code) VALUES ('1236', 'EverQuest', '1999', 59.95, 'RPG', '3');
INSERT INTO game (ga_num, title, year, cost, genre, price_code) VALUES ('1237', 'Fable II', '2010', 49.95, 'RPG', '3');
INSERT INTO game (ga_num, title, year, cost, genre, price_code) VALUES ('1238', 'Mario Kart 8 Deluxe', '2017', 89.95, 'RACING', '2');
INSERT INTO game (ga_num, title, year, cost, genre, price_code) VALUES ('1239', 'Blur', '2010', 29.49, 'RACING', '1');
INSERT INTO game (ga_num, title, year, cost, genre, price_code) VALUES ('1245', 'Grand Theft Auto V', '2012', 45.49, 'ACTION', '1');
INSERT INTO game (ga_num, title, year, cost, genre, price_code) VALUES ('1246', 'Halo 4', '2012', 58.29, 'ACTION', '1');
INSERT INTO game (ga_num, title, year, cost, genre, price_code) VALUES ('1247', 'Wipeout 3', '2012', 58.29, 'SIMULATION', '1');

-- Rental records
INSERT INTO rental (rent_num, rent_date, mem_num) VALUES ('1001', DATE '2017-03-01', '103');
INSERT INTO rental (rent_num, rent_date, mem_num) VALUES ('1002', DATE '2016-12-12', '105');
INSERT INTO rental (rent_num, rent_date, mem_num) VALUES ('1003', DATE '2016-11-13', '102');
INSERT INTO rental (rent_num, rent_date, mem_num) VALUES ('1004', DATE '2017-03-10', '110');
INSERT INTO rental (rent_num, rent_date, mem_num) VALUES ('1005', DATE '2017-02-04', '111');
INSERT INTO rental (rent_num, rent_date, mem_num) VALUES ('1006', DATE '2017-02-25', '107');
INSERT INTO rental (rent_num, rent_date, mem_num) VALUES ('1007', DATE '2016-12-12', '104');
INSERT INTO rental (rent_num, rent_date, mem_num) VALUES ('1008', DATE '2017-01-01', '105');
INSERT INTO rental (rent_num, rent_date, mem_num) VALUES ('1009', DATE '2016-10-12', '111');

-- Gamecopy records
INSERT INTO gamecopy (gc_num, indate, ga_num) VALUES ('34341', DATE '2017-01-22', '1235');
INSERT INTO gamecopy (gc_num, indate, ga_num) VALUES ('34342', DATE '2017-01-22', '1235');
INSERT INTO gamecopy (gc_num, indate, ga_num) VALUES ('34366', DATE '1999-03-02', '1236');
INSERT INTO gamecopy (gc_num, indate, ga_num) VALUES ('34367', DATE '1999-03-02', '1236');
INSERT INTO gamecopy (gc_num, indate, ga_num) VALUES ('34368', DATE '1999-03-02', '1236');
INSERT INTO gamecopy (gc_num, indate, ga_num) VALUES ('34369', DATE '1999-03-02', '1236');
INSERT INTO gamecopy (gc_num, indate, ga_num) VALUES ('44392', DATE '2010-10-21', '1237');
INSERT INTO gamecopy (gc_num, indate, ga_num) VALUES ('44397', DATE '2010-10-21', '1237');
INSERT INTO gamecopy (gc_num, indate, ga_num) VALUES ('54321', DATE '2016-06-18', '1234');
INSERT INTO gamecopy (gc_num, indate, ga_num) VALUES ('54324', DATE '2016-06-18', '1234');
INSERT INTO gamecopy (gc_num, indate, ga_num) VALUES ('54325', DATE '2016-06-18', '1234');
INSERT INTO gamecopy (gc_num, indate, ga_num) VALUES ('59237', DATE '2010-02-14', '1237');
INSERT INTO gamecopy (gc_num, indate, ga_num) VALUES ('61353', DATE '2013-01-28', '1245');
INSERT INTO gamecopy (gc_num, indate, ga_num) VALUES ('61354', DATE '2013-01-28', '1245');
INSERT INTO gamecopy (gc_num, indate, ga_num) VALUES ('61367', DATE '2012-07-30', '1246');
INSERT INTO gamecopy (gc_num, indate, ga_num) VALUES ('61369', DATE '2012-07-30', '1246');
INSERT INTO gamecopy (gc_num, indate, ga_num) VALUES ('61388', DATE '2010-01-25', '1239');

-- Detail rental records
INSERT INTO detailrental (rent_num, gc_num, fee, due_date, return_date, daily_late_fee) VALUES ('1001', '34342', 3.5, DATE '2017-03-04', DATE '2017-03-02', 3);
INSERT INTO detailrental (rent_num, gc_num, fee, due_date, return_date, daily_late_fee) VALUES ('1001', '34366', 1.5, DATE '2017-03-04', DATE '2017-03-03', 1);
INSERT INTO detailrental (rent_num, gc_num, fee, due_date, return_date, daily_late_fee) VALUES ('1001', '61353', 2, DATE '2017-03-04', DATE '2017-03-02', 1.5);
INSERT INTO detailrental (rent_num, gc_num, fee, due_date, return_date, daily_late_fee) VALUES ('1002', '59237', 1.5, DATE '2016-12-15', DATE '2016-12-15', 1);
INSERT INTO detailrental (rent_num, gc_num, fee, due_date, return_date, daily_late_fee) VALUES ('1003', '54325', 2, DATE '2016-11-16', DATE '2016-11-21', 1.5);
INSERT INTO detailrental (rent_num, gc_num, fee, due_date, return_date, daily_late_fee) VALUES ('1003', '61369', 2, DATE '2016-11-16', DATE '2016-11-18', 1.5);
INSERT INTO detailrental (rent_num, gc_num, fee, due_date, return_date, daily_late_fee) VALUES ('1003', '61388', 2, DATE '2016-11-16', DATE '2016-11-18', 1.5);
INSERT INTO detailrental (rent_num, gc_num, fee, due_date, return_date, daily_late_fee) VALUES ('1004', '34341', 3.5, DATE '2017-03-13', DATE '2017-03-13', 3);
INSERT INTO detailrental (rent_num, gc_num, fee, due_date, return_date, daily_late_fee) VALUES ('1004', '34367', 1.5, DATE '2017-03-13', DATE '2017-03-14', 1);
INSERT INTO detailrental (rent_num, gc_num, fee, due_date, return_date, daily_late_fee) VALUES ('1004', '44392', 1.5, DATE '2017-03-13', DATE '2017-03-12', 1);
INSERT INTO detailrental (rent_num, gc_num, fee, due_date, return_date, daily_late_fee) VALUES ('1005', '34342', 3.5, DATE '2017-02-07', DATE '2017-02-07', 3);
INSERT INTO detailrental (rent_num, gc_num, fee, due_date, return_date, daily_late_fee) VALUES ('1005', '44397', 1.5, DATE '2017-02-07', DATE '2017-02-06', 1);
INSERT INTO detailrental (rent_num, gc_num, fee, due_date, return_date, daily_late_fee) VALUES ('1006', '61367', 2, DATE '2017-02-28', NULL, 1.5);
INSERT INTO detailrental (rent_num, gc_num, fee, due_date, return_date, daily_late_fee) VALUES ('1007', '34368', 1.5, DATE '2016-12-15', NULL, 1);
INSERT INTO detailrental (rent_num, gc_num, fee, due_date, return_date, daily_late_fee) VALUES ('1008', '34369', 1.5, DATE '2017-01-04', DATE '2017-01-04', 1);
INSERT INTO detailrental (rent_num, gc_num, fee, due_date, return_date, daily_late_fee) VALUES ('1009', '54324', 2, DATE '2016-10-15', NULL, 1.5);
INSERT INTO DETAILRENTAL (RENT_NUM, GC_NUM, FEE, DUE_DATE, RETURN_DATE, DAILY_LATE_FEE) VALUES ('1006', '34366', 1.5, DATE '2017-02-28', DATE '2017-02-28', 1);
commit;