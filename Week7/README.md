# Week 7: Delta Lake MERGE Implementation

## Objective

The objective of this assignment was to understand how Delta Lake MERGE works in Databricks by performing incremental data processing. The assignment focused on updating existing records and inserting new records using the MERGE operation.

---

## Tools Used

- Databricks Community Edition
- Apache Spark
- PySpark
- Delta Lake
- Python

---

## Dataset

The Superstore dataset was used for this assignment.

- **superstore_master.csv** – Original dataset used to create the Delta table.
- **superstore_incremental.csv** – Dataset containing updated and new records for the MERGE operation.

---

## Tasks Performed

- Loaded the master dataset into a Spark DataFrame.
- Performed basic data cleaning by handling null values and removing duplicate records.
- Renamed column names to make them compatible with Delta Lake.
- Created a Delta table from the cleaned dataset.
- Loaded the incremental dataset.
- Applied the Delta Lake MERGE operation to update existing records and insert new records.
- Validated the results by checking the total number of records and duplicate Row IDs.
- Displayed the final merged dataset.

---

## Project Structure

```text
Week7/
│
├── data/
│   ├── superstore_master.csv
│   └── superstore_incremental.csv
│
├── notebook/
│   └── Celebal_Week7_Aarohi.ipynb
│
├── screenshots/
│   ├── data_loading.png
│   ├── data_cleaning.png
│   ├── merge_operation.png
│   ├── validation.png
│   └── final_output.png
│
└── README.md
```

---

## Learning Outcomes

Through this assignment, I learned how Delta Lake MERGE is used to perform incremental data processing. I understood how existing records can be updated and new records can be inserted in a single operation. I also learned how to prepare data for Delta Lake and validate the final output after performing the MERGE operation.