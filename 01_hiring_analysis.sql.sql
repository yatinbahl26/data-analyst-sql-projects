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
