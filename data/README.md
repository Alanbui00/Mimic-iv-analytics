# Healthcare Project Data

---

## Data Overview

This folder contains the raw data files used for the healthcare analytics project. The data comes from the MIMIC-IV Demo dataset, which provides deidentified patient and hospital information for educational and analytical purposes.

The project uses four primary files:

patients.csv\
admissions.csv\
diagnoses_icd.csv\
d_icd_diagnoses.csv

---

## Data Files

### patients.csv

Contains one row for each patient.

Important columns include:

| Column | Description |
|---|---|
| `subject_id` | Unique patient identifier |
| `gender` | Recorded patient gender |
| `anchor_age` | Patient age during the reference year |
| `anchor_year` | Reference year used for age calculation |
| `dod` | Recorded date of death, when available |

The primary key is subject_id.

### admissions.csv

Contains one row for each hospital admission.

Important columns include:

| Column | Description |
|---|---|
| `hamd_id` | Unique hospital admission identifier |
| `subject_id` | Patient identifier |
| `admittime` | Admission timestamp |
| `dischtime` | Discharge timestamp |
| `deathtime` | In-hospital death timestamp, when applicable |
| `admisstion_type` | Type of admission|
| `admission_location` | Location from which the patient was admitted |
| `discharge_location` | Patient discharge destination |
| `insurance` | Insurance category |
| `race` | Recorded race category |
| `hospital_expire_flage` | Indicates an in-hospital death |

The primary key is hadm_id. The subject_id column connects each admission to a patient.

### diagnoses_icd.csv

Contains diagnosis codes assigned during each hospital admission.

Important columns include:

| Column | Description |
|---|---|
| `subject_id` | Patient identifier |
| `ham_id` | Unique hospital admission identifier |
| `seq_num` | Diagnosis sequence number |
| `icd_code` | ICD diagnosis code |
| `icd_version` | ICD-9 or ICD-10 version |

A hospital admission can have multiple diagnoses. Therefore, the same hadm_id can appear in multiple rows.

### d_icd_diagnoses.csv

Contains readable descriptions for ICD diagnosis codes.

Important columns include:

| Column | Description |
|---|---|
| `icd_code` | ICD diagnosis code |
| `icd_version` | ICD-9 or ICD-10 version |
| `long_title` | Full diagnosis description |

This table is joined to diagnoses_icd.csv using both icd_code and icd_version.

## Data Relationships

Patients\
  |\
  | suject_id\
  v\
admissions\
  |\
  | hadm_id\
  v\
diagnoses_icd\
  |\
  | icd_code and icd_version\
  v\
d_icd_diagnoses

The relationships are:

One patient can have multiple admissions.
One admission can have multiple diagnoses.
One diagnosis definition can be assigned to multiple admissions.

## Data Considerations

The following issues were considered during data preparation:

* Missing patient or admission values
* Duplicate identifiers
* Diagnosis codes without matching descriptions
* Admissions without matching patient records
* Discharge timestamps occurring before admission timestamps
* Multiple diagnosis rows for the same admission
* Small category sizes
* Unknown or unavailable demographic values

Distinct patient and admission counts are used where necessary to prevent duplication caused by one-to-many relationships.

## Data Usage

The raw files are imported into PostgreSQL before being used in Python or Power BI. Cleaning, transformations, and calculated fields are handled in SQL to maintain consistent definitions throughout the project.

The raw data should not be manually modified. Any cleaning or transformation logic should be documented in the SQL scripts.

## Data Privacy

The MIMIC-IV Demo dataset contains deidentified information. It does not contain direct patient identifiers.

The dataset is used only for educational and portfolio purposes. Project findings should not be used for clinical decision-making.
