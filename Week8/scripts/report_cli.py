import argparse
import mysql.connector
from tabulate import tabulate

conn = mysql.connector.connect(
    host="localhost",
    user="root",
    password="aarohi123",
    database="ecommerce_analytics"
)

cursor = conn.cursor()


def run_query(query):
    try:
        cursor.execute(query)
        rows = cursor.fetchall()

        if not rows:
            print("\nNo records found.\n")
            return

        headers = [i[0] for i in cursor.description]
        print(tabulate(rows, headers=headers, tablefmt="grid"))

    except Exception as e:
        print("Database Error:", e)


def revenue():
    query = """
    SELECT
        DATE_FORMAT(o.order_date,'%Y-%m') AS Month,
        ROUND(SUM(oi.quantity*oi.unit_price*(1-oi.discount_percent/100)),2) Revenue
    FROM orders o
    JOIN order_items oi
        ON o.order_id=oi.order_id
    GROUP BY Month
    ORDER BY Month;
    """
    run_query(query)


def top_customers():
    query = """
    SELECT
        c.customer_name,
        ROUND(SUM(
            oi.quantity*oi.unit_price*
            (1-oi.discount_percent/100)
        ),2) AS Revenue
    FROM customers c
    JOIN orders o
        ON c.customer_id=o.customer_id
    JOIN order_items oi
        ON o.order_id=oi.order_id
    GROUP BY c.customer_name
    ORDER BY Revenue DESC
    LIMIT 10;
    """
    run_query(query)


def top_products():
    query = """
    SELECT
        p.product_name,
        SUM(oi.quantity) Quantity,
        ROUND(SUM(
            oi.quantity*oi.unit_price*
            (1-oi.discount_percent/100)
        ),2) Revenue
    FROM products p
    JOIN order_items oi
        ON p.product_id=oi.product_id
    GROUP BY p.product_name
    ORDER BY Revenue DESC
    LIMIT 10;
    """
    run_query(query)


def retention():
    query = """
    SELECT
        DATE_FORMAT(MIN(order_date),'%Y-%m') Cohort,
        COUNT(DISTINCT customer_id) Customers
    FROM orders
    GROUP BY customer_id
    ORDER BY Cohort;
    """
    run_query(query)


parser = argparse.ArgumentParser()

parser.add_argument(
    "--report",
    required=True,
    choices=[
        "revenue",
        "top_customers",
        "top_products",
        "retention"
    ]
)

args = parser.parse_args()

if args.report == "revenue":
    revenue()

elif args.report == "top_customers":
    top_customers()

elif args.report == "top_products":
    top_products()

elif args.report == "retention":
    retention()

cursor.close()
conn.close()