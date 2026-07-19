USE ecommerce_analytics;

-- 1. Top 10 Customers by Number of Orders
SELECT
    c.customer_id,
    c.customer_name,
    COUNT(o.order_id) AS total_orders
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_orders DESC
LIMIT 10;

-- 2. Customer Lifetime Value
SELECT
    c.customer_id,
    c.customer_name,
    ROUND(SUM(oi.quantity * oi.unit_price * (1 - oi.discount_percent/100)),2) AS lifetime_value
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
JOIN order_items oi
ON o.order_id = oi.order_id
GROUP BY c.customer_id, c.customer_name
ORDER BY lifetime_value DESC
LIMIT 10;

-- 3. Product Performance
SELECT
    p.product_name,
    COUNT(DISTINCT oi.order_id) AS orders_count,
    SUM(oi.quantity) AS total_quantity,
    ROUND(SUM(oi.quantity * oi.unit_price * (1 - oi.discount_percent/100)),2) AS revenue
FROM products p
JOIN order_items oi
ON p.product_id = oi.product_id
GROUP BY p.product_name
ORDER BY revenue DESC;

-- 4. Monthly Order Trend
SELECT
    DATE_FORMAT(order_date,'%Y-%m') AS month,
    COUNT(*) AS total_orders
FROM orders
GROUP BY month
ORDER BY month;

-- 5. Revenue Contribution by Customer Type
SELECT
    c.customer_type,
    ROUND(
        SUM(oi.quantity * oi.unit_price * (1 - oi.discount_percent/100)) /
        (
            SELECT SUM(quantity * unit_price * (1 - discount_percent/100))
            FROM order_items
        ) * 100,
        2
    ) AS revenue_percentage
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
JOIN order_items oi
ON o.order_id = oi.order_id
GROUP BY c.customer_type;

-- 6. Average Discount by Category
SELECT
    p.category,
    ROUND(AVG(oi.discount_percent),2) AS average_discount
FROM products p
JOIN order_items oi
ON p.product_id = oi.product_id
GROUP BY p.category
ORDER BY average_discount DESC;

-- 7. Most Popular Region
SELECT
    region_code,
    COUNT(*) AS total_orders
FROM orders
GROUP BY region_code
ORDER BY total_orders DESC
LIMIT 1;

-- 8. Top 5 Highest Revenue Orders
SELECT
    o.order_id,
    ROUND(SUM(oi.quantity * oi.unit_price * (1 - oi.discount_percent/100)),2) AS revenue
FROM orders o
JOIN order_items oi
ON o.order_id = oi.order_id
GROUP BY o.order_id
ORDER BY revenue DESC
LIMIT 5;