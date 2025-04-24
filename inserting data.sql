USE business_intelligence;
SET GLOBAL local_infile = 1;
SHOW VARIABLES LIKE 'local_infile';

-- Load Customer data
LOAD DATA LOCAL INFILE '/Users/imadulislamchowdhury/Downloads/business_intelligence/case_study2/customers.csv'
INTO TABLE Customers
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS 
(CustomerName, Email, JoinDate);

SELECT * FROM Customers;

-- Load Product data
LOAD DATA LOCAL INFILE '/Users/imadulislamchowdhury/Downloads/business_intelligence/case_study2/products.csv'
INTO TABLE Products
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS 
(ProductName, Category, Price);

SELECT * FROM Products;

-- Load Store data
LOAD DATA LOCAL INFILE '/Users/imadulislamchowdhury/Downloads/business_intelligence/case_study2/stores.csv'
INTO TABLE Stores
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS 
(StoreName, Region);

SELECT * FROM Stores;

-- Load Order data
LOAD DATA LOCAL INFILE '/Users/imadulislamchowdhury/Downloads/business_intelligence/case_study2/orders.csv'
INTO TABLE Orders
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS 
(OrderDate, CustomerID, StoreID, TotalAmount, PaymentMethod);

SELECT * FROM Orders;

-- Load Order Items data
LOAD DATA LOCAL INFILE '/Users/imadulislamchowdhury/Downloads/business_intelligence/case_study2/order_items.csv'
INTO TABLE OrderItems
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS 
(OrderID, ProductID, Quantity, UnitPrice);

SELECT * FROM OrderItems;


