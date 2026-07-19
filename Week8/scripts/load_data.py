import pandas as pd
import mysql.connector
import math

# -----------------------------
# MySQL Connection
# -----------------------------

conn = mysql.connector.connect(
    host="localhost",
    user="root",
    password="aarohi123",
    database="ecommerce_analytics"
)

cursor = conn.cursor()

# -----------------------------
# Read CSV Files
# -----------------------------

customers = pd.read_csv("data/cleaned/customers_clean.csv")
products = pd.read_csv("data/cleaned/products_clean.csv")
orders = pd.read_csv("data/cleaned/orders_clean.csv")
order_items = pd.read_csv("data/cleaned/order_items_clean.csv")


# Replace NaN with None
customers = customers.where(pd.notnull(customers), None)
products = products.where(pd.notnull(products), None)
orders = orders.where(pd.notnull(orders), None)
order_items = order_items.where(pd.notnull(order_items), None)

print("CSV files loaded successfully!")

# -----------------------------
# Customers
# -----------------------------

customer_query = """
INSERT INTO customers
(customer_id, customer_name, email, registration_date, customer_type)
VALUES (%s,%s,%s,%s,%s)
"""

customer_data = [tuple(row) for row in customers.itertuples(index=False, name=None)]
cursor.executemany(customer_query, customer_data)
conn.commit()

print("Customers inserted.")

# -----------------------------
# Products
# -----------------------------

product_query = """
INSERT INTO products
(product_id, product_name, category, subcategory, cost_price)
VALUES (%s,%s,%s,%s,%s)
"""

product_data = [tuple(row) for row in products.itertuples(index=False, name=None)]
cursor.executemany(product_query, product_data)
conn.commit()

print("Products inserted.")

# -----------------------------
# Orders
# -----------------------------

order_query = """
INSERT INTO orders
(order_id, customer_id, order_date, status, region_code)
VALUES (%s,%s,%s,%s,%s)
"""

order_data = []

for row in orders.itertuples(index=False, name=None):

    row = list(row)

    if pd.isna(row[2]):
        row[2] = None

    order_data.append(tuple(row))

cursor.executemany(order_query, order_data)
conn.commit()

print("Orders inserted.")

# -----------------------------
# Order Items
# -----------------------------

item_query = """
INSERT INTO order_items
(item_id, order_id, product_id, quantity, unit_price, discount_percent)
VALUES (%s,%s,%s,%s,%s,%s)
"""

item_data = [tuple(row) for row in order_items.itertuples(index=False, name=None)]
cursor.executemany(item_query, item_data)
conn.commit()

print("Order Items inserted.")

cursor.close()
conn.close()

print("\nAll data inserted successfully!")