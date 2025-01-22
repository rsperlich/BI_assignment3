WITH RankedProducts AS (select p.ProductTopCategoryName ,
p.ProductSubCategoryName,
p.ProductModelName,
SUM(f.OrderQty) as "Sold",
ROW_NUMBER() OVER (PARTITION BY p.ProductTopCategoryName ORDER BY SUM(f.OrderQty) DESC) AS "Ranking"
from Dim_Product p
join Fact_InternetSales f on f.ProductKey=P.ProductKey
group by p.ProductTopCategoryName,p.ProductSubCategoryName,p.ProductModelName
)
SELECT 
    ProductTopCategoryName as "Product Top Category",
    ProductSubCategoryName  as "Product Sub Category",
    ProductModelName as "Product Model" ,
    Sold as "Quantity Sold"
FROM 
    RankedProducts
WHERE 
    Ranking <= 3
ORDER BY 
    ProductTopCategoryName, Ranking;
