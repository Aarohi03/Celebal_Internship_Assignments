use celebal_week3;

-- 1. customers table
create table customers as
select distinct
    `customer id`,
    `customer name`,
    segment,
    country,
    city,
    state,
    region
from superstore_data;

-- 2. order table
create table orders as
select distinct
    `order id`,
    `order date`,
    `ship date`,
    `ship mode`,
    `customer id`,
    sales,
    quantity,
    discount,
    profit
from superstore_data;

-- 3. product table
create table products as
select distinct
    `product id`,
    category,
    `sub-category`,
    `product name`
from superstore_data;

-- quick check to make sure the data loaded correctly
select * from customers limit 5;
select * from orders limit 5;
select * from products limit 5;