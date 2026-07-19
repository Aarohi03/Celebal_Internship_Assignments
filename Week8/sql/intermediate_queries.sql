USE ecommerce_analytics;

-- 1. Monthly Revenue
SELECT
    YEAR(o.order_date) AS order_year,
    MONTH(o.order_date) AS order_month,
    ROUND(SUM(oi.quantity * oi.unit_price * (1 - oi.discount_percent/100)), 2) AS revenue
FROM orders o
JOIN order_items oi
ON o.order_id = oi.order_id
GROUP BY YEAR(o.order_date), MONTH(o.order_date)
ORDER BY order_year, order_month;

-- 2. Revenue by Region
SELECT
    o.region_code,
    ROUND(SUM(oi.quantity * oi.unit_price * (1 - oi.discount_percent/100)), 2) AS revenue
FROM orders o
JOIN order_items oi
ON o.order_id = oi.order_id
GROUP BY o.region_code
ORDER BY revenue DESC;

-- 3. Average Order Value
SELECT
    ROUND(AVG(order_total), 2) AS average_order_value
FROM (
    SELECT
        o.order_id,
        SUM(oi.quantity * oi.unit_price * (1 - oi.discount_percent/100)) AS order_total
    FROM orders o
    JOIN order_items oi
    ON o.order_id = oi.order_id
    GROUP BY o.order_id
) t;

-- 4. Customer Type-wise Revenue
SELECT
    c.customer_type,
    ROUND(SUM(oi.quantity * oi.unit_price * (1 - oi.discount_percent/100)), 2) AS revenue
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
JOIN order_items oi
ON o.order_id = oi.order_id
GROUP BY c.customer_type
ORDER BY revenue DESC;

-- 5. Top 5 Categories by Revenue
SELECT
    p.category,
    ROUND(SUM(oi.quantity * oi.unit_price * (1 - oi.discount_percent/100)), 2) AS revenue
FROM products p
JOIN order_items oi
ON p.product_id = oi.product_id
GROUP BY p.category
ORDER BY revenue DESC
LIMIT 5;

-- 6. Cancelled Orders Count
SELECT
    COUNT(*) AS cancelled_orders
FROM orders
WHERE status = 'Cancelled';

-- 7. Returned Orders Count
SELECT
    COUNT(*) AS returned_orders
FROM orders
WHERE status = 'Returned';

-- 8. Highest Value Order
SELECT
    o.order_id,
    ROUND(SUM(oi.quantity * oi.unit_price * (1 - oi.discount_percent/100)), 2) AS order_value
FROM orders o
JOIN order_items oi
ON o.order_id = oi.order_id
GROUP BY o.order_id
ORDER BY order_value DESC
LIMIT 1;