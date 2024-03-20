/*
Q1. What are the top-paying Data Scientist jobs?
-Identify the top 10 highest-paying Data Scientist jobs that are available at anywhere.
-Only consider the jobs with specific yearly average salaries.
-Why? Highlight the top-paying opportunities for Data Scientists, offering insight into how much you should be expecting for your yealry salary.
*/


SELECT 
    job_id,
    job_title,
    name AS company_name,
    salary_year_avg,
    job_location,
    job_schedule_type,
    job_posted_date

FROM
    job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id

WHERE 
    job_title LIKE '%Data_Scientist%' AND
    job_location = 'Anywhere' AND 
    salary_year_avg IS NOT NULL 

ORDER BY salary_year_avg DESC

LIMIT 10
