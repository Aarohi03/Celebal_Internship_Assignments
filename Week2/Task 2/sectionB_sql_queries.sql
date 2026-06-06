-- Q7. Orders with status Delivered
SELECT *
FROM orders
WHERE status='Delivered';

-- Q8. Electronics products with price greater than 2000
SELECT *
FROM products
WHERE category='Electronics'
AND unit_price > 2000;

-- Q9. Customers who joined in 2024 and belong to Maharashtra
SELECT *
FROM customers
WHERE YEAR(join_date)=2024
AND state='Maharashtra';

-- Q10. Orders between 2024-08-10 and 2024-08-25
-- excluding cancelled orders

SELECT *
FROM orders
WHERE order_date BETWEEN '2024-08-10' AND '2024-08-25'
AND status <> 'Cancelled';

/*
Q11. How does the index on order_date help?

An index works like the index of a book.

Without Index:
- MySQL checks every row in the table.
- This is called a Full Table Scan.
- It becomes slow when the table contains many records.

With Index:
- MySQL directly jumps to the required date range.
- Fewer rows are scanned.
- Query execution becomes faster.

Example:

SELECT *
FROM orders
WHERE order_date BETWEEN '2024-08-10'
AND '2024-08-25';

This query can use the index on order_date
to locate matching records quickly.

Therefore, indexes improve search and filtering performance.
*/

-- Q12.
-- Original query:
SELECT *
FROM customers
WHERE YEAR(join_date)=2024;

-- Index-friendly version
SELECT *
FROM customers
WHERE join_date >= '2024-01-01'
AND join_date < '2025-01-01';