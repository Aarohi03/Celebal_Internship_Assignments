USE ecommerce_analytics;

-- 1. Total Revenue per Customer
SELECT
    c.customer_id,
    c.customer_name,
    ROUND(SUM(oi.quantity * oi.unit_price * (1 - oi.discount_percent/100)),2) AS total_revenue
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_revenue DESC;

-- 2. Total Revenue per Category
SELECT
    p.category,
    ROUND(SUM(oi.quantity * oi.unit_price * (1 - oi.discount_percent/100)),2) AS total_revenue
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.category
ORDER BY total_revenue DESC;

-- 3. Total Revenue per Month
SELECT
    DATE_FORMAT(o.order_date,'%Y-%m') AS month,
    ROUND(SUM(oi.quantity * oi.unit_price * (1 - oi.discount_percent/100)),2) AS total_revenue
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY month
ORDER BY month;

-- 4. Top Products by Quantity Sold
SELECT
    p.product_name,
    SUM(oi.quantity) AS quantity_sold
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.product_name
ORDER BY quantity_sold DESC
LIMIT 10;

-- 5. Top Products by Revenue
SELECT
    p.product_name,
    ROUND(SUM(oi.quantity * oi.unit_price * (1 - oi.discount_percent/100)),2) AS revenue
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.product_name
ORDER BY revenue DESC
LIMIT 10;

-- 6. Average Order Value (AOV) by Customer Segment
SELECT
    c.customer_type,
    ROUND(AVG(order_total),2) AS average_order_value
FROM (
    SELECT
        o.order_id,
        o.customer_id,
        SUM(oi.quantity * oi.unit_price * (1 - oi.discount_percent/100)) AS order_total
    FROM orders o
    JOIN order_items oi
        ON o.order_id = oi.order_id
    GROUP BY o.order_id, o.customer_id
) t
JOIN customers c
ON t.customer_id = c.customer_id
GROUP BY c.customer_type;