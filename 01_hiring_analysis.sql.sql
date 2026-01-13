-- 🎯 BUSINESS + INTERVIEW QUESTION #1 (LOCKED)
-- 👉 Find all Data Analyst–related roles that:

-- Are located in Delhi / Gurugram / Noida / NCR

SELECT * FROM job_postings;

-- WITH loc AS (
-- 	SELECT role_title FROM job_postings
--     WHERE location = 'Noida'
-- )
-- SELECT * FROM loc
-- -- WHERE location = 'Noida'


-- Require 0–1 year experience

-- WITH exp AS (
-- SELECT role_title FROM job_postings
-- 	WHERE experience_required 
--     BETWEEN 0.0 AND 0.5
-- )
-- SELECT * FROM exp;

-- Offer at least 6 LPA maximum salary

-- WITH sal AS (
-- 	SELECT role_title FROM job_postings
--     WHERE min_salary_lpa > 6.0
-- )
-- SELECT * FROM sal;

-- Show company name, role, location, salary range, work mode

WITH comp_details AS (
	SELECT company_name, 
		   role_title, 
           location, 
           min_salary_lpa, 
           max_salary_lpa, 
           work_mode 
    FROM job_postings
)

SELECT * FROM comp_details