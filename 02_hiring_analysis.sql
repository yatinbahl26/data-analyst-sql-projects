-- 🧩 Day 5 Tasks (Systematic)
-- How does demand differ between 0-year and 1-year experience Data Analyst roles?
-- 🔹 Task 1 — Build CTE: Eligible Entry-Level Roles
-- Your CTE must:
-- Filter:
-- experience_required IN (0, 1)
-- role_title contains Data Analyst
-- Select:
-- experience_required
-- one row = one job posting
-- ⚠️ No aggregation here.
-- 🔹 Task 2 — Normalize Experience Buckets
-- Inside the CTE (or via CASE WHEN):
-- Create a column:
-- experience_bucket
-- Mapping:
-- 0 → 'Fresher (0 yrs)'
-- 1 → 'Junior (1 yr)'
-- This improves readability and interview clarity.

-- 🔹 Task 3 — Aggregate Demand by Experience
-- In the main query:
-- GROUP BY experience_bucket
-- COUNT(*) AS total_roles
-- This gives pure demand comparison.

-- 🔹 Task 4 — Order for Insight
-- Order by:
-- total_roles DESC
-- Simple and clear.

WITH eligible_roles AS (
	SELECT
    CASE 
			WHEN experience_required = 0 THEN 'Fresher (0 yr)'
            WHEN experience_required = 1 THEN 'Junior (1 yr)'
		END AS experience_bucket
    FROM job_postings
    WHERE experience_required IN (0,1)
    AND LOWER(role_title) LIKE LOWER('%data analyst%')
)
SELECT 
	   experience_bucket,
	   COUNT(*) AS no_of_roles 
FROM eligible_roles
GROUP BY experience_bucket
ORDER BY no_of_roles DESC



