-- Question 1:   
CREATE TABLE ProductDetail_1NF (
    OrderID INT,
    CustomerName VARCHAR(100),
    Product VARCHAR(50)
);

-- Insert data by splitting the Products column
INSERT INTO ProductDetail_1NF (OrderID, CustomerName, Product)
SELECT OrderID, CustomerName, 'Laptop' FROM ProductDetail WHERE Products LIKE '%Laptop%'
UNION ALL
SELECT OrderID, CustomerName, 'Mouse' FROM ProductDetail WHERE Products LIKE '%Mouse%'
UNION ALL
SELECT OrderID, CustomerName, 'Tablet' FROM ProductDetail WHERE Products LIKE '%Tablet%'
UNION ALL
SELECT OrderID, CustomerName, 'Keyboard' FROM ProductDetail WHERE Products LIKE '%Keyboard%'
UNION ALL
SELECT OrderID, CustomerName, 'Phone' FROM ProductDetail WHERE Products LIKE '%Phone%';

-- Verify the results
SELECT * FROM ProductDetail_1NF ORDER BY OrderID, Product;



-- Question 2:
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

-- Create OrderItems table (fully dependent on composite key)
CREATE TABLE OrderItems (
    OrderID INT,
    Product VARCHAR(50),
    Quantity INT,
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Populate Orders table
INSERT INTO Orders (OrderID, CustomerName)
SELECT DISTINCT OrderID, CustomerName FROM OrderDetails;

-- Populate OrderItems table
INSERT INTO OrderItems (OrderID, Product, Quantity)
SELECT OrderID, Product, Quantity FROM OrderDetails;

-- Verify the results
SELECT * FROM Orders;
SELECT * FROM OrderItems ORDER BY OrderID, Product;
