select l.Country,
SUM(OrderLineProfit) AS "Profit"
from Dim_Location l
join Fact_InternetSales f on f.ShipToLocationKey =l.LocationKey
where f.UnitPrice BETWEEN 1000 AND 2000
group by l.Country
order by SUM(OrderLineProfit)  desc
limit 3;
