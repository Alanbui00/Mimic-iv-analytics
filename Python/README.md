# Python Healthcare Analysis

---

## Overview

This folder contains the Python notebooks used to perform exploratory data analysis and statistical testing on the healthcare data.

Python connects directly to the PostgreSQL analytical views. This ensures that the notebooks uses the same cleaned and transformed data as the Power BI dashboard.

--- 

## Technologies

The analysis uses:

* Python
* Pandas
* NumPy
* Matplotlib
* Seaborn
* SciPy
* SQLAlchemy
* Psycopg2

--- 

## Database Connection

The notebook connects to PostgreSQL using SQLAlchemy:
``` python
from sqlalchemy import create_engine
import pandas as pd

engine = create_engine(f'postgresql://{DB_USER}:{DB_PASSWORD}@localhost:5432/hospital')

view_name = "patient_analysis_view"

df = pd.read_sql(f"SELECT * FROM {view_name}", con=engine)
```

Database credentials should not be uploaded to GitHub. Environment variables or a local configuration file should be used to protect sensitive connection information.

--- 

## Analysis Workflow

The notebooks follow this process:
``` text
data_validation.ipynb
  Connect to PostgreSQL
          ↓
  Load Analytical Views
          ↓
  Inspect Data Quality

statistical_analysis.ipynb
  Perform Exploratory Analysis
          ↓
  Create Visualizations
          ↓
  Conduct Statistical Tests
          ↓
  Interpret Findings
```
---

## Exploratory Data Analysis

The exploratory analysis examines:

* Dataset dimensions
* Column data types
* Missing values
* Duplicate records
* Patient age distribution
* Length-of-stay distribution
* Admission type frequency
* Insurance distribution
* Gender distribution
* Mortality distribution
* Most common diagnoses
* Diagnosis-level length of stay

Example inspection code:

* df.info()
* df.describe()
* df.isna().sum()
* df.duplicated().sum()

---

## Statistical Tests

### Independent T-Test

An independent t-test compares the average length of stay between two patient groups.

Example research question:

Is average length of stay different between male and female patients?

### Analysis of Variance

ANOVA evaluates whether average length of stay differs across three or more groups.

Example research question:

Does average length of stay differ across admission types?

### Chi-Square Test

A chi-square test examines the association between two categorical variables.

Example research question:

Is admission type associated with in-hospital mortality?

A significance level of 0.05 is used when interpreting the test results.

---

### Visualizations

The notebook can include:

* Patient age histogram
* Length-of-stay histogram
* Admission type count chart
* Insurance distribution chart
* Length of stay by admission type
* Mortality by age group
* Mortality by admission type
* Most common diagnosis chart
* Length of stay by diagnosis

--- 

## Running the Notebook

Install the required packages:

pip install pandas numpy matplotlib seaborn scipy sqlalchemy psycopg2-binary

Ensure that:

PostgreSQL is running.
The healthcare database has been created.
The raw data has been imported.
The analytical SQL views have been created.
The database connection string has been updated.

Then open and run:

data_validation.ipynb
statistical_analysis.ipynb

---

## Limitations

The MIMIC-IV Demo dataset contains a small sample.
Statistical tests may have limited power because of small group sizes.
Results identify associations rather than causal relationships.
Highly skewed length-of-stay values may affect mean-based comparisons.
Findings should not be used for real clinical decisions.
