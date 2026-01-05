--SQL RETAIL ANALYSIS
DROP TABLE IF EXISTS transac;
CREATE TABLE transac(
transaction_id INT,
sale_date DATE,
sale_time TIME,
customer_id INT,
gender VARCHAR(15),
age INT,
category VARCHAR(15),
quantiy INT,
price_per_unit FLOAT,
cogs FLOAT,
total_sale FLOAT
);
-- data cleaning
SELECT * FROM transac
LIMIT 10



SELECT 
COUNT(*) 
FROM transac

SELECT * FROM transac
WHERE transaction_id IS NULL
OR sale_date IS NULL
OR sale_time IS NULL
OR customer_id IS NULL
OR gender IS NULL
OR age IS NULL
OR category IS NULL
OR quantiy IS NULL
OR price_per_unit IS NULL
OR cogs IS NULL
OR total_sale 
IS NULL ;
DELETE FROM transac
where
 transaction_id IS NULL
OR sale_date IS NULL
OR sale_time IS NULL
OR customer_id IS NULL
OR gender IS NULL
OR age IS NULL
OR category IS NULL
OR quantiy IS NULL
OR price_per_unit IS NULL
OR cogs IS NULL
OR total_sale 
IS NULL ;
SELECT COUNT(*) FROM transac 

--data exploration

--how many sales we have
SELECT COUNT(*) as total_sale FROM transac
--how many customers we have 
SELECT COUNT(*) as customer_id  FROM transac
SELECT COUNT( DISTINCT customer_id) as  total_sale FROM transac
SELECT DISTINCT  category FROM transac

--data analysis & business key problems and answers
--question we dealing are
--1. write a sql query to retrive all column for sales made on "2022-11-05"
--2. write a sql query to retrive all transactions where the category is "clothing " and 
--3.write a sql quesry to calculate the total sales for each category 
--4. write a sql query to find average age of customers purchased items from the "beauty"category
--5.write a sql query to find all transactions where total_sals is greater than 1000
--6. write a sql query to find total number of transaction made by each gender in eacg category 
--7.to calculate the average sale for each month . find out best selling month for each year 
--8. find top 5 customers based on the highest total sales 
--9.to find number of unique customers who purcghasedf items from each category.
--10. to creste shift and number of orders 

--1 aNS
SELECT * FROM transac
WHERE sale_date = '2022-11-05'
--2 ANS
SELECT * FROM transac 
WHERE category ='Clothing'
AND quantiy>=1
AND TO_CHAR(sale_date,'YYYY-MM')='2022-11'
--3 ANS
SELECT
category,
SUM(total_sale) as net_sale
FROM transac
GROUP BY 1;

--4 ANS
SELECT customer_id,
age as avg_age
FROM transac
WHERE category = 'Beauty';
     
--5 ans
SELECT * FROM transac
where total_sale > 1000

--6 asn
SELECT 
 category,
 gender,
COUNT(*) as  transaction_id 
FROM transac
group by 
 category,
 gender
order by 1

--7 ans
SELECT * FROM(
select 
extract (year from sale_date) as year,
extract (month from sale_date) as month,
avg(total_sale) as avg_sale,
RANK() OVER(PARTITION BY extract (year from sale_date) ORDER BY avg(total_sale) DESC) AS RANK 
from transac 
group by 1,2

) AS T1
WHERE RANK = 1

--8 ANS 
SELECT 
customer_id,
sum(total_sale) as total_sale
FROM  transac
group by 1
order by 2 desc
limit 5

--9 ans
select 
category, count(distinct customer_id) as cust_id
from transac 
group by category 

--10 ans 
with hourly_sales as (
select * ,
case 
when extract(hour from sale_time )<12  then 'morning' 
when extract (hour from sale_time ) between 12 and 17 then 'aftewrnoon'
else 'evening'
end as shift
from transac ) 
select 
shift,
count(*) as total_oders 
from hourly_sales 
group by shift

--end of projecg
