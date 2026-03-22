/* Q1. What is a Common Table Expression (CTE)?
A CTE is a temporary result set that you create inside a query using WITH.
It helps break complex queries into smaller parts.
Why it improves readability:
Instead of writing one long confusing query, you can write it step-by-step, making it easier to understand and debug.

Q2. Why are some views updatable while others are read-only?
A view is updatable only when it is based on a simple query (like one table, no joins, no group functions).
Example:
Updatable:
SELECT id, name FROM employees;
Read-only:
SELECT dept_id, COUNT(*) FROM employees GROUP BY dept_id;
Because grouped or complex data cannot be directly updated.

Q3. Advantages of stored procedures
Stored procedures are saved SQL code you can reuse.
Benefits:
No need to write same query again and again
Faster execution
Better security (users don’t access tables directly)
Easy maintenance (change in one place)

Q4. Purpose of triggers
Triggers automatically run when something happens in a table (like INSERT, UPDATE, DELETE).
Use case:
If a new employee is added, a trigger can automatically insert a record into a log table.
So you don’t have to do it manually.

Q5. Need for data modelling and normalization
Data modelling: helps design how data is stored and related.
Normalization: removes duplicate data and keeps data organized.
Why important:
Avoids data repetition
Prevents errors
Makes database efficient and easy to manage */

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2)
); 
create database Advance_sql_db;
use Advance_sql_db;

INSERT INTO Products VALUES
(1, 'Keyboard', 'Electronics', 1200),
(2, 'Mouse', 'Electronics', 800),
(3, 'Chair', 'Furniture', 2500),
(4, 'Desk', 'Furniture', 5500);

CREATE TABLE Sales (
    SaleID INT PRIMARY KEY,
    ProductID INT,
    Quantity INT,
    SaleDate DATE,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);
INSERT INTO Sales VALUES
(1, 1, 4, '2024-01-05'),
(2, 2, 10, '2024-01-06'),
(3, 3, 2, '2024-01-10'),
(4, 4, 1, '2024-01-11');

##Q6. Write a CTE to calculate the total revenue for each product 
##(Revenues = Price × Quantity), and return only products where  revenue > 3000

select * from products;
select * from sales;

WITH RevenueCTE AS (
    SELECT 
        p.ProductName,
        SUM(p.Price * s.Quantity) AS TotalRevenue
    FROM Products p
    JOIN Sales s 
        ON p.ProductID = s.ProductID
    GROUP BY p.ProductName
)
SELECT *
FROM RevenueCTE
WHERE TotalRevenue > 3000;

##Q7. Create view vw_CategorySummary
CREATE VIEW vw_CategorySummary AS
SELECT 
    Category,
    COUNT(*) AS TotalProducts,
    AVG(Price) AS AveragePrice
FROM Products
GROUP BY Category;

select * from vw_CategorySummary;

##Q8. Create an updatable view containing ProductID, ProductName, and Price.Then update the price of ProductID = 1 using the view.
CREATE VIEW vw_ProductSimple AS
SELECT ProductID, ProductName, Price
FROM Products;

UPDATE vw_ProductSimple
SET Price = 1500
WHERE ProductID = 1;

select * from products;

##Q9. Create a stored procedure that accepts a category name and returns all products belonging to that category.
DELIMITER //

CREATE PROCEDURE GetProductsByCategory(IN cat_name VARCHAR(50))
BEGIN
    SELECT *
    FROM Products
    WHERE Category = cat_name;
END //

DELIMITER ;
CALL GetProductsByCategory('Electronics');

##Q10.CREATE TRIGGER trg_after_delete_products AFTER DELETE ON Products FOR EACH ROW INSERT INTO ProductArchive VALUES (OLD.ProductID, OLD.ProductName, OLD.Category, OLD.Price, NOW());

-- Step 1: Create Archive Table
CREATE TABLE ProductArchive (
    ProductID INT,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2),
    DeletedAt TIMESTAMP
);
select * from ProductArchive;


-- Step 2: Create Trigger
DELIMITER //

CREATE TRIGGER trg_after_delete_products
AFTER DELETE ON Products
FOR EACH ROW
BEGIN
    INSERT INTO ProductArchive (
        ProductID, ProductName, Category, Price, DeletedAt
    )
    VALUES (
        OLD.ProductID,
        OLD.ProductName,
        OLD.Category,
        OLD.Price,
        NOW()
    );
END //

DELIMITER ;

select * from ProductArchive;
delete from products
where productid=1;

SET FOREIGN_KEY_CHECKS = 0;

DELETE FROM Products WHERE ProductID = 1;

SET FOREIGN_KEY_CHECKS = 1;