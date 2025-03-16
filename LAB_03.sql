DROP TABLE depositor CASCADE CONSTRAINTS;
DROP TABLE borrower CASCADE CONSTRAINTS;
DROP TABLE account CASCADE CONSTRAINTS;
DROP TABLE loan CASCADE CONSTRAINTS;
DROP TABLE customer CASCADE CONSTRAINTS;
DROP TABLE branch CASCADE CONSTRAINTS;


CREATE TABLE account (

    account_number  VARCHAR(15) NOT NULL,
    branch_name     VARCHAR(15) NOT NULL,
    balance         NUMBER      NOT NULL,
    PRIMARY KEY(account_number)
    
);

CREATE TABLE branch (

    branch_name  VARCHAR(15) NOT NULL,
    branch_city  VARCHAR(15) NOT NULL,
    assets       NUMBER      NOT NULL,
    PRIMARY KEY(branch_name)
    
);

CREATE TABLE customer (

    customer_name    VARCHAR(15) NOT NULL,
    customer_street  VARCHAR(12) NOT NULL,
    customer_city    VARCHAR(15) NOT NULL,
    PRIMARY KEY(customer_name)
    
);

CREATE TABLE loan (
    
    loan_number  VARCHAR(15) NOT NULL,
    branch_name  VARCHAR(15) NOT NULL,
    amount       NUMBER      NOT NULL,
    PRIMARY KEY(loan_number)
    
);

CREATE TABLE depositor (

    customer_name   VARCHAR(15) NOT NULL,
    account_number  VARCHAR(15) NOT NULL,
    PRIMARY KEY(customer_name, account_number),
    FOREIGN KEY(account_number) REFERENCES account(account_number),
    FOREIGN KEY(customer_name) REFERENCES customer(customer_name)
    
);

CREATE TABLE borrower (
    
    customer_name  VARCHAR(15) NOT NULL,
    loan_number    VARCHAR(15) NOT NULL,
    PRIMARY KEY(customer_name, loan_number),
    FOREIGN KEY(customer_name) REFERENCES customer(customer_name),
    FOREIGN KEY(loan_number) REFERENCES loan(loan_number)
    
);


INSERT INTO customer VALUES ('Jones', 'Main', 'Harrison');
INSERT INTO customer VALUES ('Smith', 'Main', 'Rye');
INSERT INTO customer VALUES ('Hayes', 'Main', 'Harrison');
INSERT INTO customer VALUES ('Curry', 'North', 'Rye');
INSERT INTO customer VALUES ('Lindsay', 'Park', 'Pittsfield');
INSERT INTO customer VALUES ('Turner', 'Putnam', 'Stamford');
INSERT INTO customer VALUES ('Williams', 'Nassau', 'Princeton');
INSERT INTO customer VALUES ('Adams', 'Spring', 'Pittsfield');
INSERT INTO customer VALUES ('Johnson', 'Alma', 'Palo Alto');
INSERT INTO customer VALUES ('Glenn', 'Sand Hill', 'Woodside');
INSERT INTO customer VALUES ('Brooks', 'Senator', 'Brooklyn');
INSERT INTO customer VALUES ('Green', 'Walnut', 'Stamford');
INSERT INTO customer VALUES ('Jackson', 'University', 'Salt Lake');
INSERT INTO customer VALUES ('Majeris', 'First', 'Rye');
INSERT INTO customer VALUES ('McBride', 'Safety', 'Rye');

INSERT INTO branch VALUES ('Downtown', 'Brooklyn', 900000);
INSERT INTO branch VALUES ('Redwood', 'Palo Alto', 2100000);
INSERT INTO branch VALUES ('Perryridge', 'Horseneck', 1700000);
INSERT INTO branch VALUES ('Mianus', 'Horseneck', 400200);
INSERT INTO branch VALUES ('Round Hill', 'Horseneck', 8000000);
INSERT INTO branch VALUES ('Pownal', 'Bennington', 400000);
INSERT INTO branch VALUES ('North Town', 'Rye', 3700000);
INSERT INTO branch VALUES ('Brighton', 'Brooklyn', 7000000);
INSERT INTO branch VALUES ('Central', 'Rye', 400280);

INSERT INTO account VALUES ('A-101', 'Downtown', 500);
INSERT INTO account VALUES ('A-215', 'Mianus', 700);
INSERT INTO account VALUES ('A-102', 'Perryridge', 400);
INSERT INTO account VALUES ('A-305', 'Round Hill', 350);
INSERT INTO account VALUES ('A-201', 'Perryridge', 900);
INSERT INTO account VALUES ('A-222', 'Redwood', 700);
INSERT INTO account VALUES ('A-217', 'Brighton', 750);
INSERT INTO account VALUES ('A-333', 'Central', 850);
INSERT INTO account VALUES ('A-444', 'North Town', 625);

