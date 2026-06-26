# Week 5 Assignment Document Answers

## Q1. What are the key limitations of traditional MapReduce?

MapReduce is useful for processing large data, but it is slower because it reads and writes data to disk after every step. It also needs more coding for simple tasks. This makes it less efficient for modern big data work.

## Q2. How does Spark use In Memory Computing to speed up processing?

Spark stores intermediate data in memory instead of disk. This saves time because the data does not need to be loaded again and again. It is especially helpful in machine learning where the same data is used multiple times.

## Q3. Remove duplicate rows based on user_id and transaction_date

```python
df.dropDuplicates(["user_id", "transaction_date"])
```

This removes all duplicate rows based on these two columns.

## Q4. Filter rows where region is West and find average sale amount by product category

```python
df_sales.filter(df_sales.region == "West").groupBy("product_category").avg("sale_amount")
```

This first filters the West region and then calculates average sale amount for each product category.

## Q5. Difference between na.drop() and na.fill()

na.drop() removes rows that contain null values.

na.fill() replaces null values with a specific value.

Example:

```python
df.na.fill({"status": "Unknown"})
```

This fills empty status values with Unknown.

## Q6. Find total count of records for each city where count is greater than 100

```python
from pyspark.sql.functions import col

df.groupBy("city").count().filter(col("count") > 100)
```

This groups records by city and shows only those cities where total records are more than 100.

## Q7. How does immutability affect data cleaning?

Spark DataFrames are immutable which means the original data cannot be changed directly. Whenever we perform operations like dropping or renaming columns, Spark creates a new DataFrame.

This keeps the original data safe.

## Q8. Filter dataset where age is between 18 and 30 and subscription is Premium

```python
df.filter((df.age >= 18) & (df.age <= 30) & (df.subscription == "Premium"))
```

This filters only Premium users whose age is between 18 and 30.

## Q9. Why should null values be handled before sum() or avg()?

If null values are not handled, calculations can give wrong results or errors. It is better to clean them first so the output becomes accurate.

## Q10. Cast raw_timestamp to TimestampType and rename it

```python
df = df.withColumn("raw_timestamp", df["raw_timestamp"].cast("timestamp"))
df = df.withColumnRenamed("raw_timestamp", "event_time")
```

This converts the column into timestamp format and changes its name.

## Q11. What is Shuffle and why is it a wide transformation?

Shuffle happens when Spark moves data from one partition to another. This usually happens in operations like groupBy or join.

It is called a wide transformation because data is moved across partitions, which can make execution slower.

## Q12. Remove rows where email is null or username is empty

```python
df.filter(df.email.isNotNull() & (df.username != ""))
```

This keeps only valid rows where email is present and username is not empty.

## Q13. Use agg() to calculate minimum, maximum and mean of price

```python
from pyspark.sql.functions import min, max, mean

df.agg(
    min("price").alias("minimum_price"),
    max("price").alias("maximum_price"),
    mean("price").alias("average_price")
).show()
```

This calculates all three values together.

## Q14. What is the risk of using inferSchema with messy date formats?

If the date format is not consistent, Spark may detect the wrong data type. This can cause problems while processing or converting dates later.

So it is important to check the schema properly.

## Q15. Write a final processing pipeline

```python
from pyspark.sql.functions import sum

final_df = df.dropDuplicates() \
             .na.fill({"price": 0}) \
             .groupBy("store_id") \
             .agg(sum("price").alias("total_revenue"))

final_df.show()
```

This pipeline removes duplicates, fills missing prices with zero, groups data by store id and calculates total revenue.
