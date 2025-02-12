-- Populate PLAN table
INSERT INTO PLAN (memplan, description, cost) VALUES ('P', 'Premium', 39.99);
INSERT INTO PLAN (memplan, description, cost) VALUES ('S', 'Standard', 19.99);
INSERT INTO PLAN (memplan, description, cost) VALUES ('B', 'Basic', 12.99);
INSERT INTO PLAN (memplan, description) VALUES ('T', 'Trial');


-- Populate MEMBER table
INSERT INTO MEMBER (memid, fname, lname, email, memplan, city, prov) VALUES ('100001', 'Shaquille', 'Oatmeal', 'shaqo@nbcc.ca', 'B', 'Fredericton', 'NB');
INSERT INTO MEMBER (memid, fname, lname, email, memplan, city, prov) VALUES ('100002', 'Bread', 'Pitt', 'bpitt@nbcc.ca', 'S', 'Saint John', 'NB');
INSERT INTO MEMBER (memid, fname, lname, email, memplan, city, prov) VALUES ('100003', 'Beytwice', 'Knowles', 'beyk@nbcc.ca', 'P', 'Halifax', 'NS');



SELECT * FROM PLAN;
SELECT * FROM MEMBER;

