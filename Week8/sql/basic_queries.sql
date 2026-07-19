USE ecommerce_analytics;

-- 1. Total Customers
SELECT COUNT(*) AS total_customers
FROM customers;

-- 2. Total Products
SELECT COUNT(*) AS total_products
FROM products;

-- 3. Total Orders
SELECT COUNT(*) AS total_orders
FROM orders;

-- 4. Total Revenue
SELECT
    SUM(quantity * unit_price * (1 - discount_percent / 100)) AS total_revenue
FROM order_items;

-- 5. Orders by Status
SELECT
    status,
    COUNT(*) AS total_orders
FROM orders
GROUP BY status;

-- 6. Revenue by Category
SELECT
    p.category,
    ROUND(SUM(oi.quantity * oi.unit_price * (1 - oi.discount_percent / 100)),2) AS revenue
FROM order_items oi
JOIN products p
ON oi.product_id = p.product_id
GROUP BY p.category
ORDER BY revenue DESC;

-- 7. Top 10 Customers by Spending
SELECT
    c.customer_id,
    c.customer_name,
    ROUND(SUM(oi.quantity * oi.unit_price * (1 - oi.discount_percent / 100)),2) AS total_spent
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
JOIN order_items oi
ON o.order_id = oi.order_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_spent DESC
LIMIT 10;

-- 8. Top 10 Selling Products
SELECT
    p.product_name,
    SUM(oi.quantity) AS quantity_sold
FROM products p
JOIN order_items oi
ON p.product_id = oi.product_id
GROUP BY p.product_name
ORDER BY quantity_sold DESC
LIMIT 10;