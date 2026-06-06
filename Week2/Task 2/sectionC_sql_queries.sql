-- Q13. Total number of orders
SELECT COUNT(*) AS total_orders
FROM orders;

-- Q14. Total revenue from Delivered orders
SELECT SUM(total_amount) AS total_revenue
FROM orders
WHERE status='Delivered';

-- Q15. Average product price by category
SELECT category,
       AVG(unit_price) AS average_price
FROM products
GROUP BY category;

-- Q16. Count of orders and total revenue by status
SELECT status,
       COUNT(*) AS order_count,
       SUM(total_amount) AS total_revenue
FROM orders
GROUP BY status
ORDER BY total_revenue DESC;

-- Q17. Most expensive and cheapest product
SELECT MAX(unit_price) AS highest_price,
       MIN(unit_price) AS lowest_price
FROM products;

-- Q18. Categories with average price greater than 2000
SELECT category,
       AVG(unit_price) AS avg_price
FROM products
GROUP BY category
HAVING AVG(unit_price) > 2000;