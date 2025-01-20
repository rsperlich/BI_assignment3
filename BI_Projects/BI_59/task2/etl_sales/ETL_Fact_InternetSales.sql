INSERT INTO BI_BikesDW_59.Fact_InternetSales (
    SalesOrderLineNumber, SalesOrderNumber, OrderDateKey, OrderDate, DueDateKey,
    DueDate, ShipDateKey, ShipDate, ProductKey, CustomerKey, ShipToLocationKey,
    OrderStatus, ShipMethod, OrderQty, UnitPrice, OrderLineTotal, OrderLineProfit,
    OrderLineTaxAmt, OrderLineShippingCost
)
SELECT 
    CONCAT('SOL', h.SalesOrderID, '-', d.SalesOrderDetailID) AS SalesOrderLineNumber,
    h.SalesOrderNumber,
    YEAR(h.OrderDate) * 10000 + MONTH(h.OrderDate) * 100 + DAY(h.OrderDate) AS OrderDateKey,
    h.OrderDate,
    YEAR(h.DueDate) * 10000 + MONTH(h.DueDate) * 100 + DAY(h.DueDate) AS DueDateKey,
    h.DueDate,
    YEAR(h.ShipDate) * 10000 + MONTH(h.ShipDate) * 100 + DAY(h.ShipDate) AS ShipDateKey,
    h.ShipDate,
    d.ProductID AS ProductKey,
    h.CustomerID AS CustomerKey,
    a.CountryID AS ShipToLocationKey,
    os.OrderStatusName AS OrderStatus,
    sm.ShipMethodName AS ShipMethod,
    d.OrderQty,
    d.UnitPrice,
    d.OrderQty * d.UnitPrice AS OrderLineTotal,
    (d.OrderQty * d.UnitPrice) - (d.OrderQty * p.StandardCost) AS OrderLineProfit,
    (d.OrderQty * d.UnitPrice) * c.TaxRate AS OrderLineTaxAmt,
    ptc.ShipSurcharge + sm.ShipBase + (d.OrderQty * sm.ShipRate * c.ShipCoeff) AS OrderLineShippingCost
FROM BI_Bikes_59.TB_SalesOrderDetail d
JOIN BI_Bikes_59.TB_SalesOrderHeader h ON d.SalesOrderID = h.SalesOrderID
JOIN BI_Bikes_59.TB_Product p ON d.ProductID = p.ProductID
JOIN BI_Bikes_59.TB_Address a ON h.ShipToAddressID = a.AddressID
JOIN BI_Bikes_59.TB_Country c ON a.CountryID = c.CountryID
LEFT JOIN BI_Bikes_59.TB_OrderStatus os ON h.OrderStatusID = os.OrderStatusID
LEFT JOIN BI_Bikes_59.TB_ShipMethod sm ON h.ShipMethodID = sm.ShipMethodID
LEFT JOIN BI_Bikes_59.TB_ProductSubCategory psc ON p.ProductSubCategoryID = psc.ProductSubCategoryID
LEFT JOIN BI_Bikes_59.TB_ProductTopCategory ptc ON psc.ProductTopCategoryID = ptc.ProductTopCategoryID;