INSERT INTO depositor VALUES ('Johnson', 'A-101');
INSERT INTO depositor VALUES ('Smith', 'A-215');
INSERT INTO depositor VALUES ('Hayes', 'A-102');
INSERT INTO depositor VALUES ('Hayes', 'A-101');
INSERT INTO depositor VALUES ('Turner', 'A-305');
INSERT INTO depositor VALUES ('Johnson', 'A-201');
INSERT INTO depositor VALUES ('Jones', 'A-217');
INSERT INTO depositor VALUES ('Lindsay', 'A-222');
INSERT INTO depositor VALUES ('Majeris', 'A-333');
INSERT INTO depositor VALUES ('Smith', 'A-444');

INSERT INTO loan VALUES ('L-17', 'Downtown', 1000);
INSERT INTO loan VALUES ('L-23', 'Redwood', 2000);
INSERT INTO loan VALUES ('L-15', 'Perryridge', 1500);
INSERT INTO loan VALUES ('L-14', 'Downtown', 1500);
INSERT INTO loan VALUES ('L-93', 'Mianus', 500);
INSERT INTO loan VALUES ('L-11', 'Round Hill', 900);
INSERT INTO loan VALUES ('L-16', 'Perryridge', 1300);
INSERT INTO loan VALUES ('L-20', 'North Town', 7500);
INSERT INTO loan VALUES ('L-21', 'Central', 570);

INSERT INTO borrower VALUES ('Jones', 'L-17');
INSERT INTO borrower VALUES ('Smith', 'L-23');
INSERT INTO borrower VALUES ('Hayes', 'L-15');
INSERT INTO borrower VALUES ('Jackson', 'L-14');
INSERT INTO borrower VALUES ('Curry', 'L-93');
INSERT INTO borrower VALUES ('Smith', 'L-11');
INSERT INTO borrower VALUES ('Williams', 'L-17');
INSERT INTO borrower VALUES ('Adams', 'L-16');
INSERT INTO borrower VALUES ('McBride', 'L-20');
INSERT INTO borrower VALUES ('Smith', 'L-21');


SELECT branch_name, branch_city FROM branch WHERE assets > 1000000;

SELECT account_number, balance FROM account
WHERE branch_name = 'Downtown'
UNION
SELECT account_number, balance FROM account
WHERE balance BETWEEN 600 AND 750;

SELECT a.account_number FROM account a
JOIN branch b ON a.branch_name = b.branch_name
WHERE b.branch_city = 'Rye';

SELECT l.loan_number
FROM loan l
JOIN borrower b ON b.loan_number = l.loan_number
JOIN customer C ON c.customer_name = b.customer_name
WHERE l.amount >= 1000
AND c.customer_city = 'Harrison';

SELECT * FROM account
ORDER BY balance DESC;

SELECT * FROM customer
ORDER BY customer_city;

SELECT c.customer_name
FROM customer c
JOIN depositor d ON c.customer_name = d.customer_name
INTERSECT
SELECT c.customer_name
FROM customer c
JOIN borrower b ON b.customer_name = c.customer_name;

SELECT c.customer_name, c.customer_street, c.customer_city
FROM customer c
JOIN depositor d ON c.customer_name = d.customer_name
UNION
SELECT c.customer_name, c.customer_street, c.customer_city
FROM customer c
JOIN borrower b ON c.customer_name = b.customer_name;


SELECT c.customer_name, c.customer_city
FROM customer c
JOIN borrower b ON b.customer_name = c.customer_name
MINUS
SELECT c.customer_name, c.customer_city
FROM customer c
JOIN depositor d ON c.customer_name = d.customer_name;

SELECT SUM(assets) AS total_assets
FROM branch;

SELECT b.branch_name, AVG(a.balance) AS avg_balance
FROM account a
JOIN branch b ON a.branch_name = b.branch_name
GROUP BY b.branch_name;

SELECT b.branch_city, AVG(a.balance) AS avg_balance
FROM account a
JOIN branch b ON a.branch_name = b.branch_name
GROUP BY b.branch_city;

SELECT b.branch_name, MIN(l.amount) AS lowest_loan
FROM loan l
JOIN branch b ON l.branch_name = b.branch_name
GROUP BY b.branch_name;

SELECT b.branch_name, COUNT(l.loan_number) AS number_of_loans
FROM loan l
JOIN branch b ON l.branch_name = b.branch_name
GROUP BY b.branch_name;

SELECT c.customer_name, a.account_number
FROM account a
JOIN depositor d ON d.account_number = a.account_number
JOIN customer c ON c.customer_name = d.customer_name
WHERE a.balance = (SELECT MAX(balance) FROM account);

