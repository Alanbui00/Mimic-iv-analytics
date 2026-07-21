-- Create table for patient data
CREATE TABLE patients (
    subject_id BIGINT PRIMARY KEY,
    gender VARCHAR(1),
    anchor_age INT,
    anchor_year INT,
    anchor_year_group VARCHAR(20),
    dod DATE
);

-- Create table for admissions data
CREATE TABLE admissions (
    subject_id BIGINT,
    hadm_id BIGINT PRIMARY KEY,
    admittime TIMESTAMP,
    dischtime TIMESTAMP,
    deathtime TIMESTAMP,
    admission_type VARCHAR(50),
    admit_provider_id VARCHAR(50),
    admission_location VARCHAR(100),
    discharge_location VARCHAR(100),
    insurance VARCHAR(100),
    language VARCHAR(50),
    marital_status VARCHAR(50),
    race VARCHAR(100),
    edregtime TIMESTAMP,
    edouttime TIMESTAMP,
    hospital_expire_flag INT
);

-- Create table for dianoses icd
CREATE TABLE diagnoses_icd (
    subject_id BIGINT,
    hadm_id BIGINT,
    seq_num INT,
    icd_code VARCHAR(10),
    icd_version INT
);

-- Create table for diagnoses d icd
CREATE TABLE d_icd_diagnoses (
    icd_code VARCHAR(10),
    icd_version INT,
    long_title TEXT
);