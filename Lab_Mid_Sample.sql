drop table admissions;
drop table patients;
drop table doctors;

create table patients (

    patient_id INT PRIMARY KEY,
    patient_name VARCHAR2(20) not null,
    gender VARCHAR2(10) not null,
    admission_date DATE,
    discharge_date DATE,
    medical_condition VARCHAR2(20),
    CONSTRAINT date_check CHECK (admission_date < discharge_date)

);

create table doctors (

    doctor_id INT PRIMARY KEY,
    doctor_name VARCHAR2(20),
    specialization VARCHAR2(20),
    contact_number VARCHAR2(11),
    salary INT,
    CONSTRAINT salary_check CHECK (salary >= 20000)

);

create table admissions (

    admission_id INT PRIMARY KEY,
    patient_id INT REFERENCES patients(patient_id),
    doctor_id INT REFERENCES doctors(doctor_id)

);


INSERT INTO patients (patient_id, patient_name, gender, admission_date, discharge_date, medical_condition)
VALUES (101, 'Muhammad Yunus', 'Male', TO_DATE('2024-04-01', 'YYYY-MM-DD'), TO_DATE('2024-04-10', 'YYYY-MM-DD'), 'Flu');

INSERT INTO patients (patient_id, patient_name, gender, admission_date, discharge_date, medical_condition)
VALUES (102, 'Taslima Nasrin', 'Female', TO_DATE('2024-04-05', 'YYYY-MM-DD'), TO_DATE('2024-04-12', 'YYYY-MM-DD'), 'Fractured Leg');

INSERT INTO patients (patient_id, patient_name, gender, admission_date, discharge_date, medical_condition)
VALUES (103, 'Humayun Ahmed', 'Male', TO_DATE('2024-04-11', 'YYYY-MM-DD'), TO_DATE('2024-04-23', 'YYYY-MM-DD'), 'Appendicitis');

INSERT INTO patients (patient_id, patient_name, gender, admission_date, discharge_date, medical_condition)
VALUES (104, 'Jafor Iqbal', 'Male', TO_DATE('2024-04-08', 'YYYY-MM-DD'), TO_DATE('2024-04-11', 'YYYY-MM-DD'), 'Pneumonia');

INSERT INTO doctors (doctor_id, doctor_name, specialization, contact_number, salary)
VALUES (201, 'Dr. Jahid', 'Neurology', '01798354011', 45000);

INSERT INTO doctors (doctor_id, doctor_name, specialization, contact_number, salary)
VALUES (202, 'Dr. Kabir', 'Orthopedics', '01997085841', 67000);

INSERT INTO doctors (doctor_id, doctor_name, specialization, contact_number, salary)
VALUES (203, 'Dr. Topu', 'Cardiology', '01844442005', 80000);

INSERT INTO doctors (doctor_id, doctor_name, specialization, contact_number, salary)
VALUES (204, 'Dr. Gitanjali', 'Neurology', '01711910555', 90000);

INSERT INTO admissions (admission_id, patient_id, doctor_id)
VALUES (301, 101, 201);

INSERT INTO admissions (admission_id, patient_id, doctor_id)
VALUES (302, 102, 202);

INSERT INTO admissions (admission_id, patient_id, doctor_id)
VALUES (303, 103, 201);

INSERT INTO admissions (admission_id, patient_id, doctor_id)
VALUES (304, 104, 204);


with low_salary(value) as (

    select min(d1.salary) from doctors d1

)
select d2.doctor_name from doctors d2
where d2.salary = (select value from low_salary);

with patient_count(doc_id, value) as (
    
    select a1.doctor_id, count(a1.patient_id)
    from admissions a1
    group by a1.doctor_id
    
),
avg_count(value) as (

    select avg(p1.value)
    from patient_count p1

)
select d1.doctor_name
from doctors d1
join patient_count p2 on d1.doctor_id = p2.doc_id
where p2.value > (select value from avg_count);


select * from doctors
where lower(doctor_name) like '%m%'
and lower(doctor_name) like '%n%'
and specialization = 'Cardiology';


with doc_count(p_id, value) as (

    select patient_id, count(doctor_id)
    from admissions
    group by patient_id

)
select p.patient_name
from patients p
join doc_count dc on p.patient_id = dc.p_id
where dc.value > 1
order by p.patient_name desc;

create or replace view admission_under_neurology as
select p.patient_name
from patients p
join admissions a on p.patient_id = a.patient_id
join doctors d on d.doctor_id = a.doctor_id
where d.specialization = 'Neurology';



select * from admission_under_neurology;







