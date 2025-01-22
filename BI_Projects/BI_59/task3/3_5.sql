select l.Country,
year(OrderDate) as "Year",
EnglishMonthName as "Month",
SUM(OrderLineShippingCost) AS "Shipping costs"
from Dim_Location l
join Fact_InternetSales f on f.ShipToLocationKey =l.LocationKey
join Dim_Date d on d.DateKey=f.OrderDateKey
where l.Country ='United Kingdom'
and ShipMethod = 'Cargo International'
and f.OrderDate BETWEEN '2020-01-01' AND '2020-06-30'
group by l.Country,year(OrderDate),EnglishMonthName;
