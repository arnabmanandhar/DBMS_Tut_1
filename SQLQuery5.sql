CREATE DATABASE db7;

CREATE TABLE tbl_Employee (
        employee_name VARCHAR(255) NOT NULL,
        street VARCHAR(255) NOT NULL,
        city VARCHAR(255) NOT NULL,
        PRIMARY KEY(employee_name)
    );
 
 
CREATE TABLE tbl_Works (
        employee_name VARCHAR(255) NOT NULL,
        FOREIGN KEY (employee_name) REFERENCES tbl_Employee(employee_name),
        company_name VARCHAR(255),
        salary DECIMAL(10, 2)
    );
 
CREATE TABLE tbl_Company (
        company_name VARCHAR(255) NOT NULL,
        city VARCHAR(255),
        PRIMARY KEY(company_name)
    );
 
CREATE TABLE tbl_Manages (
        employee_name VARCHAR(255) NOT NULL,
        FOREIGN KEY (employee_name) REFERENCES tbl_Employee(employee_name),
        manager_name VARCHAR(255)
    );
 
INSERT INTO tbl_Employee (employee_name, street, city)
VALUES  ('Alice Williams','321 Maple St','Houston'), 
		('Sara Davis','159 Broadway','New York'), 
		('Mark Thompson','235 Fifth Ave','New York'), 
		('Ashley Johnson','876 Market St','Chicago'), 
		('Emily Williams','741 First St','Los Angeles'),
		('Michael Brown','902 Main St','Houston'),
		('Samantha Smith','111 Second St','Chicago');
 
INSERT INTO tbl_Employee (employee_name, street, city)
VALUES ('Patrick','123 Main St','New Mexico');
INSERT INTO tbl_Employee (employee_name, street, city)
VALUES ('John Smith','123 Main St','New Mexico'),('Jane Doe','121 First St','Los Angeles');

 
INSERT INTO tbl_Works (employee_name,company_name,salary )
VALUES ('Patrick','Pongyang Corporation',500000);
 
INSERT INTO tbl_Works (employee_name,company_name,salary)
VALUES  ('Sara Davis','First Bank Corporation',82500.00), 
		('Mark Thompson','Small Bank Corporation',78000.00),
		('Ashley Johnson','Small Bank Corporation',92000.00), 
		('Emily Williams','Small Bank Corporation',86500.00), 
		('Michael Brown','Small Bank Corporation',81000.00), 
		('Samantha Smith','Small Bank Corporation',77000.00);
 
INSERT INTO
    tbl_Company (company_name, city)
VALUES  ('Small Bank Corporation', 'Chicago'), 
        ('ABC Inc', 'Los Angeles'), 
        ('Def Co', 'Houston'), 
        ('First Bank Corporation','New York'), 
        ('456 Corp', 'Chicago'), 
        ('789 Inc', 'Los Angeles'), 
        ('321 Co', 'Houston'),
        ('Pongyang Corporation','Chicago'
    );
 
INSERT INTO
    tbl_Manages(employee_name, manager_name)
VALUES  ('Mark Thompson', 'Emily Williams'),
		('John Smith', 'Jane Doe'),
		('Emily Williams','Jane Doe'),
		('Alice Williams', 'Emily Williams'),
		('Samantha Smith', 'Sara Davis'),
		('Patrick', 'Jane Doe');
 
INSERT INTO tbl_Manages(employee_name, manager_name)
VALUES ('Emily Williams','Jane Doe');

DROP TABLE tbl_Manages;
 
-- Update the value of salary to 1000 where employee name= John Smith and company_name = First Bank Corporation
UPDATE tbl_Works
SET salary = '1000'
WHERE
    employee_name = 'John Smith'
AND company_name = 'First Bank Corporation';


--2
--a
	SELECT employee_name AS EMP
	FROM tbl_Employee
	WHERE employee_name = (SELECT employee_name FROM tbl_Employee, tbl_Works 
							WHERE tbl_Works.company_name= 'First Bank Corporation'); 


(a)
SELECT employee_name FROM tbl_employee WHERE employee_name IN (SELECT employee_name FROM tbl_works WHERE company_name = 'First Bank Corporation');

(b) 
SELECT employee_name, city FROM tbl_employee WHERE employee_name IN (SELECT employee_name FROM tbl_works WHERE company_name = 'First Bank Corporation');

(c) 
SELECT employee_name, street, city FROM tbl_employee WHERE employee_name IN (SELECT employee_name FROM tbl_works WHERE company_name = 'First Bank Corporation' AND salary > 10000);

(d) 
SELECT employee_name FROM tbl_employee WHERE city IN (SELECT city FROM tbl_company WHERE company_name IN (SELECT company_name FROM tbl_works WHERE tbl_works.employee_name = tbl_employee.employee_name));

(e) 
SELECT employee_name 
FROM tbl_employee
WHERE city = (SELECT city FROM tbl_employee 
WHERE employee_name = (SELECT manager_name FROM tbl_manages WHERE employee_name = tbl_employee.employee_name))
AND street = (SELECT street FROM tbl_employee WHERE employee_name = (SELECT manager_name FROM tbl_manages 
WHERE employee_name = tbl_employee.employee_name));