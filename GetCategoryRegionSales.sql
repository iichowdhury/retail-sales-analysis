DELIMITER //

CREATE PROCEDURE GetCategoryRegionSales(
    IN start_date DATE,
    IN end_date DATE
)
BEGIN
    -- Total sales per product category
    SELECT 
        p.Category AS ProductCategory,
        SUM(oi.Quantity * oi.UnitPrice) AS TotalSales
    FROM OrderItems oi
    JOIN Products p ON oi.ProductID = p.ProductID
    JOIN Orders o ON oi.OrderID = o.OrderID
    WHERE o.OrderDate BETWEEN start_date AND end_date
    GROUP BY p.Category
    ORDER BY TotalSales DESC;

    -- Total sales per region
    SELECT 
        s.Region AS StoreRegion,
        SUM(o.TotalAmount) AS TotalSales
    FROM Orders o
    JOIN Stores s ON o.StoreID = s.StoreID
    WHERE o.OrderDate BETWEEN start_date AND end_date
    GROUP BY s.Region
    ORDER BY TotalSales DESC;

    -- Average sales per product category
    SELECT 
        p.Category AS ProductCategory,
        AVG(oi.Quantity * oi.UnitPrice) AS AvgSales
    FROM OrderItems oi
    JOIN Products p ON oi.ProductID = p.ProductID
    JOIN Orders o ON oi.OrderID = o.OrderID
    WHERE o.OrderDate BETWEEN start_date AND end_date
    GROUP BY p.Category
    ORDER BY AvgSales DESC;

    -- Average sales per region
    SELECT 
        s.Region AS StoreRegion,
        AVG(o.TotalAmount) AS AvgSales
    FROM Orders o
    JOIN Stores s ON o.StoreID = s.StoreID
    WHERE o.OrderDate BETWEEN start_date AND end_date
    GROUP BY s.Region
    ORDER BY AvgSales DESC;

END //

DELIMITER ;

CALL GetCategoryRegionSales('2024-01-01', '2024-12-31');