DELIMITER //

CREATE PROCEDURE GetTopRegionPaymentStats()
BEGIN
    DECLARE top_region VARCHAR(100);
    
    -- Identify the region with the highest total revenue
    SELECT s.Region 
    INTO top_region
    FROM Orders o
    JOIN Stores s ON o.StoreID = s.StoreID
    GROUP BY s.Region
    ORDER BY SUM(o.TotalAmount) DESC
    LIMIT 1;
    
    -- Display the distribution of payment methods in that region
    SELECT 
        o.PaymentMethod,
        COUNT(o.OrderID) AS PaymentCount
    FROM Orders o
    JOIN Stores s ON o.StoreID = s.StoreID
    WHERE s.Region = top_region
    GROUP BY o.PaymentMethod
    ORDER BY PaymentCount DESC;
    
    -- Calculate the percentage breakdown of each payment method in that region
    SELECT 
        o.PaymentMethod,
        COUNT(o.OrderID) AS PaymentCount,
        (COUNT(o.OrderID) * 100.0 / (SELECT COUNT(*) 
                                     FROM Orders o2
                                     JOIN Stores s2 ON o2.StoreID = s2.StoreID
                                     WHERE s2.Region = top_region)) AS Percentage
    FROM Orders o
    JOIN Stores s ON o.StoreID = s.StoreID
    WHERE s.Region = top_region
    GROUP BY o.PaymentMethod
    ORDER BY Percentage DESC;

END //

DELIMITER ;

CALL GetTopRegionPaymentStats();
