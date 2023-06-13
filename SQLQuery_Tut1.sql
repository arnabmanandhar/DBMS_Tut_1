-----------------------------------------------------------------------------------------------------------------
		TUTORIAL 1
-- Date		: Monday, June 12, 2023
-- Author	: Arnab Manandhar
-- Roll		: THA077BEI008
------------------------------------------------------------------------------------------------------------------

--		tbl_employee(employee_name, street, city) 
--		tbl_works(employee_name, company_name, salary) 
--		tbl_company(company_name, city)
--		tbl_manages (employee_name, manager_name) 
--					Figure:Employee Database

--Q1.	Give an SQL schema deﬁnition for the employee database of the above figure. Choose an appropriate primary key 
--		for each relation schema, and insert any other integrity constraints (for example, foreign keys) you ﬁnd necessary.

CREATE DATABASE db7;
DROP DATABASE db7;

CREATE TABLE tbl_Employee (
        employee_name VARCHAR(255) NOT NULL,
        street VARCHAR(255) NOT NULL,
        city VARCHAR(255) NOT NULL,
        PRIMARY KEY(employee_name)
    );
 DROP TABLE tbl_Employee;
 SELECT * FROM tbl_Employee;
 
CREATE TABLE tbl_Works (
        employee_name1 VARCHAR(255) NOT NULL,
        FOREIGN KEY (employee_name1) REFERENCES tbl_Employee(employee_name),
        company_name VARCHAR(255),
        salary DECIMAL(10, 2)
    );
DROP TABLE tbl_Works;
SELECT * FROM tbl_Works;

CREATE TABLE tbl_Company (
        company_name VARCHAR(255) NOT NULL,
        city VARCHAR(255),
        PRIMARY KEY(company_name)
    );
DROP TABLE tbl_Company;
SELECT * FROM tbl_Company;
 
CREATE TABLE tbl_Manages (
        employee_name2 VARCHAR(255) NOT NULL,
        FOREIGN KEY (employee_name2) REFERENCES tbl_Employee(employee_name),
        manager_name VARCHAR(255)
    );

DROP TABLE tbl_Manages;
SELECT * FROM tbl_Manages;

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

 
INSERT INTO tbl_Works (employee_name1,company_name,salary )
VALUES ('Patrick','Pongyang Corporation',500000);
 
INSERT INTO tbl_Works (employee_name1,company_name,salary)
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
    tbl_Manages(employee_name2, manager_name)
VALUES  ('Mark Thompson', 'Emily Williams'),
		('John Smith', 'Jane Doe'),
		('Emily Williams','Jane Doe'),
		('Alice Williams', 'Emily Williams'),
		('Samantha Smith', 'Sara Davis'),
		('Patrick', 'Jane Doe');
 
INSERT INTO tbl_Manages(employee_name2, manager_name)
VALUES ('Emily Williams','Jane Doe');

DROP TABLE tbl_Manages;
 
-- Update the value of salary to 1000 where employee name= John Smith and company_name = First Bank Corporation
UPDATE tbl_Works
SET salary = '1000'
WHERE
    employee_name1 = 'John Smith'
AND company_name = 'First Bank Corporation';

-------------------------------------------------------------------------------------------------------------------------------------------------------
--Q2.	Consider the employee database of Figure 5, where the primary keys are underlined. Give an expression in SQL for each of the following queries:

-----(i) Using Subqueries

--(a)Find the names of all employees who work for First Bank Corporation.
SELECT employee_name 
FROM tbl_employee 
WHERE employee_name IN (SELECT employee_name FROM tbl_works WHERE company_name = 'First Bank Corporation');

--(b)	Find the names and cities of residence of all employees who work for First Bank Cor-poration.
SELECT employee_name, city 
FROM tbl_employee 
WHERE employee_name IN (SELECT employee_name FROM tbl_works WHERE company_name = 'First Bank Corporation');

--(c)	Find the names, street addresses, and cities of residence of all employees who work for First Bank Corporation and earn more than $10,000.
SELECT employee_name, street, city 
FROM tbl_employee 
WHERE employee_name IN (SELECT employee_name FROM tbl_works WHERE company_name = 'First Bank Corporation' AND salary > 10000);

--(d)	Find all employees in the database who live in the same cities as the companies for which they work.
SELECT employee_name 
FROM tbl_employee 
WHERE city IN (SELECT city FROM tbl_company WHERE company_name IN (SELECT company_name FROM tbl_works WHERE tbl_works.employee_name = tbl_employee.employee_name));

--(e)	Find all employees in the database who live in the same cities and on the same streets as do their managers.
SELECT employee_name 
FROM tbl_employee
WHERE city IN (SELECT city FROM tbl_employee 
WHERE employee_name IN (SELECT manager_name FROM tbl_manages WHERE employee_name2 = tbl_employee.employee_name))
AND street IN (SELECT street FROM tbl_employee WHERE employee_name IN (SELECT manager_name FROM tbl_manages 
WHERE employee_name2 = tbl_employee.employee_name));



-----(ii) Using JOIN

--(a)	Find the names of all employees who work for First Bank Corporation.
SELECT employee_name FROM tbl_employee
JOIN tbl_works ON tbl_employee.employee_name = tbl_works.employee_name1
JOIN tbl_company ON tbl_works.company_name = tbl_company.company_name
WHERE tbl_company.company_name = 'First Bank Corporation';

--(b)	Find the names and cities of residence of all employees who work for First Bank Cor-poration.
SELECT employee_name, tbl_employee.city FROM tbl_employee
JOIN tbl_works ON tbl_employee.employee_name = tbl_works.employee_name1
JOIN tbl_company ON tbl_works.company_name = tbl_company.company_name
WHERE tbl_company.company_name = 'First Bank Corporation';

