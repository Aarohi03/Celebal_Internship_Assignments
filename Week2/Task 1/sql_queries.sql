create database celebal_week2;
use celebal_week2;

-- check data & structure
select * from superstore limit 10;
describe superstore;

-- filtering data by region, category, sales
select * from superstore where Region = 'West';

select * from superstore where Category = 'Technology';

select * from superstore where Sales > 1000;

-- Filter by order date
select * from superstore
where STR_TO_DATE(`Order Date`, '%m/%d/%Y') >= '2017-01-01';

-- Aggregations by Category (Sales, Qty, Avg)
select Category, sum(Sales) as total_sales
from superstore group by Category;

select Category, sum(Quantity) as total_qty
from superstore group by Category;

select Category, avg(Sales) as avg_sales
from superstore group by Category;

-- Top 10 selling products
select `Product Name`, sum(Sales) as total_sales
from superstore group by `Product Name`
order by total_sales desc limit 10;

-- Categories ranked by sales
select Category, sum(Sales) as total_sales
from superstore group by Category
order by total_sales desc;

-- Monthly trends
select
    year(STR_TO_DATE(`Order Date`, '%m/%d/%Y')) as order_year,
    month(STR_TO_DATE(`Order Date`, '%m/%d/%Y')) as order_month,
    sum(Sales) as total_sales
from superstore
group by order_year, order_month
order by order_year, order_month;

-- Top 10 customers
select `Customer Name`, sum(Sales) as total_sales
from superstore group by `Customer Name`
order by total_sales desc limit 10;

-- Finding duplicate orders
select `Order ID`, count(*) as cnt
from superstore
group by `Order ID`
having count(*) > 1;

-- total row count
select count(*) as total_records from superstore;

-- Data Quality: checking for nulls
select
    sum(case when Sales is null then 1 else 0 end) as null_sales,
    sum(case when Quantity is null then 1 else 0 end) as null_qty,
    sum(case when Category is null then 1 else 0 end) as null_cat
from superstore;