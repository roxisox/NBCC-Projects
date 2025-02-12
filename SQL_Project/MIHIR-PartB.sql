-- Try to insert a duplicate primary key 
INSERT INTO MEMBER (memid, fname, lname, email, memplan, city, prov) VALUES ('M001', 'Jane', 'Doe', 'jane.doe@example.com', 'A', 'City2', 'NY');
INSERT INTO PLAN (MEMPLAN, DESCRIPTION, COST) VALUES ('A', 'complex', 11.111);

-- Try to insert invalid email format
INSERT INTO MEMBER (memid, fname, lname, email, memplan, city, prov) VALUES ('M002', 'Bob', 'Smith', 'invalidemail', 'A', 'City3', 'TX');

-- Try to insert data with foreign key constraint violation
INSERT INTO MEMBER (memid, fname, lname, email, memplan, city, prov) VALUES ('M003', 'Alice', 'Johnson', 'alice.j@example.com', 'Z', 'City4', 'FL');

-- Try to update data violating check constraint on cost
UPDATE PLAN SET cost = 200 WHERE memplan = 'A';

--Try to input NULL VALUES 
INSERT INTO MEMBER (memid, fname, lname, email, memplan, city, prov) VALUES ('213', '', 'Doe', 'jane.doe@example.com', 'T', 'City2', 'NY');
INSERT INTO MEMBER (memid, fname, lname, email, memplan, city, prov) VALUES ('345', 'dfd', 'Doe', '', 'C', 'City2', 'NY');

INSERT INTO PLAN (MEMPLAN, DESCRIPTION, COST) VALUES ('z', '', 11.111);

-- Try to update data violating unique constraint on description
UPDATE PLAN SET description = 'Basic' WHERE memplan = 'B';

