select l.Region,
c.FullName as "Customer Name", 
SUM(f.OrderQty) as "Quantity Sold",
ROW_NUMBER() OVER (ORDER BY COUNT(f.OrderQty) DESC) AS "Rank"
from Dim_Customer c
join Fact_InternetSales f on f.CustomerKey=c.CustomerKey
join Dim_Location l on f.ShipToLocationKey =l.LocationKey
where Region ='Europe'
group by l.Region,c.FullName
LIMIT 5;

