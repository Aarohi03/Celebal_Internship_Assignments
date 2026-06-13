use celebal_week3;
-- 1. Find all orders where sales are greater than the average sales (Subquery)
select * from orders
where sales > (select avg(sales) from orders);


-- 2. Find the highest sales order for each customer (Subquery)
select * from orders o where sales = (
    select max(sales) from orders
    where `customer id` = o.`customer id`
);


-- 3. Calculate total sales for each customer (CTE)
with customer_sales as (
    select `customer id`, sum(sales) as total_sales from orders
    group by `customer id`
)
select * from customer_sales;


-- 4. Find customers whose total sales are above average (CTE + Subquery)
with customer_sales as (
    select `customer id`, sum(sales) as total_sales from orders
    group by `customer id`
)
select * from customer_sales
where total_sales > (
    select avg(total_sales) from customer_sales
);


-- 5. Rank all customers based on total sales (Window Function)
with customer_sales as (
    select `customer id`, sum(sales) as total_sales from orders
    group by `customer id`
)
select `customer id`, total_sales, rank() over(order by total_sales desc) as customer_rank
from customer_sales;


-- 6. Assign row numbers to each order within a customer (Window Function + PARTITION BY)
select `customer id`, `order id`, sales, row_number() over(partition by `customer id` order by sales desc) as row_num
from orders;


-- 7. Display top 3 customers based on total sales (Window Function)
with customer_sales as (
    select `customer id`, sum(sales) as total_sales from orders
    group by `customer id`
)
select * from (
    select `customer id`, total_sales, rank() over(order by total_sales desc) as customer_rank from customer_sales) as ranked_customers
where customer_rank <= 3;