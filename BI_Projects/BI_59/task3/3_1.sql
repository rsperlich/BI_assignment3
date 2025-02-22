select ProductTopCategoryName as 'Product Top Category', 
sum(OrderLineProfit) as Profit
from Dim_Product p
join Fact_InternetSales f on f.ProductKey=p.ProductKey
where year(OrderDate) = 2021
group by ProductTopCategoryName
order by sum(OrderLineProfit) desc;