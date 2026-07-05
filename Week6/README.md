# Week 6: Apache Spark Architecture and Data Processing

## Objective

The objective of this assignment was to understand the basic architecture of Apache Spark and learn how Spark processes large datasets efficiently using DataFrames. The assignment also focused on data cleaning, filtering, transformations, schema handling, different file formats, and building a simple Spark data processing pipeline.

---

## Tools Used

- Apache Spark
- PySpark
- Databricks Community Edition
- Python

---

## Dataset

A sample dataset containing more than 150 records was used for this assignment. The dataset includes information such as product details, category, region, quantity, price, order status, and other related fields.

---

## Tasks Performed

During this assignment, the following tasks were completed:

- Imported the required PySpark libraries.
- Read a CSV file into a Spark DataFrame.
- Displayed the dataset and verified the schema.
- Counted the total number of records.
- Selected only the required columns.
- Filtered records using different conditions.
- Renamed columns for better understanding.
- Converted the data type of a column.
- Added a new calculated column.
- Handled missing values.
- Removed duplicate records.
- Applied groupBy and aggregation functions.
- Understood Lazy Evaluation and viewed the execution plan using explain().
- Saved the processed data in both CSV and Parquet formats.
- Read the Parquet file and compared it with the CSV file.
- Built a complete Read → Transform → Filter → Write data pipeline.
- Followed Spark best practices by using show() instead of collect() while viewing data.

---



## Output

The notebook successfully performs the required Spark operations and generates:

- Processed CSV output
- Processed Parquet output
- Execution results for transformations and actions
- Data pipeline execution results

---

## Learning Outcomes

After completing this assignment, I understood the basic architecture of Apache Spark and the role of the Driver, Cluster Manager, and Executors. I learned how Spark DataFrames are used for reading, filtering, transforming, and processing data efficiently. I also understood the concept of Lazy Evaluation, DAG, schema handling, wide transformations, shuffle, predicate pushdown, and the difference between CSV and Parquet file formats. This assignment helped me understand how Spark builds efficient data processing pipelines for handling large datasets.
