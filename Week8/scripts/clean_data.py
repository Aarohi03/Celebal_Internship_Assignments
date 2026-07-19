import pandas as pd
import os

# Create cleaned folder if it doesn't exist
os.makedirs("data/cleaned", exist_ok=True)

# Read datasets
customers = pd.read_csv("data/raw/customers.csv")
products = pd.read_csv("data/raw/products.csv")
orders = pd.read_csv("data/raw/orders.csv")
order_items = pd.read_csv("data/raw/order_items.csv")

print("Datasets loaded successfully!")


# ---------------------------------
# Remove Duplicate Records
# ---------------------------------

customers = customers.drop_duplicates()

products = products.drop_duplicates()

orders = orders.drop_duplicates()

order_items = order_items.drop_duplicates()

print("Duplicate records removed.")


# ---------------------------------
# Fix Invalid Emails
# ---------------------------------

customers["email"] = customers["email"].astype(str)

customers.loc[
    ~customers["email"].str.contains("@", na=False),
    "email"
] = "invalid@email.com"

print("Invalid emails fixed.")


# ---------------------------------
# Convert Order Date
# ---------------------------------

orders["order_date"] = pd.to_datetime(
    orders["order_date"],
    errors="coerce"
)

print("Invalid dates converted to NaT.")


# ---------------------------------
# Remove Negative and Zero Quantity
# ---------------------------------

order_items = order_items[order_items["quantity"] > 0]

print("Negative and zero quantities removed.")


# ---------------------------------
# Remove Invalid Customer IDs
# ---------------------------------

customers_ids = set(customers["customer_id"])

orders = orders[
    orders["customer_id"].isin(customers_ids)
]

print("Invalid customer IDs removed.")


# ---------------------------------
# Remove Invalid Product IDs
# ---------------------------------

product_ids = set(products["product_id"])

order_items = order_items[
    order_items["product_id"].isin(product_ids)
]

print("Invalid product IDs removed.")


# ---------------------------------
# Remove NULL Customer IDs
# ---------------------------------

orders = orders.dropna(subset=["customer_id"])

# Keep only orders that are referenced by order_items

valid_order_ids = set(orders["order_id"])

order_items = order_items[
    order_items["order_id"].isin(valid_order_ids)
]

print("NULL customer IDs removed.")


# ---------------------------------
# Save Cleaned Files
# ---------------------------------

customers.to_csv(
    "data/cleaned/customers_clean.csv",
    index=False
)

products.to_csv(
    "data/cleaned/products_clean.csv",
    index=False
)

orders.to_csv(
    "data/cleaned/orders_clean.csv",
    index=False
)

order_items.to_csv(
    "data/cleaned/order_items_clean.csv",
    index=False
)

print("Cleaned datasets saved successfully!")



# ---------------------------------
# Create Issue Report
# ---------------------------------

issue_report = pd.DataFrame({
    "Issue": [
        "Duplicate Customers Removed",
        "Duplicate Products Removed",
        "Duplicate Orders Removed",
        "Duplicate Order Items Removed",
        "Invalid Emails Fixed",
        "Invalid Dates Found",
        "Negative/Zero Quantities Removed",
        "Invalid Customer IDs Removed",
        "Invalid Product IDs Removed",
        "NULL Customer IDs Removed"
    ],
    "Status": [
        "Completed",
        "Completed",
        "Completed",
        "Completed",
        "Completed",
        "Completed",
        "Completed",
        "Completed",
        "Completed",
        "Completed"
    ]
})

issue_report.to_csv("data/cleaned/issue_report.csv", index=False)

print("Issue report created successfully!")