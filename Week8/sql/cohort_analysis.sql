USE ecommerce_analytics;

-- 1. Customer Cohort
WITH CustomerCohort AS (
    SELECT
        customer_id,
        DATE_FORMAT(MIN(order_date), '%Y-%m') AS cohort_month
    FROM orders
    GROUP BY customer_id
)
SELECT *
FROM CustomerCohort
ORDER BY cohort_month;

-- 2. Monthly Customer Retention
WITH CustomerCohort AS (
    SELECT
        customer_id,
        DATE_FORMAT(MIN(order_date), '%Y-%m') AS cohort_month
    FROM orders
    GROUP BY customer_id
)
SELECT
    cc.cohort_month,
    DATE_FORMAT(o.order_date, '%Y-%m') AS order_month,
    COUNT(DISTINCT o.customer_id) AS retained_customers
FROM CustomerCohort cc
JOIN orders o
ON cc.customer_id = o.customer_id
GROUP BY cc.cohort_month, order_month
ORDER BY cc.cohort_month, order_month;

-- 3. Repeat Customers
SELECT
    customer_id,
    COUNT(order_id) AS total_orders
FROM orders
GROUP BY customer_id
HAVING COUNT(order_id) > 1
ORDER BY total_orders DESC;

-- 4. Customer Segmentation by Spending
WITH CustomerSpend AS (
    SELECT
        c.customer_id,
        c.customer_name,
        SUM(oi.quantity * oi.unit_price * (1 - oi.discount_percent/100)) AS total_spend
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    JOIN order_items oi
        ON o.order_id = oi.order_id
    GROUP BY c.customer_id, c.customer_name
)
SELECT
    customer_id,
    customer_name,
    total_spend,
    CASE
        WHEN total_spend >= 50000 THEN 'High Value'
        WHEN total_spend >= 20000 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS customer_segment
FROM CustomerSpend
ORDER BY total_spend DESC;