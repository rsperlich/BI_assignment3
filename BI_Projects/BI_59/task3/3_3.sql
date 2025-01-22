select  ROW_NUMBER() OVER (ORDER BY SUM(f.OrderLineProfit) DESC) as "Customer Rank",
c.FullName as "Customer Name", 
sum(OrderLineProfit) as Profit
from Dim_Customer c
join Fact_InternetSales f on f.CustomerKey=c.CustomerKey
where f.OrderDate BETWEEN '2021-01-01' AND '2021-06-30'
group by c.FullName
LIMIT 10;