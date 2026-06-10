-- SECTION A

use celebal_week2_task2;

-- Q1. Display all columns and rows from customers table
select * from customers;

-- Q2. Display first_name, last_name and city of all customers
select first_name, last_name, city from customers;

-- Q3. List all unique product categories
select distinct category from products;

/*
Q4. Primary Keys in the database

- customers table: customer_id
- products table: product_id
- orders table: order_id
- order_items table: item_id

Quick Explanation:
A PK uniquely identifies a specific row in a table so there's no confusion.

Why Unique?
To make sure every single row can be pulled up separately. If IDs could repeat, we wouldn't know which record is which.

Why Not Null?
Every single record needs to have a valid ID. An empty or unknown value (NULL) can't act as a proper identifier.

Example:
Two different customers can't share the same customer_id, and you can't leave the ID field blank when creating a new customer.
*/

/*
Q5. Constraints on email column

email VARCHAR(100) UNIQUE NOT NULL

Explanation:

1. NOT NULL
   - Means the email field can't be left blank. Every customer profile requires an email address.

2. UNIQUE
   - Prevents two customers from signing up with the exact same email address.

Example:
If I try to run this query when 'aarav.s@email.com' is already taken:

insert into customers values (999, 'Test', 'User', 'aarav.s@email.com', 'Delhi', 'Delhi', '2024-01-01', false);

It will fail. MySQL will throw an error saying the UNIQUE constraint was violated because that email already exists in the database.
*/

-- Q6. Insert a product with negative price

insert into products values (999, 'Test Product', 'Electronics', 'TestBrand', -50, 10);

/*
Result:
The query will fail and reject the insertion.

Reason:
The products table has a validation rule set up:
CHECK (unit_price > 0)

This rule forces all product prices to be positive numbers. Because -50 is less than zero, it triggers a CHECK constraint violation error.
*/