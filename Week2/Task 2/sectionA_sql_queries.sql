-- SECTION A

USE celebal_week2_task2;

-- Q1. Display all columns and rows from customers table
SELECT * FROM customers;

-- Q2. Display first_name, last_name and city of all customers
SELECT first_name, last_name, city
FROM customers;

-- Q3. List all unique product categories
SELECT DISTINCT category
FROM products;

/*
Q4. Primary Keys in the database

customers    -> customer_id
products     -> product_id
orders       -> order_id
order_items  -> item_id

Explanation:
A Primary Key uniquely identifies each record in a table.

Why must it be UNIQUE?
- So that every row can be identified separately.
- Duplicate primary key values would create ambiguity.

Why must it be NOT NULL?
- Every record must have an identifier.
- NULL means "unknown value", which cannot uniquely identify a row.

Example:
Two customers cannot have the same customer_id.
Also, customer_id cannot be left empty (NULL).
*/

/*
Q5. Constraints on email column

email VARCHAR(100) UNIQUE NOT NULL

Explanation:

1. NOT NULL
   - Email cannot be left empty.
   - Every customer record must contain an email address.

2. UNIQUE
   - Duplicate email addresses are not allowed.
   - Each customer must have a different email.

Example:

This will fail because email already exists:

INSERT INTO customers
VALUES (
999,
'Test',
'User',
'aarav.s@email.com',
'Delhi',
'Delhi',
'2024-01-01',
FALSE
);

Reason:
The email 'aarav.s@email.com' already belongs to another customer.
MySQL will throw a UNIQUE constraint violation error.
*/

/*
Q6. Insert a product with negative price

INSERT INTO products
VALUES (
999,
'Test Product',
'Electronics',
'TestBrand',
-50,
10
);

Result:
The insertion will fail.

Reason:
The products table contains:

CHECK (unit_price > 0)

This constraint ensures that product prices
must always be greater than zero.

Since -50 is a negative value,
it violates the CHECK constraint.

MySQL will reject the record.
*/