# Power BI Dashboards

This folder contains the interactive Power BI dashboard used to visualize key hospital performance metrics from the MIMIC-IV Demo dataset. The dashboard was designed to help healthcare administrators monitor patient demographics, hospital operations, clinical outcomes, and diagnosis trends through interactive reports.

---

## Dashboard Objectives

The dashboard focuses on four key areas:

- Provide an executive overview of hospital performance.
- Monitor operational efficiency through admissions and length of stay.
- Identify patient groups with higher mortality risk.
- Analyze the most common diagnoses and their impact on hospital resources.

---

## Dashboard Pages

### 1. Executive Overview

Provides a high-level summary of hospital activity and patient demographics.

**KPIs**

- Total Patients
- Total Admissions
- Average Patient Age
- Average Length of Stay (LOS)
- Overall Mortality Rate

**Visualizations**

- Monthly Admissions Trend
- Gender Distribution
- Insurance Distribution
- Patients and Average LOS by Age Group

**Business Insights**

- Patients averaged approximately **2.75 admissions**, indicating repeat hospital utilization.
- Most patients were between **50–64** and **65+**, representing an older patient population.
- Monthly admissions remained relatively stable throughout the year with a slight increase during September.
- Average LOS remained close to **7 days**, providing a baseline operational benchmark.

---

### 2. Hospital Operations Overview

Analyzes hospital utilization and operational performance.

**KPIs**

- Total Admissions
- Average LOS
- Median LOS
- Mortality Rate

**Visualizations**

- Admissions by Admission Type
- Average LOS & Mortality by Age Group
- Average LOS by Insurance

**Business Insights**

- Emergency admissions accounted for the largest share of hospital volume.
- Patients aged **65+** experienced the highest mortality rate despite similar LOS compared to younger age groups.
- Patients covered under the "Other" insurance category had the longest average hospital stay.
- Average and median LOS were nearly identical, suggesting hospitalization lengths were not heavily influenced by a small number of extreme outliers.

---

### 3. Mortality & Patient Outcomes

Evaluates patient outcomes across demographic and operational categories.

**KPIs**

- Total Deaths
- Average Age at Death
- Highest Mortality Admission Type
- Overall Mortality Rate

**Visualizations**

- Mortality Rate by Age Group
- Mortality Rate by Admission Type
- Mortality Rate by Gender
- Mortality Rate by Insurance

**Business Insights**

- Patients aged **65+** had the highest mortality rate (approximately **8.7%**).
- Urgent admissions experienced the highest mortality among admission categories.
- Male patients experienced substantially higher mortality than female patients.
- Medicaid and Medicare patient groups showed higher mortality rates than the "Other" insurance category.

---

### 4. Clinical & Diagnosis Analysis

Examines diagnosis frequency and resource utilization.

**KPIs**

- Total Diagnosis Records
- Unique Diagnoses
- Average LOS

**Visualizations**

- Top 10 Primary Diagnoses
- Top 10 Diagnoses by Average LOS
- Diagnosis Summary Table

**Business Insights**

- Acute kidney failure was among the most frequently recorded primary diagnoses.
- Several diagnoses required significantly longer hospital stays than the overall average.
- Patients averaged approximately **16 diagnosis records per admission**, demonstrating high clinical complexity.
- The diagnosis summary allows clinicians to compare admission volume, mortality, and LOS across conditions.

---

## Interactive Features

The dashboard includes interactive slicers allowing users to filter results by:

- Admission Type
- Insurance
- Gender
- Age Group
- Month (Operations Page)

All visualizations update dynamically based on selected filters.

---

## Business Value

This dashboard enables hospital leadership to:

- Monitor patient volume and hospital utilization.
- Evaluate operational efficiency through admission and LOS metrics.
- Identify high-risk patient populations requiring additional attention.
- Monitor mortality trends across demographic and clinical groups.
- Prioritize diagnoses that consume the greatest hospital resources.
- Support evidence-based operational and clinical decision-making.

---

## Tools Used

- Power BI Desktop
- DAX Measures
- Star Schema Data Model
- PostgreSQL Views
- MIMIC-IV Demo Dataset
