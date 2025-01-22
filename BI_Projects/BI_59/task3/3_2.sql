select l.Country, sum(OrderLineTotal)
from Dim_Location l
join Fact_InternetSales f on f.ShipToLocationKey=l.LocationKey
where year(OrderDate) = 2019
group by l.Country
order by sum(OrderLineTotal) desc