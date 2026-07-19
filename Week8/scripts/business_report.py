import pandas as pd
import matplotlib.pyplot as plt
import os

# Create output folder
os.makedirs("output/sample_reports", exist_ok=True)

# Load cleaned data
customers = pd.read_csv("data/cleaned/customers_clean.csv")
products = pd.read_csv("data/cleaned/products_clean.csv")
orders = pd.read_csv("data/cleaned/orders_clean.csv")
order_items = pd.read_csv("data/cleaned/order_items_clean.csv")

# Merge datasets
df = order_items.merge(products, on="product_id")
df = df.merge(orders, on="order_id")
df = df.merge(customers, on="customer_id")

# Revenue column
df["Revenue"] = (
    df["quantity"] *
    df["unit_price"] *
    (1 - df["discount_percent"] / 100)
)

print("Dataset merged successfully!")


# -----------------------------
# KPI 1: Revenue by Category
# -----------------------------

category_revenue = (
    df.groupby("category")["Revenue"]
    .sum()
    .sort_values(ascending=False)
)

category_revenue.to_csv(
    "output/sample_reports/category_revenue.csv"
)

plt.figure(figsize=(8,5))
category_revenue.plot(kind="bar")
plt.title("Revenue by Category")
plt.xlabel("Category")
plt.ylabel("Revenue")
plt.tight_layout()
plt.savefig("output/sample_reports/category_revenue.png")
plt.close()

# -----------------------------
# KPI 2: Orders by Status
# -----------------------------

status_orders = orders["status"].value_counts()

status_orders.to_csv(
    "output/sample_reports/orders_by_status.csv"
)

plt.figure(figsize=(6,6))
status_orders.plot(kind="pie", autopct="%1.1f%%")
plt.ylabel("")
plt.title("Orders by Status")
plt.tight_layout()
plt.savefig("output/sample_reports/orders_by_status.png")
plt.close()

# -----------------------------
# KPI 3: Top 10 Products
# -----------------------------

top_products = (
    df.groupby("product_name")["Revenue"]
    .sum()
    .sort_values(ascending=False)
    .head(10)
)

top_products.to_csv(
    "output/sample_reports/top_products.csv"
)

plt.figure(figsize=(10,5))
top_products.plot(kind="bar")
plt.title("Top 10 Products by Revenue")
plt.xlabel("Product")
plt.ylabel("Revenue")
plt.tight_layout()
plt.savefig("output/sample_reports/top_products.png")
plt.close()

print("Business reports generated successfully!")