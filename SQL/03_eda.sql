 -- STEP 3: EXPLORATORY DATA ANALYSIS (EDA)

/* ---------------------------------------------------------
   3.1 OVERALL DATA SNAPSHOT
   --------------------------------------------------------- */

-- Total number of patient encounters
SELECT COUNT(*) AS total_encounters
FROM patient_readmissions;

-- Distribution of readmission status
SELECT
    readmitted,
    COUNT(*) AS patient_count,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS percentage
FROM patient_readmissions
GROUP BY readmitted
ORDER BY patient_count DESC;

/* ---------------------------------------------------------
   3.2 TARGET VARIABLE ANALYSIS (30-Day Readmission)
   --------------------------------------------------------- */

-- Overall 30-day readmission rate
SELECT
    ROUND(100 * AVG(target)::NUMERIC, 4) AS readmission_rate_30d
FROM patient_readmissions;

-- Readmitted vs non-readmitted counts
SELECT
    target,
    COUNT(*) AS total_patients
FROM patient_readmissions
GROUP BY target;


/* ---------------------------------------------------------
   3.3 AGE GROUP × READMISSION ANALYSIS
   --------------------------------------------------------- */

SELECT
    age_group,
    COUNT(*) AS total_patients,
    SUM(target) AS readmitted_patients,
    ROUND(100 * AVG(target)::NUMERIC, 4) AS readmission_rate
FROM patient_readmissions
GROUP BY age_group
ORDER BY readmission_rate DESC;


/* ---------------------------------------------------------
   3.4 GENDER × READMISSION ANALYSIS
   --------------------------------------------------------- */

SELECT
    gender,
    COUNT(*) AS total_patients,
    SUM(target) AS readmitted_patients,
    ROUND(100 * AVG(target)::NUMERIC, 4) AS readmission_rate
FROM patient_readmissions
GROUP BY gender
ORDER BY readmission_rate DESC;


/* ---------------------------------------------------------
   3.5 ADMISSION TYPE × READMISSION ANALYSIS
   --------------------------------------------------------- */

SELECT
    admission_type,
    COUNT(*) AS total_cases,
    SUM(target) AS readmitted_cases,
    ROUND(100 * AVG(target)::NUMERIC, 4) AS readmission_rate
FROM patient_readmissions
GROUP BY admission_type
ORDER BY readmission_rate DESC;


/* ---------------------------------------------------------
   3.6 DISCHARGE CATEGORY × READMISSION ANALYSIS
   --------------------------------------------------------- */

SELECT
    discharge_category,
    COUNT(*) AS total_cases,
    SUM(target) AS readmitted_cases,
    ROUND(100 * AVG(target)::NUMERIC, 4) AS readmission_rate
FROM patient_readmissions
GROUP BY discharge_category
ORDER BY readmission_rate DESC;

/* ---------------------------------------------------------
   3.7 LENGTH OF STAY × READMISSION
   --------------------------------------------------------- */

-- Bucket hospital stay duration
SELECT
    CASE
        WHEN time_in_hospital BETWEEN 1 AND 3 THEN '1–3 Days'
        WHEN time_in_hospital BETWEEN 4 AND 7 THEN '4–7 Days'
        WHEN time_in_hospital BETWEEN 8 AND 14 THEN '8–14 Days'
        ELSE '15+ Days'
    END AS length_of_stay_bucket,
    COUNT(*) AS total_patients,
    SUM(target) AS readmitted_patients,
    ROUND(AVG(target)::NUMERIC, 4) AS readmission_rate
FROM patient_readmissions
GROUP BY length_of_stay_bucket
ORDER BY readmission_rate DESC;


/* ---------------------------------------------------------
   3.8 MEDICATION COUNT × READMISSION
   --------------------------------------------------------- */

SELECT
    CASE
        WHEN num_medications <= 5 THEN '0–5'
        WHEN num_medications BETWEEN 6 AND 10 THEN '6–10'
        WHEN num_medications BETWEEN 11 AND 20 THEN '11–20'
        ELSE '21+'
    END AS medication_bucket,
    COUNT(*) AS total_patients,
    SUM(target) AS readmitted_patients,
    ROUND(AVG(target)::NUMERIC, 4) AS readmission_rate
FROM patient_readmissions
GROUP BY medication_bucket
ORDER BY readmission_rate DESC;


/* ---------------------------------------------------------
   3.9 PRIOR UTILIZATION × READMISSION
   --------------------------------------------------------- */

-- Prior inpatient visits
SELECT
    prior_inpatient,
    COUNT(*) AS total_patients,
    SUM(target) AS readmitted_patients,
    ROUND(AVG(target)::NUMERIC, 4) AS readmission_rate
FROM patient_readmissions
GROUP BY prior_inpatient
ORDER BY prior_inpatient DESC;

-- Prior emergency visits
SELECT
    prior_emergency,
    COUNT(*) AS total_patients,
    SUM(target) AS readmitted_patients,
    ROUND(AVG(target)::NUMERIC, 4) AS readmission_rate
FROM patient_readmissions
GROUP BY prior_emergency
ORDER BY prior_emergency DESC;


/* ---------------------------------------------------------
   3.10 DIAGNOSIS CATEGORY × READMISSION
   --------------------------------------------------------- */

SELECT
    diagnosis_category,
    COUNT(*) AS total_patients,
    SUM(target) AS readmitted_patients,
    ROUND(AVG(target)::NUMERIC, 4) AS readmission_rate
FROM patient_readmissions
GROUP BY diagnosis_category
ORDER BY readmission_rate DESC;









