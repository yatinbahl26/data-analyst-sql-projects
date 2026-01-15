-- 🎯 BUSINESS + INTERVIEW QUESTION #1 (LOCKED)

-- 👉 Find all Data Analyst–related roles that:
-- Are located in Delhi / Gurugram / Noida / NCR
-- -- Require 0–1 year experience
-- -- Offer at least 6 LPA maximum salary

WITH filtered_jobs AS (
    SELECT
        company_name,
        role_title,
        location,
        min_salary_lpa,
        max_salary_lpa,
        work_mode
    FROM job_postings
    WHERE location IN ('Delhi NCR', 'Gurugram', 'Noida', 'Remote')
      AND experience_required <= 1.0
      AND max_salary_lpa >= 6.0
)
SELECT *
FROM filtered_jobs;


-- 👉 Show the number of eligible Data Analyst roles per company
-- that satisfy:

-- Location: Delhi / Gurugram / Noida / NCR / Remote
-- Experience required: ≤ 1 year
-- Max salary: ≥ 6 LPA
-- Expected output columns:
-- company_name | total_roles


WITH company_roles AS (
    SELECT company_name , COUNT(role_title) AS total_roles FROM job_postings
    WHERE location IN ('Delhi NCR', 'Gurugram', 'Noida')
    AND experience_required <= 1.0
    AND max_salary_lpa >= 6.0
    GROUP BY company_name
)
SELECT * FROM company_roles;



WITH eligible_roles AS (
    SELECT
        job_id,
        role_title,
        CASE
            WHEN location IN ('Gurgaon', 'Gurugram') THEN 'Gurugram'
            WHEN location IN ('Delhi', 'Delhi NCR', 'NCR') THEN 'Delhi NCR'
            WHEN location  = 'Noida' THEN 'Noida'
            WHEN location  IN ('Remote', 'WFH') THEN 'Remote'
            ELSE 'Other'
        END AS standardized_location
    FROM job_postings
    WHERE experience_required <= 1
)
SELECT standardized_location, COUNT(*)
FROM eligible_roles
GROUP BY standardized_location;


-- Which locations have the highest number of companies hiring entry-level Data Analyst roles?
-- 📌 Requirements (Strict)
-- You must:
-- Use at least one CTE
-- Filter:
-- Experience ≤ 1 year
-- Data Analyst roles
-- Standardize locations (CASE WHEN)
-- Use COUNT(DISTINCT company_name)
-- GROUP BY standardized_location
-- Order results by company count (descending)


WITH eligible_location AS (
	SELECT 
    company_name,
	CASE
		WHEN location IN ('Gurugram', 'Gurgaon') THEN 'Gurugram'
        WHEN location IN ('Delhi NCR', 'NCR', 'Delhi') THEN 'Delhi'
        WHEN location = 'Noida' THEN 'Noida'
        WHEN location IN ('Remote' ,'WFH') THEN 'Remote'
        ELSE 'Other'
	END AS standardize_location
    FROM job_postings
	WHERE experience_required <=1.0
    AND role_title LIKE '%data analyst%'
)
SELECT standardize_location, 
	   COUNT(DISTINCT company_name) AS no_of_companies 
FROM eligible_location
GROUP BY standardize_location
ORDER BY no_of_companies DESC;




-- CTE prepares clean data; main query aggregates.
-- -- Here we are :
-- Data cleaning (location standardization)
-- Aggregation (COUNT DISTINCT)

-- WITH eligible_location AS (
-- 	SELECT 
-- 	CASE
-- 		WHEN location IN ('Gurugram', 'Gurgaon') THEN 'Gurugram'
--         WHEN location IN ('Delhi NCR', 'NCR', 'Delhi') THEN 'Delhi'
--         WHEN location = 'Noida' THEN 'Noida'
--         WHEN location IN ('Remote' ,'WFH') THEN 'Remote'
--         ELSE 'Other'
-- 	END AS standardize_locations,
-- 	COUNT(DISTINCT company_name) AS no_of_companies
--     FROM job_postings
-- 	WHERE experience_required <=1.0
--     AND role_title LIKE '%data analyst%'
--     GROUP BY standardize_locations
-- )
-- SELECT * FROM eligible_location
-- ORDER BY no_of_companies DESC




