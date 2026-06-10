-- Q13. Total number of orders
select count(*) as total_orders from orders;

-- Q14. Total revenue from Delivered orders
select sum(total_amount) as net_revenue
from orders
where status = 'Delivered';

-- Q15. Average product price by category
select category, avg(unit_price) as avg_price
from products
group by category;

-- Q16. Count of orders and total revenue by status
select status,
       count(*) as order_cnt,
       sum(total_amount) as total_rev
from orders
group by status
order by total_rev desc;

-- Q17. Most expensive and cheapest product
select max(unit_price) as max_price,
       min(unit_price) as min_price
from products;

-- Q18. Categories with average price greater than 2000
select category, avg(unit_price) as avg_price
from products
group by category
having avg(unit_price) > 2000;