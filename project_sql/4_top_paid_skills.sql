/*
Question: What are the top skills to learn as a Data Scientist? 
- Find the average salary associated with each skill for Data Scientist positions. 
- Exclude on roles with null-value for salaries. 
- Focuses on all roles regardless of location.
- Why? It reveals how different skills will impact salary levels for Data Scientists and help
identifying most financially rewarding skills to acquire.
*/
WITH top_paying_skills AS (
    SELECT *
    FROM
        job_postings_fact
        INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
        INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE 
        job_title_short LIKE '%Data_Scientist%' AND
        salary_year_avg IS NOT NULL 
)
SELECT 
    skills,
    ROUND(AVG(salary_year_avg), 0) as avg_salary
FROM
    top_paying_skills
GROUP BY 
    skills
ORDER BY 
    avg_salary DESC
LIMIT 10;