--(c)	Find the names, street addresses, and cities of residence of all employees who work for First Bank Corporation and earn more than $10,000. 
SELECT e.employee_name, street, e.city FROM tbl_employee AS e
JOIN tbl_works ON e.employee_name = tbl_works.employee_name1
JOIN tbl_company ON tbl_works.company_name = tbl_company.company_name
WHERE tbl_company.company_name = 'First Bank Corporation'
AND tbl_works.salary > 10000;

--(d)	Find all employees in the database who live in the same cities as the companies for which they work.
SELECT tbl_employee.employee_name FROM tbl_employee
JOIN tbl_works ON tbl_employee.employee_name = tbl_works.employee_name1
JOIN tbl_company ON tbl_works.company_name = tbl_company.company_name
WHERE tbl_employee.city = tbl_company.city;

--(e)	Find all employees in the database who live in the same cities and on the same streets as do their managers.
SELECT tbl_employee.employee_name, tbl_employee.city, tbl_manages.manager_name FROM tbl_employee
JOIN tbl_works ON tbl_employee.employee_name = tbl_works.employee_name1
JOIN tbl_company ON tbl_works.company_name = tbl_company.company_name
JOIN tbl_manages ON tbl_employee.employee_name = tbl_manages.employee_name2
JOIN tbl_employee AS manager ON tbl_manages.manager_name = manager.employee_name
WHERE tbl_employee.city = manager.city AND tbl_employee.street = manager.street;

--(f)	Find all employees in the database who do not work for First Bank Corporation.
SELECT employee_name FROM tbl_employee
WHERE employee_name NOT IN (SELECT employee_name FROM tbl_works
WHERE company_name = 'First Bank Corporation');

--(g)	Find all employees in the database who earn more than each employee of Small Bank Corporation.
SELECT employee_name FROM tbl_employee
JOIN tbl_works ON tbl_employee.employee_name = tbl_works.employee_name1
WHERE tbl_works.salary > (SELECT MAX(salary) FROM tbl_works
WHERE company_name = 'Small Bank Corporation');

--(h)	Assume that the companies may be located in several cities. Find all companies located in every city in which Small Bank Corporation is located.
SELECT DISTINCT tbl_company.company_name FROM tbl_company
WHERE NOT EXISTS (SELECT city FROM tbl_company
WHERE company_name = 'Small Bank Corporation'
AND city NOT IN (SELECT city FROM tbl_company
WHERE company_name = 'Small Bank Corporation'));

--(i)	Find all employees who earn more than the average salary of all employees of their company.
SELECT tbl_employee.employee_name FROM tbl_employee
JOIN tbl_works ON tbl_employee.employee_name = tbl_works.employee_name1
WHERE tbl_works.salary > (SELECT AVG(salary) FROM tbl_works);

--(j)	Find the company that has the most employees.
SELECT company_name FROM tbl_company
WHERE (SELECT COUNT(employee_name1) FROM tbl_works
WHERE tbl_company.company_name = tbl_works.company_name) = 
      (SELECT MAX(emp_count) FROM (SELECT company_name, COUNT(employee_name1) AS emp_count
                                   FROM tbl_works GROUP BY company_name) AS subquery);

--(k)	Find the company that has the smallest payroll.
SELECT company_name FROM tbl_company
WHERE (SELECT SUM(salary) FROM tbl_works WHERE tbl_company.company_name = tbl_works.company_name) = 
(SELECT MIN(payroll_sum) FROM (SELECT company_name, SUM(salary) AS payroll_sum FROM tbl_works GROUP BY company_name) AS subquery);

--(l)	Find those companies whose employees earn a higher salary, on average, than the average salary at First Bank Corporation.
SELECT tbl_company.company_name FROM tbl_company
JOIN tbl_works ON tbl_company.company_name = tbl_works.company_name
GROUP BY tbl_company.company_name
HAVING AVG(tbl_works.salary) > (SELECT AVG(salary) FROM tbl_works
WHERE company_name = 'First Bank Corporation');

-----------------------------------------------------------------------------------------------------------------------
--Q3. Consider the relational database of Figure 5. Give an expression in SQL for each of the following queries:

--(a) Modify the database so that Jones now lives in Newtown.
UPDATE tbl_employee 
SET city = 'Newtown' 
WHERE employee_name = 'Jones';

--(b)	Give all employees of First Bank Corporation a 10 percent raise.
UPDATE tbl_works 
SET salary = salary * 1.1 
WHERE company_name = 'First Bank Corporation';

--(c)	Give all managers of First Bank Corporation a 10 percent raise.
UPDATE tbl_works 
SET salary = salary * 1.1 
WHERE company_name = 'First Bank Corporation' 
AND employee_name1 IN (SELECT employee_name2 FROM tbl_manages);

--(d)	Give all managers of First Bank Corporation a 10 percent raise unless the salary be-comes greater than $100,000; in such cases, give only a 3 percent raise.
UPDATE tbl_works 
SET salary =
CASE
	WHEN salary * 1.1 <= 100000 THEN salary * 1.1
	ELSE salary * 1.03
END
WHERE company_name = 'First Bank Corporation' 
AND employee_name1 IN (SELECT employee_name2 FROM tbl_manages);

--(e)	Delete all tuples in the works relation for employees of Small Bank Corporation.
DELETE FROM tbl_works 
WHERE employee_name1 
IN (SELECT employee_name1 FROM tbl_works WHERE company_name = 'Small Bank Corporation');
