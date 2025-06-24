use portfolio;
select *
from sales_analysis
limit 20;

select *
from sales_analysis;

select *
from sales_analysis
where quantiy is null;

select * from sales_analysis;

ALTER TABLE sales_analysis RENAME COLUMN ï»¿transactions_id TO transactions_id;
ALTER TABLE sales_analysis RENAME COLUMN quantiy TO quantity;

select *
from sales_analysis;

#1 Write a SQL query to retrieve all columns for sales made on '2022-11-05.
select *
from sales_analysis
where sale_date ='2022-11-05';

#2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022.
select *
from sales_analysis
where 
category ='clothing'
and
quantity >=4
and 
month(sale_date) = 11;

#3 Write a SQL query to calculate the total sales (total_sale) for each category.
select category,sum(total_sale) as Total_sales,
count(*) as Total_orders
from sales_analysis
group by category;

#4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
select avg(age)
from sales_analysis
where category ='Beauty';

#5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
select *
from sales_analysis
where total_sale = 1000;

#6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
select category,gender,count(*)
from sales_analysis
group by category, gender
order by 1 
;

#7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
select year, month, avg_sale
from 
(
SELECT
    YEAR(sale_date) AS year,
    MONTH(sale_date) AS month,
    AVG(total_sale) AS avg_sale,
    rank() over(partition by YEAR(sale_date) order by  AVG(total_sale) desc) as rank1
FROM sales_analysis
GROUP BY year, month
) as t1
where rank1 = 1;

#8 Write a SQL query to find the top 5 customers based on the highest total sales 
select 
customer_id,
sum(total_sale) as total_sales
from sales_analysis
group by 1
order by 2 desc
limit 5;

#9 Write a SQL query to find the number of unique customers who purchased items from each category.
select count(distinct customer_id) as unique_customer,category
from sales_analysis
group by category;

#10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
with hourly_sale 
as
(
select *,
CASE
	when hour(sale_time) < 12 then 'Morning'
    when hour(sale_time) between 12 and 17 then 'Afternoon'
    else 'Evening'
END as shift
from sales_analysis
)
select 
shift,
count(*) as total_transaction
from hourly_sale
group by shift;

