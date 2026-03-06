# SQL-Data-Cleaning
SQL data cleaning project on a layoffs dataset

This project demonstrates data cleaning techniques using SQL on a layoffs dataset.

## Dataset
The dataset contains information about layoffs across different companies including:
- Company
- Location
- Industry
- Total laid off
- Percentage laid off
- Date
- funds_raised_millions

## Cleaning Steps
- Created staging tables to preserve original data
- Removed duplicate records using ROW_NUMBER()
- Standardized text fields (company, industry, country)
- Converted date column to proper DATE format
- Handled NULL and blank values and populated the missing values. 
- Removed rows with missing layoff data

## SQL Skills Used
- CTEs
- Window Functions
- Data Standardization
- NULL Handling
- Data Transformation

## Project Purpose
The goal of this project is to demonstrate SQL data cleaning skills that are commonly used in data analyst workflows.

## Acknowledgement
This project was done with the help of the SQL course from Alex The Analyst. I followed the workflow to practice data cleaning techniques such as removing duplicates, handling NULL values, and standardizing dates.
