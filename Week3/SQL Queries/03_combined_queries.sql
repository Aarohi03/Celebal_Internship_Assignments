-- Final Combined Query
-- Show customer name, total sales, and rank using JOIN + CTE + Window Function

with customer_sales as (
    select `customer id`, sum(sales) as total_sales from orders group by `customer id`
)

select c.`customer name`, cs.total_sales, rank() over(order by cs.total_sales desc) as customer_rank
from customer_sales cs join customers c on cs.`customer id` = c.`customer id`;