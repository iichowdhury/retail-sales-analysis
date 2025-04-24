USE business_intelligence;
DELIMITER //

CREATE PROCEDURE GetSalesSummary(
    IN start_date DATE,
    IN end_date DATE
)
BEGIN
    -- Total sales per day
    SELECT 
        OrderDate AS Period,
        SUM(TotalAmount) AS TotalSales
    FROM Orders
    WHERE OrderDate BETWEEN start_date AND end_date
    GROUP BY OrderDate
    ORDER BY OrderDate;

    -- Total sales per month
    SELECT 
        DATE_FORMAT(OrderDate, '%Y-%m') AS Period,
        SUM(TotalAmount) AS TotalSales
    FROM Orders
    WHERE OrderDate BETWEEN start_date AND end_date
    GROUP BY Period
    ORDER BY Period;

    -- Total sales per year
    SELECT 
        YEAR(OrderDate) AS Period,
        SUM(TotalAmount) AS TotalSales
    FROM Orders
    WHERE OrderDate BETWEEN start_date AND end_date
    GROUP BY Period
    ORDER BY Period;

    -- Average daily sales
    SELECT 
        AVG(DailySales) AS AvgDailySales
    FROM (
        SELECT 
            OrderDate,
            SUM(TotalAmount) AS DailySales
        FROM Orders
        WHERE OrderDate BETWEEN start_date AND end_date
        GROUP BY OrderDate
    ) AS DailySalesTable;

    -- Average monthly sales
    SELECT 
        AVG(MonthlySales) AS AvgMonthlySales
    FROM (
        SELECT 
            DATE_FORMAT(OrderDate, '%Y-%m') AS Period,
            SUM(TotalAmount) AS MonthlySales
        FROM Orders
        WHERE OrderDate BETWEEN start_date AND end_date
        GROUP BY Period
    ) AS MonthlySalesTable;

    -- Average yearly sales
    SELECT 
        AVG(YearlySales) AS AvgYearlySales
    FROM (
        SELECT 
            YEAR(OrderDate) AS Period,
            SUM(TotalAmount) AS YearlySales
        FROM Orders
        WHERE OrderDate BETWEEN start_date AND end_date
        GROUP BY Period
    ) AS YearlySalesTable;

END //

DELIMITER ;

CALL GetSalesSummary('2024-01-01', '2024-12-31');