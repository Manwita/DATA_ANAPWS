/*Q1. Create a New Database and  Table for Employees
Task: Create a new database named  company_db and Create a table named  employees columns: 
structure:
Column Name,Data Type,Constraint
employee_id,INT,PRIMARY KEY
first_name,VARCHAR(50),
last_name,VARCHAR(50),
department,VARCHAR(50),
salary,INT,
hire_date,DATE,   */

CREATE DATABASE company_db;
USE company_db;

CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    department VARCHAR(50),
    salary INT,
    hire_date DATE
);

/*Q2. Insert Data into Employees Table
Task:
Insert the following sample records into the employees table.
employee_id,first_name,last_name,department,salary,hire_date
101,Amit,Sharma,HR,50000,2020-01-15
102,Riya,Kapoor,Sales,75000,2019-03-22
103,Raj,Mehta,IT,90000,2018-07-11
104,Neha,Verma,IT,85000,2021-09-01
105,Arjun,Singh,Finance,60000,2022-02-10
*/

INSERT INTO employees VALUES
(101, 'Amit', 'Sharma', 'HR', 50000, '2020-01-15'),
(102, 'Riya', 'Kapoor', 'Sales', 75000, '2019-03-22'),
(103, 'Raj', 'Mehta', 'IT', 90000, '2018-07-11'),
(104, 'Neha', 'Verma', 'IT', 85000, '2021-09-01'),
(105, 'Arjun', 'Singh', 'Finance', 60000, '2022-02-10');
 select * from employees;
 
 /*Q3. Display All Employee Records Sorted by Salary (Lowest to Highest)
Hint: Use ORDER BY clause on the salary column*/

select * from employees
order by salary ASC;

/* Q4. Show Employees Sorted by Department (A–Z) and Salary (High → Low)*/

SELECT * 
FROM employees
ORDER BY department ASC, salary DESC;

/*Q5. List All Employees in the IT Department, Ordered by Hire Date (Newest First)*/

select * from employees
where department='IT'
order by hire_date desc;

/*Q6. Create and Populate a Sales Table

sale_id,customer_name,amount,sale_date
1,Aditi,1500,2024-08-01
2,Rohan,2200,2024-08-03
3,Aditi,3500,2024-09-05
4,Meena,2700,2024-09-15
5,Rohan,4500,2024-09-25
*/

CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    amount INT,
    sale_date DATE
);

INSERT INTO sales VALUES
(1, 'Aditi', 1500, '2024-08-01'),
(2, 'Rohan', 2200, '2024-08-03'),
(3, 'Aditi', 3500, '2024-09-05'),
(4, 'Meena', 2700, '2024-09-15'),
(5, 'Rohan', 4500, '2024-09-25');

/*Q7. Display All Sales Records Sorted by Amount (Highest → Lowest)
Hint: Use 
ORDER BY amount DESC.*/

SELECT *
FROM sales
ORDER BY amount DESC;

/*Q8. Show All Sales Made by Customer “Aditi”
Hint: Use WHERE customer_name = 'Aditi'*/

select * from sales
where customer_name="aditi";

/*Q9. What is the Difference Between a Primary Key and a Foreign Key?
Primary Key:Uniquely identifies each record in a table.
Cannot contain NULL values.
A table can have only one primary key (can be composite).
Ensures entity integrity

Foreign Key:Refers to a primary key in another table.
Can contain duplicate values.
Can contain NULL (unless restricted).
Maintains relationship between tables.
Ensures referential integrity.

Q10. What Are Constraints in SQL and Why Are They Used?

Constraints are rules applied to table columns to enforce data accuracy and integrity.
--> Why Are They Used?
To prevent invalid data entry
To maintain data consistency
To enforce business rules
To ensure relational integrity*/



