-- Q19. Customer names with their orders
select o.order_id, c.first_name, c.last_name, o.order_date, o.total_amount
from customers c
join orders o on c.customer_id = o.customer_id;

-- Q20. List all customers and orders including customers with no orders
select c.customer_id, c.first_name, c.last_name, o.order_id
from customers c
left join orders o on c.customer_id = o.customer_id;

-- Q21. Join all four tables
select o.order_id, p.product_name, oi.quantity, oi.unit_price, oi.discount_pct, c.first_name, c.last_name
from orders o
join customers c on o.customer_id = c.customer_id
join order_items oi on o.order_id = oi.order_id
join products p on oi.product_id = p.product_id;

-- Q22. LEFT JOIN returns all rows from left table and matching rows from right table.
-- RIGHT JOIN returns all rows from right table and matching rows from left table.

-- Example:
select * from customers c left join orders o on c.customer_id = o.customer_id;
select * from customers c right join orders o on c.customer_id = o.customer_id;

/*
Q23. Foreign Key Relationships

Mappings:
- orders.customer_id -> links to customers.customer_id
- order_items.order_id -> links to orders.order_id
- order_items.product_id -> links to products.product_id

What Foreign Keys do:
They maintain referential integrity, meaning they stop you from inserting messy or broken data that doesn't connect to anything.

Example:
If I try to insert a fake order under a user that doesn't exist:

insert into orders values (2000, 999, '2024-09-01', 'Pending', 1000);

This fails instantly because customer_id 999 isn't real in our customers table. MySQL drops a Foreign Key Constraint Error to protect the database from orphan records.
*/