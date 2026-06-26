# Week 5 Assignment Apache Spark Fundamentals

## Objective

The objective of this assignment was to understand the basics of Apache Spark and perform data cleaning, filtering, transformation, and aggregation using Spark DataFrames.

This assignment helped me understand how Spark handles data faster than traditional systems and how DataFrames can be used for processing structured data.

## Introduction

Apache Spark is a big data processing framework used for handling large datasets quickly and efficiently. Unlike MapReduce, Spark works mainly in memory, which makes it much faster for repeated tasks.

In this assignment, I worked on a small custom dataset and used Spark to clean and process the data step by step.

## Dataset Used

For this assignment, I created a simple dataset manually containing:

id

name

age

category

salary

region

The dataset included duplicate records, missing values, and incorrect values so that data cleaning operations could be performed properly.

## Step 1 Understanding Spark Basics

Before starting the practical work, I studied the difference between MapReduce and Spark.

MapReduce reads and writes data from disk after every step, which makes it slower.

Spark keeps intermediate data in memory, making it faster and more efficient.

I also understood the concept of DataFrames and immutability in Spark.

## Step 2 Starting Spark Session

I used Google Colab and installed PySpark.

After installation, I created a Spark session which is required to start working with DataFrames.

This was the starting point of all further operations.

## Step 3 Loading the Dataset

The dataset was uploaded into Google Colab and loaded into a Spark DataFrame.

After loading, I checked:

the schema

column names

data types

the first few rows

This helped me understand the structure of the dataset.

## Step 4 Data Cleaning

In this step, I cleaned the dataset by:

removing duplicate rows

handling missing salary values

identifying invalid age values

removing rows where important data was missing

This step helped improve data quality before analysis.

## Step 5 Filtering Data

After cleaning, I applied filters to select only relevant records.

I filtered the dataset based on:

age greater than or equal to 30

region not equal to South

This reduced unnecessary records and made analysis easier.

## Step 6 Data Transformation

In this step, I changed the datatype of the age column into integer format.

This step helped in making sure that numerical operations could be performed correctly.

## Step 7 Aggregation

I used aggregation functions to calculate:

total number of rows

average salary

These functions helped summarize the data.

## Step 8 Grouping Data

I grouped the dataset by category and counted the number of records in each category.

This helped me understand how data can be organized and analyzed based on groups.

## Step 9 Wide Transformations and Shuffle

I learned that operations like groupBy are wide transformations because they move data across partitions.

This process is called shuffle.

Shuffle can make processing slower because Spark has to move data between different machines or partitions.

## Step 10 Final Data Pipeline

At the end, I created a complete processing pipeline which included:

loading the data

removing duplicates

handling null values

filtering records

transforming columns

grouping data

performing aggregations

saving the final output

This gave me a complete understanding of how Spark pipelines work.

## Observations

I observed that data cleaning is one of the most important steps before performing analysis.

Removing duplicates and handling missing values improved the quality of the output.

Filtering helped focus only on useful records.

Grouping and aggregation helped summarize the dataset in a meaningful way.

## Conclusion

This assignment gave me practical understanding of Apache Spark and how DataFrames work.

I learned how Spark makes data processing easier and faster through in memory computing.

This assignment also improved my understanding of data cleaning, filtering, transformations, and aggregation, which are important steps in data engineering.
