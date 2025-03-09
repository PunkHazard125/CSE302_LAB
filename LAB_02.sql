/* Dropping the tables if they already exist,
delete the drop statements if no such tables exist in the current database connection */
DROP TABLE depositor;
DROP TABLE account;
DROP TABLE customer;


CREATE TABLE account (

    account_no CHAR(5) PRIMARY KEY,
    balance NUMBER NOT NULL CHECK (balance >= 0)

);

CREATE TABLE customer (

    customer_no CHAR(5) PRIMARY KEY,
    customer_name VARCHAR2(20) NOT NULL,
    customer_city VARCHAR2(10)

);

CREATE TABLE depositor (

    account_no CHAR(5),
    customer_no CHAR(5),
    PRIMARY KEY (account_no, customer_no)

);


ALTER TABLE customer ADD date_of_birth VARCHAR2(10);
ALTER TABLE customer DROP COLUMN date_of_birth;

ALTER TABLE depositor RENAME COLUMN account_no TO a_no;
ALTER TABLE depositor RENAME COLUMN customer_no TO c_no;

ALTER TABLE depositor ADD CONSTRAINT depositor_fk1 FOREIGN KEY (a_no) REFERENCES account (account_no);
ALTER TABLE depositor ADD CONSTRAINT depositor_fk2 FOREIGN KEY (c_no) REFERENCES customer (customer_no);


INSERT INTO account VALUES ('A-101', 12000);
INSERT INTO account VALUES ('A-102', 6000);
INSERT INTO account VALUES ('A-103', 2500);

INSERT INTO customer VALUES ('C-101', 'Alice', 'Dhaka');
INSERT INTO customer VALUES ('C-102', 'Annie', 'Dhaka');
INSERT INTO customer VALUES ('C-103', 'Bob', 'Chittagong');
INSERT INTO customer VALUES ('C-104', 'Charlie', 'Khulna');

INSERT INTO depositor VALUES ('A-101', 'C-101');
INSERT INTO depositor VALUES ('A-103', 'C-102');
INSERT INTO depositor VALUES ('A-103', 'C-104');
INSERT INTO depositor VALUES ('A-102', 'C-103');


SELECT customer_name, customer_city FROM customer;
SELECT DISTINCT customer_city FROM customer;
SELECT account_no FROM account WHERE balance > 7000;
SELECT customer_no, customer_name FROM customer WHERE customer_city = 'Khulna';
SELECT customer_no, customer_name FROM customer WHERE customer_city != 'Dhaka';

SELECT c.customer_name, c.customer_city
FROM customer c
JOIN depositor d on c.customer_no = d.c_no
JOIN account a on d.a_no = a.account_no
WHERE a.balance > 7000;

SELECT c.customer_name, c.customer_city
FROM customer c
JOIN depositor d on c.customer_no = d.c_no
JOIN account a on d.a_no = a.account_no
WHERE a.balance > 7000 AND c.customer_city != 'Khulna';

SELECT a.account_no, a.balance
FROM account a
JOIN depositor d on d.a_no = a.account_no
JOIN customer c on c.customer_no = d.c_no
WHERE c.customer_city IN ('Dhaka', 'Khulna');

SELECT *
FROM customer c
LEFT JOIN depositor d on c.customer_no = d.c_no
WHERE d.c_no IS NULL;

