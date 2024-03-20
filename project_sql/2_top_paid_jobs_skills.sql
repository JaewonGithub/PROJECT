/*
Q2. What skills are required for the top-paying data scientist jobs?
- Use the top 10 jobs from the first query created.
- Show the specific skills required for the corresponding jobs.
- Why? It provides a desired look at which skills are demanded by high-paying jobs,
  helping job seekers to understand which skills to focus and develop in order to align skillset with top salaries.
*/

WITH top_10_jobs_skills AS (

    SELECT 
        job_id,
        job_title,
        name AS company_name,
        salary_year_avg

    FROM
        job_postings_fact
        LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id

    WHERE 
        job_title LIKE '%Data_Scientist%' AND
        job_location = 'Anywhere' AND 
        salary_year_avg IS NOT NULL 

    ORDER BY 
        salary_year_avg DESC

    LIMIT 10
)

SELECT 
    top_10_jobs_skills.*,
    skills

FROM 
    top_10_jobs_skills
    INNER JOIN skills_job_dim ON top_10_jobs_skills.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id

ORDER BY 
    salary_year_avg DESC;
