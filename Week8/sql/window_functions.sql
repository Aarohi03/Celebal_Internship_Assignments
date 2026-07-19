USE ecommerce_analytics;

-- 1. Rank Customers by Revenue
SELECT
    customer_id,
    customer_name,
    total_revenue,
    RANK() OVER (ORDER BY total_revenue DESC) AS revenue_rank
FROM (
    SELECT
        c.customer_id,
        c.customer_name,
        SUM(oi.quantity * oi.unit_price * (1 - oi.discount_percent/100)) AS total_revenue
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
    JOIN order_items oi ON o.order_id = oi.order_id
    GROUP BY c.customer_id, c.customer_name
) t;

-- 2. Dense Rank Products by Revenue
SELECT
    product_name,
    revenue,
    DENSE_RANK() OVER (ORDER BY revenue DESC) AS product_rank
FROM (
    SELECT
        p.product_name,
        SUM(oi.quantity * oi.unit_price * (1 - oi.discount_percent/100)) AS revenue
    FROM products p
    JOIN order_items oi ON p.product_id = oi.product_id
    GROUP BY p.product_name
) t;

-- 3. Running Monthly Revenue
SELECT
    month,
    revenue,
    SUM(revenue) OVER (ORDER BY month) AS running_revenue
FROM (
    SELECT
        DATE_FORMAT(o.order_date,'%Y-%m') AS month,
        SUM(oi.quantity * oi.unit_price * (1 - oi.discount_percent/100)) AS revenue
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    GROUP BY month
) t;

-- 4. Average Revenue by Customer Type
SELECT
    customer_type,
    total_revenue,
    AVG(total_revenue) OVER (PARTITION BY customer_type) AS avg_customer_type_revenue
FROM (
    SELECT
        c.customer_type,
        c.customer_id,
        SUM(oi.quantity * oi.unit_price * (1 - oi.discount_percent/100)) AS total_revenue
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
    JOIN order_items oi ON o.order_id = oi.order_id
    GROUP BY c.customer_type, c.customer_id
) t;

-- 5. CTE - Top 5 Customers
WITH CustomerRevenue AS (
    SELECT
        c.customer_id,
        c.customer_name,
        SUM(oi.quantity * oi.unit_price * (1 - oi.discount_percent/100)) AS revenue
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
    JOIN order_items oi ON o.order_id = oi.order_id
    GROUP BY c.customer_id, c.customer_name
)
SELECT *
FROM CustomerRevenue
ORDER BY revenue DESC
LIMIT 5;