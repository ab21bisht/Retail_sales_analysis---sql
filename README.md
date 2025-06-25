# Retail Sales Analysis SQL Project

**Project Title**: Retail Sales Analysis  

### Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

1. **Write a SQL query to retrieve all columns for sales made on '2022-11-05**:
```sql
select *
from sales_analysis
where sale_date ='2022-11-05';
```

2. **Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022**:
```sql
select *
from sales_analysis
where  category ='clothing'
and quantity >=4
and month(sale_date) = 11;
```

3. **Write a SQL query to calculate the total sales (total_sale) for each category.**:
```sql
select category,sum(total_sale) as Total_sales,
count(*) as Total_orders
from sales_analysis
group by category;
```

4. **Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.**:
```sql
select avg(age)
from sales_analysis
where category ='Beauty';
```

5. **Write a SQL query to find all transactions where the total_sale is greater than 1000.**:
```sql
select *
from sales_analysis
where total_sale = 1000;
```

6. **Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.**:
```sql
select category,gender,count(*)
from sales_analysis
group by category, gender
order by 1 
;
```

7. **Write a SQL query to calculate the average sale for each month. Find out best selling month in each year**:
```sql
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
```

8. **Write a SQL query to find the top 5 customers based on the highest total sales **:
```sql
select 
customer_id,
sum(total_sale) as total_sales
from sales_analysis
group by 1
order by 2 desc
limit 5;
```

9. **Write a SQL query to find the number of unique customers who purchased items from each category.**:
```sql
select count(distinct customer_id) as unique_customer,category
from sales_analysis
group by category;
```

10. **Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)**:
```sql
with hourly_sale 
as
(select *,
CASE
when hour(sale_time) < 12 then 'Morning'
when hour(sale_time) between 12 and 17 then 'Afternoon'
else 'Evening'
END as shift
from sales_analysis)
select 
shift,
count(*) as total_transaction
from hourly_sale
group by shift;
```
