-- Q24. Categorize products using CASE
select product_name, unit_price,
    case
        when unit_price < 1000 then 'Budget'
        when unit_price between 1000 and 3000 then 'Mid-Range'
        else 'Premium'
    end as price_tier
from products;

-- Q25. Delivered vs Not Delivered orders
select
    sum(case when status = 'Delivered' then 1 else 0 end) as delivered_orders,
    sum(case when status <> 'Delivered' then 1 else 0 end) as not_delivered_orders
from orders;

/*
Q26. ACID Properties

Breakdown of the 4 properties:
- Atomicity: The "all or nothing" rule. Everything in the transaction must succeed completely, or the whole thing gets rolled back to the start.
- Consistency: The database stays structurally valid. No constraints or business rules are broken before or after.
- Isolation: Transactions run independently. One active transaction won't mess with or see the mid-way data of another active transaction.
- Durability: Once a transaction hits COMMIT, the data is permanently locked into disk storage and won't be lost even during a power cut or system crash.

Real-world Scenario: Sending Money
Imagine sending Rs. 5000 from Acc A to Acc B (requires subtracting from A and adding to B).

- Atomicity makes sure that if the app crashes halfway through, Acc A gets their money back instead of it vanishing into thin air.
- Consistency ensures the total combined money across both accounts stays the same.
- Isolation keeps outside users from seeing the transient state where money left Acc A but hasn't arrived at Acc B yet.
- Durability guarantees that once the success screen shows up, a server crash a second later won't undo the transfer.
*/

-- Q27. Running a transaction manually
start transaction;

insert into orders (order_id, customer_id, order_date, status, total_amount)
values (1011, 102, curdate(), 'Pending', 1598.00);

insert into order_items (item_id, order_id, product_id, quantity, unit_price, discount_pct)
values (5014, 1011, 205, 1, 1598.00, 0);

commit;
-- Note: We use ROLLBACK - if things break mid-way

