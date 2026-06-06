CREATE DATABASE celebal_week2;
USE celebal_week2;
-- Explore Table
SELECT * FROM superstore LIMIT 10;
DESCRIBE superstore;

-- Filter data by Region
SELECT *
FROM superstore
WHERE Region = 'West';

-- Filter data by Category
SELECT *
FROM superstore
WHERE Category = 'Technology';

-- Filter data by Sales value
SELECT *
FROM superstore
WHERE Sales > 1000;

-- Filter data by Date
SELECT *
FROM superstore
WHERE STR_TO_DATE(`Order Date`, '%m/%d/%Y')>= '2017-01-01';

-- Total Sales by Category
SELECT Category,
       SUM(Sales) AS total_sales
FROM superstore
GROUP BY Category;

-- Total Quantity by Category
SELECT Category,
       SUM(Quantity) AS total_quantity
FROM superstore
GROUP BY Category;

-- Average Sales by Category
SELECT Category,
       AVG(Sales) AS average_sales
FROM superstore
GROUP BY Category;

-- Top 10 Products by Sales
SELECT `Product Name`,
       SUM(Sales) AS total_sales
FROM superstore
GROUP BY `Product Name`
ORDER BY total_sales DESC
LIMIT 10;

-- Top Categories by Sales
SELECT Category,
       SUM(Sales) AS total_sales
FROM superstore
GROUP BY Category
ORDER BY total_sales DESC;

-- Monthly Sales Trend Analysis
SELECT
    YEAR(STR_TO_DATE(`Order Date`, '%m/%d/%Y')) AS year,
    MONTH(STR_TO_DATE(`Order Date`, '%m/%d/%Y')) AS month,
    SUM(Sales) AS total_sales
FROM superstore
GROUP BY year, month
ORDER BY year, month;

-- Top 10 Customers by Sales
SELECT `Customer Name`,
       SUM(Sales) AS total_sales
FROM superstore
GROUP BY `Customer Name`
ORDER BY total_sales DESC
LIMIT 10;

-- Check Duplicate Order IDs
SELECT `Order ID`,
       COUNT(*) AS duplicate_count
FROM superstore
GROUP BY `Order ID`
HAVING COUNT(*) > 1;

-- Total Row Count
SELECT COUNT(*) AS total_rows
FROM superstore;

-- Check for NULL values in important columns
SELECT
    SUM(CASE WHEN Sales IS NULL THEN 1 ELSE 0 END) AS null_sales,
    SUM(CASE WHEN Quantity IS NULL THEN 1 ELSE 0 END) AS null_quantity,
    SUM(CASE WHEN Category IS NULL THEN 1 ELSE 0 END) AS null_category
FROM superstore;