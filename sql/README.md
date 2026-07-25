# SQL Data Preparation and Analysis

---

## Overivew

This folder contains the PostgreSQL scripts used to create the healthcare database, validate the imported data, engineer analytical fields, create reusable views, and answer business questions.

SQL serves as the main data preparation layer for the project. Both Python and Power BI use data prepared through the SQL views.

---

## SQL Workflow

The SQL scripts should be run in the following order:

```text
01_create_tables.sql
        ↓
Import CSV Files
        ↓
02_clean_data.sql
        ↓
03_analysis.sql
        ↓
04_views.sql
```

---

## Files

### 01_create_tables.sql

Creates the PostgreSQL tables used to store the raw MIMIC-IV data:

* patients
* admissions
* diagnoses_icd
* d_icd_diagnoses

The script defines the column names and appropriate PostgreSQL data types.

### 02_clean_data.sql

Checks the imported data for quality issues, including:

Duplicate patient identifiers
Duplicate hospital admission identifiers
Missing values
Admissions without matching patients
Diagnosis records without matching admissions
Diagnosis codes without matching definitions
Invalid admission and discharge timestamps
Negative lengths of stay

Example validation query:

```sql
SELECT
    hadm_id,
    COUNT(*) AS record_count
FROM admissions
GROUP BY hadm_id
HAVING COUNT(*) > 1;
```

### 03_analysis.sql

Contains analytical queries that answer the project’s business questions.

The analyses include:

* Total patients and admissions
* Admissions by admission type
* Average length of stay by admission type
* Mortality by age group
* Mortality by admission type
* Admissions by insurance
* Most common diagnoses
* Length of stay by diagnosis
* Mortality by diagnosis
* Primary diagnosis analysis

### 04_views.sql

Creates reusable analytical views that combine and transform the raw tables.

#### Patient Summary View

The patient summary view contains one row per hospital admission.

It includes:

Patient identifiers
Demographic information
Admission information
Insurance category
Admission type
Length of stay
In-hospital mortality indicator

This view connects diagnosis codes to readable diagnosis titles.

The join uses both ICD fields:

ON di.icd_code = dd.icd_code
AND di.icd_version = dd.icd_version
Diagnosis Outcomes View

This view connects diagnosis information to admission-level outcomes, including:

Length of stay
Mortality
Patient age
Gender
Insurance
Admission type

The view is the main view used for analysis in Power BI and Python.

---

### Important SQL Concepts

The project demonstrates:

* Inner and left joins
* Aggregate functions
* GROUP BY
* HAVING
* CASE expressions
* Common table expressions
* SQL views
* Date and timestamp calculations
* Distinct counts
* Window functions
* Data-quality validation
* One-to-many relationship management

---

### Running the SQL Scripts

Create the database:

CREATE DATABASE healthcare;

Connect to the database and run the table creation script. Import the CSV files into the corresponding tables, and then run the remaining scripts in order.

The SQL views must be created before refreshing the Python notebook or Power BI dashboard.
