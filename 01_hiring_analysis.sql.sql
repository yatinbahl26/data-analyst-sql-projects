-- 🎯 BUSINESS + INTERVIEW QUESTION #1 (LOCKED)

-- 👉 Find all Data Analyst–related roles that:
-- Are located in Delhi / Gurugram / Noida / NCR
-- -- Require 0–1 year experience
-- -- Offer at least 6 LPA maximum salary

-- WITH filtered_jobs AS (
--     SELECT
--         company_name,
--         role_title,
--         location,
--         min_salary_lpa,
--         max_salary_lpa,
--         work_mode
--     FROM job_postings
--     WHERE location IN ('Delhi NCR', 'Gurugram', 'Noida', 'Remote')
--       AND experience_required <= 1.0
--       AND max_salary_lpa >= 6.0
-- )
-- SELECT *
-- FROM filtered_jobs;

-- -------------------------------------------------------------------------------------------------------------------------------------------
-- -------------------------------------------------------------------------------------------------------------------------------------------

-- 👉 Show the number of eligible Data Analyst roles per company
-- that satisfy:

-- Location: Delhi / Gurugram / Noida / NCR / Remote
-- Experience required: ≤ 1 year
-- Max salary: ≥ 6 LPA
-- Expected output columns:
-- company_name | total_roles


-- WITH company_roles AS (
--     SELECT company_name , COUNT(role_title) AS total_roles FROM job_postings
--     WHERE location IN ('Delhi NCR', 'Gurugram', 'Noida')
--     AND experience_required <= 1.0
--     AND max_salary_lpa >= 6.0
--     GROUP BY company_name
-- )
-- SELECT * FROM company_roles;

-- -------------------------------------------------------------------------------------------------------------------------------------------
-- -------------------------------------------------------------------------------------------------------------------------------------------

-- WITH eligible_roles AS (
--     SELECT
--         job_id,
--         role_title,
--         CASE
--             WHEN location IN ('Gurgaon', 'Gurugram') THEN 'Gurugram'
--             WHEN location IN ('Delhi', 'Delhi NCR', 'NCR') THEN 'Delhi NCR'
--             WHEN location  = 'Noida' THEN 'Noida'
--             WHEN location  IN ('Remote', 'WFH') THEN 'Remote'
--             ELSE 'Other'
--         END AS standardized_location
--     FROM job_postings
--     WHERE experience_required <= 1
-- )
-- SELECT standardized_location, COUNT(*)
-- FROM eligible_roles
-- GROUP BY standardized_location;

-- -------------------------------------------------------------------------------------------------------------------------------------------
-- -------------------------------------------------------------------------------------------------------------------------------------------

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


-- WITH eligible_location AS (
-- 	SELECT 
--     company_name,
-- 	CASE
-- 		WHEN location IN ('Gurugram', 'Gurgaon') THEN 'Gurugram'
--         WHEN location IN ('Delhi NCR', 'NCR', 'Delhi') THEN 'Delhi'
--         WHEN location = 'Noida' THEN 'Noida'
--         WHEN location IN ('Remote' ,'WFH') THEN 'Remote'
--         ELSE 'Other'
-- 	END AS standardize_location
--     FROM job_postings
-- 	WHERE experience_required <=1.0
--     AND role_title LIKE '%data analyst%'
-- )
-- SELECT standardize_location, 
-- 	   COUNT(DISTINCT company_name) AS no_of_companies 
-- FROM eligible_location
-- GROUP BY standardize_location
-- ORDER BY no_of_companies DESC;

-- -------------------------------------------------------------------------------------------------------------------------------------------
-- -------------------------------------------------------------------------------------------------------------------------------------------

-- For entry-level Data Analyst roles, how does salary differ by location (Delhi NCR, Gurugram, Noida, Remote)?
-- A follow-up you should eventually be able to answer:
-- 1. Is higher demand also higher pay?
-- 2. Or is there a trade-off?

-- Filter:
-- experience_required <= 1
-- role_title contains Data Analyst
-- Standardize location using CASE WHEN
-- Select:
-- standardized location
-- salary column(s)

WITH eligible_roles AS (
	SELECT min_salary_lpa,
    COUNT(*) AS no_of_roles,
    CASE
		WHEN location IN ('Gurugram', 'Gurgaon') THEN 'Gurugram'
        WHEN location IN ('NCR', 'Delhi NCR', 'Delhi') THEN 'Delhi NCR'
        WHEN location = 'Noida' THEN 'Noida'
        WHEN location IN ('Remote', 'WFH') THEN 'Remote'
		ELSE 'Other'
	END AS standardized_location
    FROM job_postings
    WHERE experience_required <=1.0
    AND role_title LIKE '%data analyst%'
)
SELECT standardized_location,
AVG(min_salary_lpa) AS avg_min_salary_lpa,
COUNT(*) as total_roles
FROM eligible_roles
GROUP BY standardized_location
ORDER BY avg_min_salary_lpa DESC


