-- Create Database
CREATE DATABASE IF NOT EXISTS ecommerce_analytics;

USE ecommerce_analytics;

-- Customers Table
CREATE TABLE IF NOT EXISTS customers (
    customer_id VARCHAR(20) PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    registration_date DATE,
    customer_type VARCHAR(20)
);

-- Products Table
CREATE TABLE IF NOT EXISTS products (
    product_id VARCHAR(20) PRIMARY KEY,
    product_name VARCHAR(150) NOT NULL,
    category VARCHAR(50),
    subcategory VARCHAR(50),
    cost_price DECIMAL(10,2)
);

-- Orders Table
CREATE TABLE IF NOT EXISTS orders (
    order_id VARCHAR(20) PRIMARY KEY,
    customer_id VARCHAR(20) NOT NULL,
    order_date DATE,
    status VARCHAR(30),
    region_code VARCHAR(30),

    CONSTRAINT fk_customer
        FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
);

-- Order Items Table
CREATE TABLE IF NOT EXISTS order_items (
    item_id VARCHAR(20) PRIMARY KEY,
    order_id VARCHAR(20) NOT NULL,
    product_id VARCHAR(20) NOT NULL,
    quantity INT,
    unit_price DECIMAL(10,2),
    discount_percent DECIMAL(5,2),

    CONSTRAINT fk_order
        FOREIGN KEY (order_id)
        REFERENCES orders(order_id),

    CONSTRAINT fk_product
        FOREIGN KEY (product_id)
        REFERENCES products(product_id)
);