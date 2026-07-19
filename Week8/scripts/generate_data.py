# Import libraries

import pandas as pd
import random
from faker import Faker
import os

fake = Faker()

random.seed(42)
Faker.seed(42)

# Create folders if they don't exist

os.makedirs("data/raw", exist_ok=True)

# Number of records

NUM_CUSTOMERS = 600
NUM_PRODUCTS = 600
NUM_ORDERS = 3000
NUM_ORDER_ITEMS = 9000

# -------------------------------
# Generate Customers Dataset
# -------------------------------

customers = []

for i in range(1, NUM_CUSTOMERS + 1):

    customer_id = f"CUST{i:04d}"

    customer_name = fake.name()

    email = fake.email()

    registration_date = fake.date_between(start_date="-3y", end_date="today")

    customer_type = random.choice(["REGULAR", "PREMIUM", "VIP"])

    customers.append([
        customer_id,
        customer_name,
        email,
        registration_date,
        customer_type
    ])

customers_df = pd.DataFrame(customers, columns=[
    "customer_id",
    "customer_name",
    "email",
    "registration_date",
    "customer_type"
])

# Save CSV

customers_df.to_csv("data/raw/customers.csv", index=False)

print("customers.csv created successfully!")



# -------------------------------
# Generate Products Dataset
# -------------------------------

categories = {
    "Electronics": ["Mobile", "Laptop", "Headphones", "Camera"],
    "Clothing": ["Shirt", "Jeans", "Jacket", "Shoes"],
    "Home": ["Chair", "Table", "Sofa", "Lamp"],
    "Books": ["Novel", "Comics", "Biography", "Education"],
    "Beauty": ["Lipstick", "Perfume", "Cream", "Face Wash"]
}

products = []

for i in range(1, NUM_PRODUCTS + 1):

    product_id = f"PROD{i:04d}"

    category = random.choice(list(categories.keys()))

    subcategory = random.choice(categories[category])

    product_name = fake.word().title() + " " + subcategory

    cost_price = round(random.uniform(100, 5000), 2)

    products.append([
        product_id,
        product_name,
        category,
        subcategory,
        cost_price
    ])

products_df = pd.DataFrame(products, columns=[
    "product_id",
    "product_name",
    "category",
    "subcategory",
    "cost_price"
])

products_df.to_csv("data/raw/products.csv", index=False)

print("products.csv created successfully!")



# -------------------------------
# Generate Orders Dataset
# -------------------------------

statuses = ["Placed", "Shipped", "Delivered", "Cancelled", "Returned"]
regions = ["North", "South", "East", "West"]

orders = []

for i in range(1, NUM_ORDERS + 1):

    order_id = f"ORD{i:05d}"

    customer_id = f"CUST{random.randint(1, NUM_CUSTOMERS):04d}"

    order_date = fake.date_between(start_date="-2y", end_date="today")

    status = random.choice(statuses)

    region = random.choice(regions)

    orders.append([
        order_id,
        customer_id,
        order_date,
        status,
        region
    ])

orders_df = pd.DataFrame(orders, columns=[
    "order_id",
    "customer_id",
    "order_date",
    "status",
    "region_code"
])

orders_df.to_csv("data/raw/orders.csv", index=False)

print("orders.csv created successfully!")


# -------------------------------
# Generate Order Items Dataset
# -------------------------------

order_items = []

for i in range(1, NUM_ORDER_ITEMS + 1):

    item_id = f"ITEM{i:05d}"

    order_id = f"ORD{random.randint(1, NUM_ORDERS):05d}"

    product_id = f"PROD{random.randint(1, NUM_PRODUCTS):04d}"

    quantity = random.randint(1, 5)

    unit_price = round(random.uniform(150, 8000), 2)

    discount = random.choice([0, 5, 10, 15, 20, 25])

    order_items.append([
        item_id,
        order_id,
        product_id,
        quantity,
        unit_price,
        discount
    ])

order_items_df = pd.DataFrame(order_items, columns=[
    "item_id",
    "order_id",
    "product_id",
    "quantity",
    "unit_price",
    "discount_percent"
])

order_items_df.to_csv("data/raw/order_items.csv", index=False)

print("order_items.csv created successfully!")



# -------------------------------------
# Introduce Intentional Data Issues
# -------------------------------------

# 1. 5% NULL customer_id in orders
null_rows = random.sample(range(NUM_ORDERS), int(NUM_ORDERS * 0.05))
orders_df.loc[null_rows, "customer_id"] = None

# 2. 2% Invalid emails
invalid_email_rows = random.sample(range(NUM_CUSTOMERS), int(NUM_CUSTOMERS * 0.02))

for i in invalid_email_rows:
    customers_df.loc[i, "email"] = customers_df.loc[i, "email"].replace("@", "")

# 3. Mixed case product names
mixed_case_rows = random.sample(range(NUM_PRODUCTS), int(NUM_PRODUCTS * 0.10))

for i in mixed_case_rows:
    products_df.loc[i, "product_name"] = products_df.loc[i, "product_name"].upper()

# 4. 3% Negative quantity
negative_rows = random.sample(range(NUM_ORDER_ITEMS), int(NUM_ORDER_ITEMS * 0.03))

for i in negative_rows:
    order_items_df.loc[i, "quantity"] *= -1

# 5. Duplicate customers
customers_df = pd.concat([customers_df, customers_df.sample(10)], ignore_index=True)

# 6. Duplicate products
products_df = pd.concat([products_df, products_df.sample(10)], ignore_index=True)

# 7. Invalid customer IDs
wrong_customer_rows = random.sample(range(NUM_ORDERS), 15)

for i in wrong_customer_rows:
    orders_df.loc[i, "customer_id"] = "CUST9999"

# 8. Invalid product IDs
wrong_product_rows = random.sample(range(NUM_ORDER_ITEMS), 20)

for i in wrong_product_rows:
    order_items_df.loc[i, "product_id"] = "PROD9999"

# 9. Invalid dates
wrong_date_rows = random.sample(range(NUM_ORDERS), 15)

for i in wrong_date_rows:
    orders_df.loc[i, "order_date"] = "32-13-2025"

# 10. Quantity = 0
zero_rows = random.sample(range(NUM_ORDER_ITEMS), 20)

for i in zero_rows:
    order_items_df.loc[i, "quantity"] = 0

# 11. Discount greater than 100%
discount_rows = random.sample(range(NUM_ORDER_ITEMS), 20)

for i in discount_rows:
    order_items_df.loc[i, "discount_percent"] = 150

# -------------------------------------
# Save Final CSV Files
# -------------------------------------

customers_df.to_csv("data/raw/customers.csv", index=False)
products_df.to_csv("data/raw/products.csv", index=False)
orders_df.to_csv("data/raw/orders.csv", index=False)
order_items_df.to_csv("data/raw/order_items.csv", index=False)

print("\nAll datasets generated successfully!")
print("Intentional inconsistencies added successfully!")