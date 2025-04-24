DELIMITER //

CREATE PROCEDURE GetFrequentCustomers(
    IN min_orders INT
)
BEGIN
    -- List of customers who have placed at least min_orders
    SELECT 
        c.CustomerID,
        c.CustomerName,
        COUNT(o.OrderID) AS TotalOrders
    FROM Customers c
    JOIN Orders o ON c.CustomerID = o.CustomerID
    GROUP BY c.CustomerID, c.CustomerName
    HAVING TotalOrders >= min_orders
    ORDER BY TotalOrders DESC;

    -- Percentage of total customers who meet the min_orders threshold
    SELECT 
        (COUNT(DISTINCT QualifiedCustomers.CustomerID) / COUNT(DISTINCT c.CustomerID)) * 100 AS PercentageOfCustomers
    FROM Customers c
    LEFT JOIN (
        SELECT CustomerID
        FROM Orders
        GROUP BY CustomerID
        HAVING COUNT(OrderID) >= min_orders
    ) AS QualifiedCustomers ON c.CustomerID = QualifiedCustomers.CustomerID;

END //

DELIMITER ;

CALL GetFrequentCustomers(10);
