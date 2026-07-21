-- ============================================================================
-- PATIENT DEMOGRAPHICS QUESTIONS
-- ============================================================================
/*  Patient Demographics

    1.Total patients
    2. Average age
    3. Gender distribution
    4. Race distribution
*/

-- Key Indicators

    -- Check total number of patients
SELECT COUNT(*) AS total_patients
FROM patients;

    -- Insights: There is 100 patients in the dataset 
---------------------------------------------------------------------

    -- Check total number of admissions
SELECT COUNT(*) AS total_admissions
FROM admissions;

    -- Total of 275 admissions
---------------------------------------------------------------------
    -- Average Patient Age
SELECT ROUND(AVG(anchor_age),2) AS average_age
FROM patients;

    -- Insights: Average age is 62 years old
---------------------------------------------------------------------
    -- Age by gender
SELECT
    gender,
    ROUND(AVG(anchor_age),2) AS avg_age
FROM patients
GROUP BY gender;
    -- Men are on average 2 years older than women
---------------------------------------------------------------------
    -- Mortality Rate
SELECT
    ROUND(
        100.0 * SUM(hospital_expire_flag) / COUNT(*),
        2
    ) AS mortality_rate
FROM admissions;

    -- Insights: morality rate is 5.5%
---------------------------------------------------------------------
    -- Gender Distribution
SELECT
    gender,
    COUNT(*) AS patients
FROM patients
GROUP BY gender
ORDER BY patients DESC;

    -- Insights: There are more men than women patients in the dataset
---------------------------------------------------------------------
    -- Age group Distribution 
SELECT
CASE
    WHEN anchor_age <18 THEN '0-17'
    WHEN anchor_age <35 THEN '18-34'
    WHEN anchor_age <50 THEN '35-49'
    WHEN anchor_age <65 THEN '50-64'
    ELSE '65+'
END AS age_group,
COUNT(*) AS patients
FROM patients
GROUP BY age_group
ORDER BY age_group;
    
    -- Insights: Most patients are in the 65+ age group, followed by 50-64 and 35-49 age groups

---------------------------------------------------------------------
-- Hosiptal Operations

    -- Admissions by Type
SELECT
    admission_type,
    COUNT(*) AS admissions
FROM admissions
GROUP BY admission_type
ORDER BY admissions DESC;

    -- Insights: Most admissions are EMERGENCY, followed by URGENT and ELECTIVE
---------------------------------------------------------------------
    -- Insurance
SELECT
    insurance,
    COUNT(*) AS patients
FROM admissions
GROUP BY insurance
ORDER BY patients DESC;

    -- Insights: Most patients are covered by Another Insurance while then Medicare and followed by Medicaid last. 
---------------------------------------------------------------------
    -- Length of stay
SELECT
    AVG(dischtime-admittime) AS avg_days
FROM admissions;

    -- Insights: Average length of stay is 6 days
---------------------------------------------------------------------
    -- Longest hospital stay
SELECT
    hadm_id,
    subject_id,
    ROUND(
    EXTRACT(EPOCH FROM (dischtime-admittime))/86400,
    2) AS length_of_stay
FROM admissions
ORDER BY length_of_stay DESC
LIMIT 10;

    -- Insights: The longest hospital stay is 45 days, followed by 33 days and 32 days
---------------------------------------------------------------------
    -- Admissions by Day of Week
SELECT
    TO_CHAR(admittime,'Day') AS weekday,
    COUNT(*) AS admissions
FROM admissions
GROUP BY weekday
ORDER BY admissions DESC;

    -- Insights: Most admissions occur on weekdays, with the highest on Thursday, followed by Tuesday and Monday.
---------------------------------------------------------------------
    -- Average Length of Stay by Admission Type
SELECT
    admission_type,
    ROUND(
        AVG(EXTRACT(EPOCH FROM (dischtime-admittime))/86400),
        2) AS avg_los
FROM admissions
GROUP BY admission_type
ORDER BY avg_los DESC;

    -- Insights: Average length of stay is highest for Urgent admissions, followed by Direct Emergency and Elective admissions.
---------------------------------------------------------------------
    -- Length of Stay Distribution
SELECT
CASE
    WHEN dischtime-admittime < INTERVAL '3 days' THEN '0-3'
    WHEN dischtime-admittime < INTERVAL '7 days' THEN '4-7'
    WHEN dischtime-admittime < INTERVAL '14 days' THEN '8-14'
    ELSE '15+' END AS los_group,
COUNT(*)
FROM admissions
GROUP BY los_group;

    -- Insights: Most patients have a length of stay of 4-7 days, followed by 0-3 days and 15+.
---------------------------------------------------------------------
-- Clinical Analysis

    -- Top 10 Diagnoses
SELECT
    d.long_title,
    COUNT(*) AS total
FROM diagnoses_icd di
JOIN d_icd_diagnoses d
ON di.icd_code=d.icd_code
AND di.icd_version=d.icd_version
GROUP BY d.long_title
ORDER BY total DESC
LIMIT 10;

    -- Insights: The top diagnosis is 'Unspecified hypertension', followed by 'Hyerlipidemia' and 'Acute kidney failure, unspecified'.
---------------------------------------------------------------------
-- Mortality

    -- Mortality by Admission Type
SELECT
    admission_type,
    ROUND(
    100.0*AVG(hospital_expire_flag),
    2) AS mortality_rate
FROM admissions
GROUP BY admission_type
ORDER BY mortality_rate DESC;

    --- Insights: Mortality rate is highest for Urgent, followed by Observation Admit and Direct Emergency.
---------------------------------------------------------------------

    -- Mortality by Insurance
SELECT
    insurance,
    ROUND(
    100.0*AVG(hospital_expire_flag),2)  AS mortality_rate
FROM admissions
GROUP BY insurance
ORDER BY mortality_rate DESC;

    -- Insights: Mortality rate is highest for Medicaid, followed by Medicare and then Other Insurance.
---------------------------------------------------------------------
    -- Length of Stay and count by Diagnosis
SELECT
    dx.long_title,
    ROUND(
    AVG(EXTRACT(EPOCH FROM(dischtime-admittime))/86400),
    2) avg_los,
    COUNT(*)
FROM admissions a
JOIN diagnoses_icd d
ON a.hadm_id=d.hadm_id
JOIN d_icd_diagnoses dx
ON d.icd_code=dx.icd_code
AND d.icd_version=dx.icd_version
GROUP BY dx.long_title
HAVING COUNT(*)>=3
ORDER BY avg_los DESC
LIMIT 10;

    -- Insights: The diagnosis with the longest average length of stay is 'Fever presenting wwth conditions classified elsewhere', followed by 'Hyperosmolality and hypernatremia' and 'Compression of vein'.
---------------------------------------------------------------------
    -- Count of Diagnoses by Gender
SELECT
    p.gender,
    dx.long_title,
COUNT(*)
FROM patients p
JOIN admissions a
ON p.subject_id=a.subject_id
JOIN diagnoses_icd d
ON a.hadm_id=d.hadm_id
JOIN d_icd_diagnoses dx
ON d.icd_code=dx.icd_code
AND d.icd_version=dx.icd_version
GROUP BY p.gender,dx.long_title;
