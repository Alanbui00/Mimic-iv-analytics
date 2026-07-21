-- Data Quality Assessment
SELECT COUNT(*) FROM admissions
SELECT COUNT(*) FROM patients;
SELECT COUNT(*) FROM diagnoses_icd;
SELECT COUNT(*) FROM d_icd_diagnoses;


-- Check Primary Keys (More than 1 record with same primary key)
SELECT
subject_id,
COUNT(*)
FROM patients
GROUP BY subject_id
HAVING COUNT(*) > 1;

SELECT
hadm_id,
COUNT(*)
FROM admissions
GROUP BY hadm_id
HAVING COUNT(*)>1;

SELECT
hadm_id,
icd_code,
COUNT(*)
FROM diagnoses_icd
GROUP BY hadm_id, icd_code
HAVING COUNT(*)>1;

-- Missing Values
SELECT
    COUNT(*) AS total,
    COUNT(subject_id) AS subject,
    COUNT(gender) AS gender,
    COUNT(anchor_age) AS age
FROM patients;

SELECT
    COUNT(*) total,
    COUNT(admittime),
    COUNT(dischtime),
    COUNT(admission_type),
    COUNT(discharge_location),
    COUNT(hospital_expire_flag)
FROM admissions;

-- Find NULL Records
SELECT *
FROM admissions
WHERE dischtime IS NULL;

-- Check Empty Strings
SELECT *
FROM admissions
WHERE TRIM(admission_location)='';

SELECT *
FROM admissions
WHERE TRIM(discharge_location)='';

-- Check Invalid Ages
SELECT *
FROM patients
WHERE anchor_age<0
OR anchor_age>100;

-- Check Gender
SELECT
    gender,
    COUNT(*)
FROM patients
GROUP BY gender;

-- Hospital stay validation
SELECT
    hadm_id,
    admittime,
    dischtime,
    EXTRACT(DAY FROM dischtime-admittime) AS los
FROM admissions
ORDER BY los DESC;

SELECT *
FROM admissions
WHERE dischtime<admittime;

-- Duplicated Admissions
SELECT
    subject_id,
    admittime,
COUNT(*)
FROM admissions
GROUP BY
    subject_id,
    admittime
HAVING COUNT(*)>1;

-- Duplicated Diagnoses
SELECT
    hadm_id,
    icd_code,
    icd_version,
    COUNT(*)
FROM diagnoses_icd
GROUP BY
    hadm_id,
    icd_code,
    icd_version
HAVING COUNT(*)>1;

