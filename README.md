<div align="center">
 
![SQL](https://img.shields.io/badge/SQL-PostgreSQL-336791?style=for-the-badge&logo=postgresql&logoColor=white)
![Python](https://img.shields.io/badge/Python-Analysis-3776AB?style=for-the-badge&logo=python&logoColor=white)
![Power BI](https://img.shields.io/badge/Power_BI-Dashboard-F2C811?style=for-the-badge&logo=powerbi&logoColor=black)
![Status](https://img.shields.io/badge/Status-Working-success?style=for-the-badge)
 
</div>
 
---

# Healthcare Analytics Project

---

## Project Overview

This project analyzes deidentified patient, hospital admission, and diagnosis data from the MIMIC-IV Demo dataset. The goal is to evaluate hospital operations, patient demographics, length of stay, diagnosis patterns, and in-hospital mortality.

The project follows an end-to-end analytics workflow:

MIMIC-IV CSV Files\
        ↓\
PostgreSQL Data Preparation\
        ↓\
Python Analysis\
        ↓\
Power BI Dashboard\
        ↓\
Healthcare Insights

PostgreSQL was used to store, validate, join, and transform the data into analytical views. Python was used for exploratory data analysis, visualization, and statistical testing. Power BI was used to create an interactive dashboard for communicating hospital performance and patient outcome metrics.

---

## Business Questions

The project examines the following questions:

* How many patients and hospital admissions are represented?
* What is the average hospital length of stay?
* Which admission types have the highest patient volume?
* Which patient groups experience longer hospital stays?
* What are the most common diagnoses?
* Which diagnoses are associated with longer stays or higher mortality?
* How does mortality vary across age groups, admission types, and insurance categories?
* Are differences in length of stay statistically significant?

---

## Tools
PostgreSQL: Data storage, validation, joins, transformations, views, and business queries\
Python: Exploratory analysis, visualization, and statistical testing\
Power BI: Data modeling, DAX measures, KPI reporting, and interactive dashboards\
MIMIC-IV Demo: Deidentified patient, admission, and diagnosis data\

---

## Key Metrics

The MIMIC-IV Demo data used in this project contains approximately:

* 100 unique patients
* 275 hospital admissions
* An average patient age of approximately 62 years
* An in-hospital mortality rate of approximately 5.5%

Because the project uses a small demonstration dataset, the findings are intended to demonstrate analytical methods and should not be generalized to a larger patient population.


---

## Skills Demonstrated

Relational data modeling\
SQL joins, aggregations, views, and window functions\
Data validation and feature engineering\
Python exploratory data analysis\
Statistical hypothesis testing\
Power BI data modeling and DAX\
Healthcare KPI development\
Dashboard design and data storytelling\
