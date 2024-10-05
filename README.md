# Real Estate Sales Data Pipeline

## About the Data

The dataset contains all Connecticut real estate sales with a sales price of $2,000 or greater  
that occur between October 1 and September 30 of each year from 2001 - 2022.  
The data is a csv file which contains 1097629 rows and 14 columns, namely:

| Column Name | Description |
|------------ | ----------- |
| Serial Number | Serial number of the property |
| List Year | Year the property was listed for sale |
| Date Recorded | Date the sale was recorded locally |
| Town | Town the property is located |
| Address | Property Address |
| Assessed Value | Value of the property used for local tax assessment |
| Sale Amount | Amount the property was sold for |
| Sales Ratio | Ratio of the sale price to the assessed value |
| Property Type | Type of property |
| Residential Type | Type of Residence |
| Non Use Code | Determines whether sale price is not reliable for use in the determination of a property's value |
| Assessor Remarks | Remarks from the assessor on the property |
| OPM Remarks | Remarks from OPM on the property |
| Location | Geographic coordinates (Longitude, Latitude) |

## Problem Description
This pipeline project aims to answer these main questions:

- Which towns will most likely offer properties within my budget?
- What is the typical sale amount for each property type?
- What is the historical trend of real estate sales?

## Technology Stack
- Google Cloud Virtual Machine (Virtual Environment)
- Google Cloud Storage (Data Lake)
- BigQuery (Data Warehouse)
- Terraform (Infrastructure As Code)
- Docker & Docker Compose (Containerization)
- Mage (Workflow Orchestration)
- dbt Cloud (Transformation)
- Looker Studio (Visualization)

## [You can click here for the setup to reproduce the project](https://github.com/ranzbrendan/real_estate_sales_de_project/blob/main/setup.md)

![pipeline architecture](images/pipeline_architecture.jpg)


![dbt lineage](images/dbt-dag.png)

# Visualization

![dashboard](images/real_estate_sales_dashboard.png)
[Link to the Dashboard](https://lookerstudio.google.com/reporting/fadbe10e-9b4a-4007-8dd7-e407aa03e144)

