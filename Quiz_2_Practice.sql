drop user c##alice;

drop view customeratstamford_putnam;
drop view CustomerAtStamford;

DROP TABLE customer CASCADE CONSTRAINTS;

CREATE TABLE customer (

    customer_name    VARCHAR(15) NOT NULL,
    customer_street  VARCHAR(12) NOT NULL,
    customer_city    VARCHAR(15) NOT NULL,
    PRIMARY KEY(customer_name)
    
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

create or replace view CustomerAtStamford as
select customer_name, customer_street
from customer
where customer_city = 'Stamford';

create or replace view CustomerAtStamford_Putnam as
select customer_name
from CustomerAtStamford
where customer_street = 'Putnam';

select * from customeratstamford;

select * from customeratstamford_putnam;

create user c##alice identified by cse302;

grant resource, connect, UNLIMITED TABLESPACE,
create table, create view to c##alice;

grant select, insert on CustomerAtStamford to c##alice;

select * from dba_sys_privs where grantee = 'C##ALICE';
select * from dba_tab_privs where grantee = 'C##ALICE';

select * from system.customeratstamford;

revoke insert on system.customeratstamford from c##alice;

select * from dba_sys_privs where grantee = 'C##ALICE';
select * from dba_tab_privs where grantee = 'C##ALICE';

