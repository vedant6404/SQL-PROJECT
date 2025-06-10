-#SQL_RETAIL_SALES_ANALYSIS
CREATE DATABASE SQL_SALES_PROJECT;

#create TABLE

create TABLE retail_sales
     ( 
	  transactions_id INT primary key,
      sale_date	DATE,
      sale_time	TIME, 
      customer_id int,
      gender varchar(50),
      age	int,
      category	varchar(100),
      quantiy	int,
      price_per_unit int,	
      cogs	float,
      total_sale float
      )
      
#data cleaning

select * from retail_sales
where transactions_id is null;

select * from retail_sales
where sale_date is null;

select * from retail_sales
where sale_time is null;

select * from retail_sales
where customer_id is null;

select * from retail_sales
where sale_time is null;

select * from retail_sales
where 
transactions_id is null
or 
sale_date is null
or
customer_id is null
or 
sale_time is null
or 
gender is null
or 
age is null
or 
category is null
or 
quantiy is null
or 
price_per_unit is null
or
cogs is null 
or 
total_sale is null;

select * from retail_sales
where quantiy is null; 


#data exploration:-

#how many sales we have?
select count(*) as total_sale from retail_sales;

#how many unique customers swe have?
select count(distinct customer_id) as total_sale from retail_sales;

select distinct category from retail_sales;

#DATA ANALYSIS AND BUSINESS KEY PROBLEMS AND SOLUTIONS :-

-- My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05

select * from retail_sales where sale_date = '2022-11-05';

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022

select * from retail_sales where category = 'clothing' and quantiy >= 4 and MONTH(sale_date) = 11 AND YEAR(sale_date) = 2022;

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.

select category , sum(total_sale) AS NET_SALE , count(*) AS TOTAL_ORDERS FROM retail_sales group by category; 

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

SELECT  avg(age) from retail_sales where category="beauty"; 

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

SELECT * FROM  retail_sales WHERE total_sale >= 1000;

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

select 
      category,
	  gender,
      count(*) as total_trans
	from retail_sales
    group by category,
	  gender
	order by 1;

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year

select 
     year(sale_date) as year,
     month(sale_date) as month,
     avg(total_sale) as avg_sale
from retail_sales
group by year, month
order by 1, 3 desc;

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 

select 
     customer_id,
     sum(total_sale) as total_sale
from retail_sales
group by 1 
order by 2 desc
limit 5;


-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.

  SELECT 
      category,
      count(distinct customer_id) as unique_customer
from retail_sales
group by 1;

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

with hourly_sales
as 
(
select *,
     case
      when extract(hour from sale_time) < 12 then 'Morning'
      when extract(hour from sale_time) between 12 and 17 then 'Afternoon'
      else 'Evening' 
	end as shift
from retail_sales
)
select 
    shift,
    count(*) as total_orders
from hourly_sales 
group by shift



