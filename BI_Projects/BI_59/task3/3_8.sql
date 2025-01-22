select year(OrderDate) as "Year",
EnglishMonthName as "Month",
l.Country,
SUM(OrderLineTaxAmt) AS "Tax Amount"
from Dim_Location l
join Fact_InternetSales f on f.ShipToLocationKey =l.LocationKey
join Dim_Date d on d.DateKey=f.OrderDateKey
where l.Country in ('France','Germany')
and f.OrderDate BETWEEN '2021-01-01' AND '2021-06-30'
group by year(OrderDate),EnglishMonthName,month(OrderDate),l.Country
order by year(OrderDate),month(OrderDate);