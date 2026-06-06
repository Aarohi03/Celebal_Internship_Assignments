-- Q24.
-- Categorize products using CASE

SELECT
product_name,
unit_price,
CASE
    WHEN unit_price < 1000 THEN 'Budget'
    WHEN unit_price BETWEEN 1000 AND 3000 THEN 'Mid-Range'
    ELSE 'Premium'
END AS price_tier
FROM products;

-- Q25.
-- Delivered vs Not Delivered orders

SELECT
SUM(CASE WHEN status='Delivered' THEN 1 ELSE 0 END)
AS delivered_orders,

SUM(CASE WHEN status<>'Delivered' THEN 1 ELSE 0 END)
AS not_delivered_orders
FROM orders;


/*
Q26. ACID Properties

A = Atomicity
- A transaction is treated as a single unit.
- Either all operations succeed or none succeed.

C = Consistency
- The database remains valid before and after a transaction.
- Rules and constraints are always maintained.

I = Isolation
- Multiple transactions do not interfere with each other.
- Each transaction behaves independently.

D = Durability
- Once a transaction is committed,
  the changes are permanently saved.

Real-world Example: Bank Transfer

Suppose ₹5000 is transferred from Account A to Account B.

Step 1:
Deduct ₹5000 from Account A.

Step 2:
Add ₹5000 to Account B.

Atomicity:
- If Step 2 fails, Step 1 is rolled back.

Consistency:
- Total money in the system remains correct.

Isolation:
- Other users cannot see incomplete transfer data.

Durability:
- After COMMIT, the transfer remains saved
  even if the system crashes.

Therefore, ACID properties ensure reliable and secure transactions.
*/

-- Q27.
START TRANSACTION;

INSERT INTO orders
(order_id, customer_id, order_date, status, total_amount)
VALUES
(1011,102,CURDATE(),'Pending',1598.00);

INSERT INTO order_items
(item_id, order_id, product_id, quantity, unit_price, discount_pct)
VALUES
(5014,1011,205,1,1598.00,0);

COMMIT;

-- If any statement fails:
-- ROLLBACK;

