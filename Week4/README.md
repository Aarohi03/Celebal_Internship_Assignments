# Week 4 Assignment Azure Cloud Fundamentals and Data Pipeline Implementation

## Objective

The objective of this assignment was to understand the basic working of Microsoft Azure and build a simple end to end data pipeline using Azure Storage and Azure Data Factory. The main focus was to understand how data moves inside cloud services, how resources are connected, and how pipelines can automate data movement.

## Overview

In this assignment I worked with the Sample Superstore dataset and used it as the source file for building the pipeline. The complete flow started from storing the file in Azure Blob Storage, validating the file through metadata checks, and then copying it into a new destination file using Azure Data Factory.

This assignment helped me understand how cloud based data engineering works in real projects where data first lands in storage and then gets processed through pipelines.

## Step 1 Resource Group Creation

I started by exploring the Azure portal and creating a Resource Group. A Resource Group acts like a container that keeps all related resources together. This makes resource management easier because everything related to one project stays in one place.

For this assignment I created a Resource Group named Celebal_week4.

## Step 2 Storage Setup

After creating the Resource Group, I created a Storage Account. This Storage Account was used to store the raw dataset.

Inside the Storage Account, I created a Blob Container named superstore data. This container works like a folder inside cloud storage where files can be uploaded and managed.

I then uploaded the Sample Superstore comma separated values file into the container. This file became the source dataset for the pipeline.

At this stage I understood how cloud storage works and how data is stored before processing.

## Step 3 Azure Data Factory Setup

The next step was creating Azure Data Factory. This is the service that allows building and managing data pipelines.

Inside Azure Data Factory Studio, I explored the main sections:

Author for creating datasets and pipelines

Manage for creating connections between resources

Monitor for checking pipeline execution

After that, I created a Linked Service between Azure Data Factory and Azure Blob Storage. This connection allowed the pipeline to access the uploaded file.

Then I created two datasets.

The first dataset was the source dataset which pointed to the uploaded Sample Superstore file.

The second dataset was the destination dataset where the processed file would be stored after pipeline execution.

This helped me understand how datasets act as references to data locations.

## Step 4 Metadata Validation

Before copying the file, I added a Get Metadata activity inside the pipeline.

This activity checked two important things.

First, whether the file exists.

Second, what the file size is.

This step is very important because in real world projects it helps validate data before processing it. It reduces the chances of pipeline failure.

Through this step I learned that checking metadata is like verifying whether the input is correct before starting work.

## Step 5 Pipeline Development

After metadata validation, I added a Copy Data activity in the pipeline.

The flow was simple.

First the pipeline checked the metadata of the source file.

Once validation was successful, it copied the source file into a new output file inside the same Blob Container.

The complete pipeline flow looked like this:

Source file to Metadata validation to Copy Data to Output file

This gave me practical understanding of how data pipelines are built and how activities are connected logically.

## Step 6 Pipeline Execution

After building the pipeline, I validated and published it.

Then I executed it using Debug mode.

The pipeline ran successfully and created the output file in the destination location.

This step gave me hands on experience in pipeline execution and monitoring.

It also showed me how Azure Data Factory reports pipeline success and errors.

## Step 7 Access Management

In the final step, I assigned access roles to Azure Data Factory so it could interact with the Storage Account.

I assigned Reader and Contributor permissions.

This step helped me understand how access control works in Azure and why permissions are necessary for secure data processing.

Without proper access, pipelines cannot read or write files.

## Mini Project Implementation

The final mini project was about combining all the concepts into one working solution.

I built a complete pipeline that:

Read the Sample Superstore file from Blob Storage

Validated the file using metadata

Copied the file to a new output location

Successfully executed the pipeline

This project gave me a complete practical view of how cloud based data movement works in a structured and automated way.

## Key Learnings

Through this assignment I learned how to organize cloud resources properly

I understood the role of Storage Accounts and Blob Containers in storing data

I learned how Azure Data Factory connects with storage through Linked Services

I understood the importance of datasets as source and destination references

I learned why metadata validation is important before processing data

I gained practical knowledge of pipeline creation and execution

I understood how access control improves security in cloud systems

## Conclusion

This assignment gave me a strong foundation in Azure cloud services and practical pipeline building. It helped me understand how data engineering workflows are built in cloud environments.

Instead of only learning theory, I was able to create a working pipeline from start to finish. This made the concepts much clearer and gave me confidence to work on more advanced cloud based data engineering projects in the future.
