# Week 3 Assignment - Advanced SQL Analytics

## Objective

The objective of this assignment was to understand and practice advanced SQL concepts like subqueries, CTEs, and window functions. Using the Superstore dataset, the aim was to solve business-related questions and analyze customer sales performance.

## Dataset Used

* Sample - Superstore.csv

## Step by Step Work

### Step 1: Data Setup

First, the Superstore dataset was imported into MySQL as a raw table. After that, the data was divided into separate tables to make it more organized.

The tables created were:

* customers
* orders
* products

`select distinct` was used while creating these tables so duplicate records could be avoided.

---

### Step 2: Query Execution

In this step, different SQL queries were written for analysis.

The queries performed were:

1. Found all orders where sales were greater than average sales using a subquery.

2. Found the highest sales order for each customer using a correlated subquery.

3. Calculated total sales of each customer using CTE.

4. Found customers whose total sales were above average.

5. Ranked customers based on total sales using window functions.

6. Assigned row numbers to every order for each customer separately using partition by.

7. Displayed the top 3 customers based on total sales.

---

### Step 3: Final Combined Query

A final query was created by combining:

* CTE
* JOIN
* Window Function

This query shows:

* Customer Name
* Total Sales
* Rank

This helped in creating a proper customer sales ranking.

---

### Step 4: Mini Project

In the mini project, extra business questions were solved:

* Top 5 customers based on sales
* Bottom 5 customers based on sales
* Customers who placed only one order
* Customers with above-average sales
* Highest order value for each customer

---

## Brief Insights

After running all the queries, some important observations were found:

* A few customers are contributing much more sales than others.
* Some customers placed only one order, which may mean low engagement.
* Ranking customers makes it easier to identify the best-performing customers.
* Above-average customers can be targeted for loyalty programs and special offers.
* Lower-performing customers can be focused on for better retention.

---

## SQL Concepts Used

* Subqueries
* Correlated Subqueries
* CTE (Common Table Expressions)
* Window Functions (`rank()`, `row_number()`)

---

## Conclusion

This assignment helped me understand how advanced SQL can be used for solving business problems. It also improved my understanding of customer-based sales analysis and how multiple SQL concepts can be combined together for better insights.
