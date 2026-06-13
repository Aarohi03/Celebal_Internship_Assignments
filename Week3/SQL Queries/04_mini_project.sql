use celebal_week3;

-- top 5 customers based on total sales
select `customer id`, sum(sales) as total_sales from orders group by `customer id` order by total_sales desc limit 5;

-- highest order value for each customer
select * from orders o where sales = (select max(sales) from orders where `customer id` = o.`customer id`);
-- bottom 5 customers based on total sales
select `customer id`, sum(sales) as total_sales from orders
group by `customer id` order by total_sales asc limit 5;

-- customers who placed only one order
select `customer id`, count(`order id`) as total_orders from orders group by `customer id`
having total_orders = 1;

-- customers whose sales are above average
with customer_sales as
(select `customer id`, sum(sales) as total_sales from orders group by `customer id`)
select * from customer_sales where total_sales > (select avg(total_sales) from customer_sales);
