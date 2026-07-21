    -- Views for Analysis
CREATE VIEW patient_summary_view AS
SELECT
    p.subject_id,
    a.hadm_id,
    p.gender,
    p.anchor_age,
    CASE
        WHEN p.anchor_age <18 THEN '0-17'
        WHEN p.anchor_age <35 THEN '18-34'
        WHEN p.anchor_age <50 THEN '35-49'
        WHEN p.anchor_age <65 THEN '50-64'
        ELSE '65+'
    END AS age_group,
    a.admittime,
    a.dischtime,
    ROUND(
        EXTRACT(EPOCH FROM
        (a.dischtime-a.admittime))/86400,
        2
    ) AS length_of_stay,
    CASE
        WHEN EXTRACT(EPOCH FROM
        (a.dischtime-a.admittime))/86400 >=7
        THEN 'Long Stay'
        ELSE 'Short Stay'
    END AS stay_type,
    a.admission_type,
    a.admission_location,
    a.discharge_location,
    a.insurance,
    a.hospital_expire_flag
FROM patients p
JOIN admissions a
ON p.subject_id=a.subject_id;

    -- view for diagnosis summary
CREATE VIEW vw_diagnosis_summary AS
SELECT
    a.subject_id,
    a.hadm_id,
    d.icd_code,
    d.icd_version,
    dx.long_title
FROM admissions a
JOIN diagnoses_icd d
ON a.hadm_id=d.hadm_id
JOIN d_icd_diagnoses dx
ON d.icd_code=dx.icd_code
AND d.icd_version=dx.icd_version;

    -- view for patient diagnosis summary
CREATE VIEW vw_patient_diagnosis AS
SELECT
    p.subject_id,
    a.hadm_id,
    p.gender,
    p.anchor_age,
    a.admission_type,
    a.insurance,
    ROUND(
    EXTRACT(EPOCH FROM
    (a.dischtime-a.admittime))/86400,
    2) AS length_of_stay,
    a.hospital_expire_flag,
    dx.long_title
FROM patients p
JOIN admissions a
ON p.subject_id=a.subject_id
JOIN diagnoses_icd d
ON a.hadm_id=d.hadm_id
JOIN d_icd_diagnoses dx
ON d.icd_code=dx.icd_code
AND d.icd_version=dx.icd_version;

    -- view for admission summary
CREATE VIEW vw_monthly_admissions AS
SELECT
    DATE_TRUNC('month',admittime) AS month,
    COUNT(*) admissions
    FROM admissions
    GROUP BY month;

    -- view for insurance summary
CREATE VIEW vw_insurance_summary AS
SELECT
    insurance,
    COUNT(*) patients,
    ROUND(AVG(EXTRACT(EPOCH FROM
    (dischtime-admittime))/86400
    ),2) avg_los,
    ROUND(
    100*AVG(hospital_expire_flag),2) mortality
FROM admissions
GROUP BY insurance;

    -- view for age summary
CREATE VIEW vw_age_summary AS
SELECT
    CASE
    WHEN anchor_age<18 THEN '0-17'
    WHEN anchor_age<35 THEN '18-34'
    WHEN anchor_age<50 THEN '35-49'
    WHEN anchor_age<65 THEN '50-64'
    ELSE '65+'
    END age_group,
    COUNT(*) patients,
    ROUND(
    AVG(EXTRACT(EPOCH FROM(dischtime-admittime))/86400
    ),2) avg_los,
    ROUND(100*AVG(hospital_expire_flag),
    2) mortality_rate
FROM patients p
JOIN admissions a
ON p.subject_id=a.subject_id
GROUP BY age_group;

-- view for dashboard KPIs
CREATE VIEW vw_dashboard_kpis AS
SELECT
    COUNT(DISTINCT p.subject_id) total_patients,
    COUNT(a.hadm_id) total_admissions,
    ROUND(AVG(EXTRACT(EPOCH FROM(dischtime-a.admittime))/86400
    ),2) avg_los,
    ROUND(100*AVG(a.hospital_expire_flag),
    2) mortality_rate,
    ROUND(AVG(anchor_age),
    2) avg_age
FROM patients p
JOIN admissions a
ON p.subject_id=a.subject_id;

    -- view for patient analysis
CREATE VIEW patient_analysis_view AS

WITH diagnosis_summary AS (
SELECT
    di.hadm_id,
    COUNT(*) AS diagnosis_count,
    MIN(dd.long_title) AS primary_diagnosis
FROM diagnoses_icd di
JOIN d_icd_diagnoses dd
    ON di.icd_code = dd.icd_code
    AND di.icd_version = dd.icd_version
GROUP BY di.hadm_id
)

SELECT
    p.subject_id,
    a.hadm_id,
    p.gender,
    p.anchor_age,
    a.admission_type,
    a.admission_location,
    a.discharge_location,
    a.insurance,
    a.marital_status,
    a.admittime,
    a.dischtime,
    ROUND(
        EXTRACT(EPOCH FROM (a.dischtime - a.admittime))/ 86400,
        2) AS length_of_stay,
    a.hospital_expire_flag,
    COALESCE(ds.diagnosis_count,0) AS diagnosis_count,
    ds.primary_diagnosis
FROM admissions a
JOIN patients p
ON a.subject_id = p.subject_id
LEFT JOIN diagnosis_summary ds
ON a.hadm_id = ds.hadm_id;
