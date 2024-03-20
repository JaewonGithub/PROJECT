/*
Question: What are the most in-demand skills for Data Scientist?
- Join job postings to inner join table similar to query 2
- Identify the top 5 in-demand skills for a Data Scientist.
- Focus on all of the job postings.
- Why? Returns the top 5 skills with the highest demand in the job market, which provides 
insights into the most valuable skills for job seekers.
*/

WITH top_demanded_skills AS (
    SELECT *

    FROM
        job_postings_fact
        INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
        INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE 
        job_title_short LIKE '%Data_Scientist%' 
)

SELECT
    skills,
    COUNT(skills) AS demand_count

FROM 
    top_demanded_skills
GROUP BY 
    skills

ORDER BY 
    demand_count DESC

LIMIT 5