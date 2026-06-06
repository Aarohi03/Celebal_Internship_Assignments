-- Q19.
-- Customer names with their orders

SELECT
o.order_id,
c.first_name,
c.last_name,
o.order_date,
o.total_amount
FROM customers c
JOIN orders o
ON c.customer_id=o.customer_id;

-- Q20.
-- List all customers and orders
-- including customers with no orders

SELECT
c.customer_id,
c.first_name,
c.last_name,
o.order_id
FROM customers c
LEFT JOIN orders o
ON c.customer_id=o.customer_id;

-- Q21.
-- Join all four tables

SELECT
o.order_id,
p.product_name,
oi.quantity,
oi.unit_price,
oi.discount_pct,
c.first_name,
c.last_name
FROM orders o
JOIN customers c
ON o.customer_id=c.customer_id
JOIN order_items oi
ON o.order_id=oi.order_id
JOIN products p
ON oi.product_id=p.product_id;

-- Q22.
-- LEFT JOIN returns all rows from left table
-- and matching rows from right table.

-- RIGHT JOIN returns all rows from right table
-- and matching rows from left table.

-- Example:

SELECT *
FROM customers c
LEFT JOIN orders o
ON c.customer_id=o.customer_id;

SELECT *
FROM customers c
RIGHT JOIN orders o
ON c.customer_id=o.customer_id;


/*
Q23. Foreign Key Relationships

1. orders.customer_id
   references customers.customer_id

2. order_items.order_id
   references orders.order_id

3. order_items.product_id
   references products.product_id

Purpose of Foreign Keys:
- Maintain referential integrity.
- Prevent invalid data from being inserted.

Example:

INSERT INTO orders
VALUES (
2000,
999,
'2024-09-01',
'Pending',
1000
);

This insertion will fail because:

customer_id = 999

does not exist in the customers table.

MySQL will generate a Foreign Key Constraint Error.

Therefore, foreign keys ensure that related records
exist before data is inserted.
*/