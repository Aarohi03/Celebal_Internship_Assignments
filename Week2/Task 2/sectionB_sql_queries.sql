--- Q7. Orders with status Delivered
select * from orders where status = 'Delivered';

-- Q8. Electronics products with price greater than 2000
select * from products
where category = 'Electronics' and unit_price > 2000;

-- Q9. Customers who joined in 2024 and belong to Maharashtra
select * from customers
where year(join_date) = 2024 and state = 'Maharashtra';

-- Q10. Orders between 2024-08-10 and 2024-08-25 excluding cancelled orders
select * from orders
where order_date between '2024-08-10' and '2024-08-25'
and status <> 'Cancelled';

/*
Q11. How does the index on order_date help?

Think of an index like a textbook's index at the back.

Without an Index:
MySQL has to look through every single row from top to bottom just to find a few matching records. This is a Full Table Scan and it gets incredibly slow once the table grows huge.

With an Index:
MySQL builds a quick lookup path. It can skip the noise and jump straight to the exact date range it needs. Fewer rows get scanned, making the query way faster.

Example:
select * from orders where order_date between '2024-08-10' and '2024-08-25';

Instead of scanning millions of records, this query uses the index to pinpoint the exact block of data for August 2024 instantly. So, indexes basically save a ton of search time.
*/

-- Q12.
-- Original query:
select * from customers where year(join_date) = 2024;

-- Index-friendly version (avoiding functions on indexed columns)
select * from customers
where join_date >= '2024-01-01' and join_date < '2025-01-01';