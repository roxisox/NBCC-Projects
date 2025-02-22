SET ECHO ON
SET LINESIZE 200
DROP TABLE PLAN CASCADE CONSTRAINTS;
DROP TABLE MEMBER CASCADE CONSTRAINTS;

Create TABLE MEMBER(
    memid CHAR(6) NOT NULL,
    fname VARCHAR2(25) NOT NULL,
    lname VARCHAR2(25),
    email VARCHAR2(30) NOT NULL ,
    memplan CHAR(1),
    city VARCHAR2(30),
    prov CHAR(2)
);

CREATE TABLE PLAN(
    memplan CHAR(1) NOT NULL,
    description VARCHAR2(20) NOT NULL ,
    cost NUMBER(5,2) DEFAULT 7.99 
);

ALTER TABLE MEMBER ADD CONSTRAINT PK_MEM_ID PRIMARY KEY (memid);

ALTER TABLE PLAN ADD CONSTRAINT PK_MEM_PLAN PRIMARY KEY (memplan);

ALTER TABLE MEMBER ADD CONSTRAINT FK_MEM_PLAN FOREIGN KEY (memplan) REFERENCES PLAN (memplan);

ALTER TABLE MEMBER ADD CONSTRAINT ck_email CHECK (email LIKE '%@%');

ALTER TABLE PLAN ADD CONSTRAINT ck_cost CHECK (cost BETWEEN 4.99 AND 129.99);

ALTER TABLE PLAN ADD CONSTRAINT ck_description UNIQUE (DESCRIPTION);

