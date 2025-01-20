INSERT INTO BI_BikesDW_59.Dim_Product (ProductKey, ProductName, ProductModelName, ProductSubCategoryName, ProductTopCategoryName, StandardCost, ListPrice, StartDate, EndDate, ProductStatus)
SELECT 
    p.ProductID AS ProductKey,
    p.ProductName,
    pm.ProductModelName,
    psc.Name AS ProductSubCategoryName,
    ptc.Name AS ProductTopCategoryName,
    p.StandardCost,
    p.ListPrice,
    p.SellStartDate AS StartDate,
    p.SellEndDate AS EndDate,
    CASE 
        WHEN p.SellEndDate IS NULL OR p.SellEndDate > '2021-09-30' THEN 'Current'
        ELSE 'Discontinued'
    END AS ProductStatus
FROM BI_Bikes_59.TB_Product p
LEFT JOIN BI_Bikes_59.TB_ProductModel pm ON p.ProductModelID = pm.ProductModelID
LEFT JOIN BI_Bikes_59.TB_ProductSubCategory psc ON p.ProductSubCategoryID = psc.ProductSubCategoryID
LEFT JOIN BI_Bikes_59.TB_ProductTopCategory ptc ON psc.ProductTopCategoryID = ptc.ProductTopCategoryID;