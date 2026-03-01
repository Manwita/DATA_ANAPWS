
create database subqueries;
use subqueries;
select * from department;

CREATE TABLE employee (
    emp_id INT PRIMARY KEY,
    name VARCHAR(50),
    department_id VARCHAR(10),
    salary INT
);
select * from employee;
drop table employee;
CREATE TABLE department (
    department_id VARCHAR(10) PRIMARY KEY,
    department_name VARCHAR(50),
    location VARCHAR(50)
);
CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    emp_id INT,
    sale_amount INT,
    sale_date DATE,
    FOREIGN KEY (emp_id) REFERENCES employee(emp_id)
);

INSERT INTO employee VALUES
(101, 'Abhishek', 'D01', 62000),
(102, 'Shubham',  'D01', 58000),
(103, 'Priya',    'D02', 67000),
(104, 'Rohit',    'D02', 64000),
(105, 'Neha',     'D03', 72000),
(106, 'Aman',     'D03', 55000),
(107, 'Ravi',     'D04', 60000),
(108, 'Sneha',    'D04', 75000),
(109, 'Kiran',    'D05', 70000),
(110, 'Tanuja',   'D05', 65000);

INSERT INTO department VALUES
('D01', 'Sales',     'Mumbai'),
('D02', 'Marketing', 'Delhi'),
('D03', 'Finance',   'Pune'),
('D04', 'HR',        'Bengaluru'),
('D05', 'IT',        'Hyderabad');

INSERT INTO sales VALUES
(201, 101, 4500,  '2025-01-05'),
(202, 102, 7800,  '2025-01-10'),
(203, 103, 6700,  '2025-01-14'),
(204, 104, 12000, '2025-01-20'),
(205, 105, 9800,  '2025-02-02'),
(206, 106, 10500, '2025-02-05'),
(207, 107, 3200,  '2025-02-09'),
(208, 108, 5100,  '2025-02-15'),
(209, 109, 3900,  '2025-02-20'),
(210, 110, 7200,  '2025-03-01');
select * from employee;
select * from department;
select * from sales;


##Basic Level
##1.Retrieve the names of employees who earn more than the average salary of all employees.

select name,salary
from employee
where salary>(select avg(salary) from employee);

##2.Find the employees who belong to the department with the highest average salary.

select * from employee;

SELECT *
FROM employee
WHERE department_id = (
    SELECT department_id
    FROM (
        SELECT department_id, AVG(salary) AS avg_sal
        FROM employee
        GROUP BY department_id
        ORDER BY avg_sal DESC
        LIMIT 1
    ) T
);


##3.List all employees who have made at least one sale.

select e.name
from employee e
inner join sales s
on e.emp_id=s.emp_id;

##4.Find the employee with the highest sale amount.
select * from employee;
select * from sales;

select e.name,s.emp_id,s.sale_amount
from employee e
inner join sales s
on e.emp_id=s.emp_id
where s.sale_amount=(select max(sale_amount) from sales);

## 5.Retrieve the names of employees whose salaries are higher than Shubham’s salary

select name
from employee
where salary>(select salary from employee where name='Shubham');

##Intermediate Level

##6.Find employees who work in the same department as Abhishek.
SELECT name
FROM employee
WHERE department_id = (
    SELECT department_id
    FROM employee
    WHERE name = 'Abhishek'
);

##7.List departments that have at least one employee earning more than ₹60,000.
SELECT DISTINCT d.department_name
FROM department d
JOIN employee e
ON d.department_id = e.department_id
WHERE e.salary > 60000;

##8.Find the department name of the employee who made the highest sale.
SELECT d.department_name
FROM department d
JOIN employee e ON d.department_id = e.department_id
JOIN sales s ON e.emp_id = s.emp_id
WHERE s.sale_amount = (
    SELECT MAX(sale_amount)
    FROM sales
);

##9.Retrieve employees who have made sales greater than the average sale amount.
SELECT DISTINCT e.name, s.sale_amount
FROM employee e
JOIN sales s ON e.emp_id = s.emp_id
WHERE s.sale_amount > (
    SELECT AVG(sale_amount)
    FROM sales
);

##10.Find the total sales made by employees who earn more than the average salary.
SELECT SUM(s.sale_amount) AS total_sales
FROM sales s
JOIN employee e ON s.emp_id = e.emp_id
WHERE e.salary > (
    SELECT AVG(salary)
    FROM employee
);

##Advanced Level

##11.Find employees who have not made any sales.
select e.name, s.sale_amount
from employee e
left join sales s
on e.emp_id=s.emp_id
where s.emp_id is null;

##12.List departments where the average salary is above ₹55,000.
select * from employee;

select department_name d,AVG(e.salary) AS avg_salary
from department d
 join employee e
on d.department_id=e.department_id
group by d.department_id
having avg_salary >55000;
 

##13.Retrieve department names where the total sales exceed ₹10,000.
SELECT d.department_name, SUM(s.sale_amount) AS total_sales
FROM department d
JOIN employee e ON d.department_id = e.department_id
JOIN sales s ON e.emp_id = s.emp_id
GROUP BY d.department_id, d.department_name
HAVING SUM(s.sale_amount) > 10000;

##14.Find the employee who has made the second-highest sale.
SELECT e.name, s.sale_amount
FROM employee e
JOIN sales s ON e.emp_id = s.emp_id
ORDER BY s.sale_amount DESC
LIMIT 1 OFFSET 1;

##15.Retrieve the names of employees whose salary is greater than the highest sale amount recorded

SELECT name
FROM employee
WHERE salary > (
    SELECT MAX(sale_amount)
    FROM sales
);