# Introduction
📊 Exploration into Data-related professionals job market! <br>Focusing on Data Scientist jobs, this project explores 💰 top-paying jobs, 🔥 in-demand skills, and 📈 where high demand meets high salary.

🔍 SQL queries? Check them out here: [project_sql folder](/project_sql/)
# Background
Motivated by the goal of analyzing the Data Scientist jobs in the job market,
this project emerged from a determination to identify highly paid and highly demanded skills, simplifying the process of preparation for admiring Data Scientist to discover the most advantageous job opportunities.

Data hails from my [Google Drive](https://drive.google.com/file/d/1vm-6-50dpLr0tIhRiO3bLuH1cDESMTzK/view?usp=sharing) sourced by Kaggle. It contains 2023 information about Data-related professionals job market.

### The Questions answered through SQL queries:
1. What are the top-paying Data Scientist jobs?
2. What skills are required for these top-paying jobs?
3. What skills are most in-demand for Data Scientists?
4. Which skills are associated with higher salaries among Data Scientist jobs?
5. What are the most optimal skills to learn?
# Utilized Tools
To thoroughly explore the Data Scientist jobs in the job market, I utilized several essential tools :
- **SQL:** Serving as the foundation of my analysis, enabling me to query the database and discover crucial insights.
- **PostgreSQL:** Selected as the optimal database management system for efficiently managing the data for the analysis.
- **Visual Studio Code:** My preferred tool for database management tasks and executing SQL queries.
- **Git & GitHub:** Critical for version control and sharing my SQL scripts and analyses, facilitating project tracking.

# Analysis
### Each query for this project aimed at investigating specific aspects of the Data Scientist job market. <br>Here’s how I approached each question:
<br>

### 1. Top Paid Data Scientist Jobs
To identify the highest-paying roles amongst all Data Scientist jobs, I filtered data Scientist positions by the location and average yearly salary. For the location, I conditioned it  as 'Anywhere,' which allows the output of all remote and onsite jobs.
This query highlights the highly paid opportunities in the Data Scientist job market.
```sql
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
```
| job_id   | job_title                                       | company_name                      | salary_year_avg | job_location | job_schedule_type | job_posted_date      |
|----------|-------------------------------------------------|-----------------------------------|-----------------|--------------|-------------------|----------------------|
| 40145    | Staff Data Scientist/Quant Researcher           | Selby Jennings                   | $550,000.0      | Anywhere     | Full-time         | 2023-08-16 16:05:16  |
| 1714768  | Staff Data Scientist - Business Analytics       | Selby Jennings                   | $525,000.0      | Anywhere     | Full-time         | 2023-09-01 19:24:02  |
| 327496   | Senior Data Scientist                           | Glocomms                         | $475,000.0      | Anywhere     | Full-time         | 2023-01-31 16:03:46  |
| 1131472  | Data Scientist                                  | Algo Capital Group                | $375,000.0      | Anywhere     | Full-time         | 2023-07-31 14:05:21  |
| 627602   | Senior Data Scientist                           | Algo Capital Group                | $375,000.0      | Anywhere     | Full-time         | 2023-08-30 10:06:34  |
| 38905    | Principal Data Scientist                        | Storm5                            | $300,000.0      | Anywhere     | Full-time         | 2023-11-24 14:08:44  |
| 91852    | Senior Data Scientist                           | Top Artificial Intelligence Co.   | $300,000.0      | Anywhere     | Null              | 2023-03-22 16:11:54  |
| 226011   | Distinguished Data Scientist                    | Walmart                           | $300,000.0      | Anywhere     | Full-time         | 2023-08-06 11:00:43  |
| 178888   | Pre-Sales Data Scientist, Financial Services   | Teradata                          | $288,000.0      | Anywhere     | Full-time         | 2023-08-26 09:55:56  |
| 886101   | Distinguished Data Scientist                    | Torc Robotics                     | $275,000.0      | Anywhere     | Full-time         | 2023-06-27 20:46:25  |

Here's the breakdown of the top Data Scientist jobs in 2023:
- **Wide Salary Range** - The salary range of top 10 Data Scientist jobs in 2023 is very large, indicating salary potential in the field.
- **High Salary Company** - *Selby Jennings* company offers greatest salary amongst all Data Scientist job postings in 2023.
- **Job Schedule Type** - All of the highly paid jobs are Full-time, indicating importance of job schedule being full time for high salary.

### 2. Skills for the Top Paid Data Scientist jobs (From Q1)
To understand which skills are required for the top paid Data Scientist jobs, I joined the job postings data with the skills data, providing insight into what employers value for high-compensation rolees.
```sql
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
```
| job_id   | job_title                                       | company_name                      | salary_year_avg | skills       |
|----------|-------------------------------------------------|-----------------------------------|-----------------|--------------|
| 40145    | Staff Data Scientist/Quant Researcher           | Selby Jennings                   | $550,000.0      | SQL, Python  |
| 1714768  | Staff Data Scientist - Business Analytics       | Selby Jennings                   | $525,000.0      | SQL          |
| 627602   | Senior Data Scientist                           | Algo Capital Group                | $375,000.0      | SQL, Python, Java, C++, Cassandra, Spark, Hadoop, Tableau  |
| 1131472  | Data Scientist                                  | Algo Capital Group                | $375,000.0      | SQL, Python, Java, Cassandra, Spark, Hadoop, Tableau  |
| 226011   | Distinguished Data Scientist                    | Walmart                           | $300,000.0      | Scala, Java, Spark, TensorFlow, PyTorch, Kubernetes  |
| 38905    | Principal Data Scientist                        | Storm5                            | $300,000.0      | SQL, Python, Java, C, AWS, GCP  |
| 178888   | Pre-Sales Data Scientist, Financial Services    | Teradata                          | $288,000.0      | SQL, Python, NoSQL, R, SAS, MATLAB, Azure, Databricks, AWS, Redshift, Oracle, Snowflake, Spark, Tableau, Qlik, SAS  |

Here's the breakdown of the required skills for top paid Data Scientist jobs in 2023:
- **SQL** leads the game, being required by every single top paid Data Scientist jobs.
- **Python and Java** follows, with respective counts of 5 and 4. 

### 3. In-Demand Skills for Data Scientist

This query helped identify the skills most frequently requested in job postings, directing focus to areas with high demand.
```sql
WITH top_demanded_skills AS (
    SELECT *

    FROM
        job_postings_fact
        INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
        INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE 
        job_title LIKE '%Data_Scientist%' 
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

LIMIT 10
```
| skills      | demand_count |
|-------------|--------------|
| Python      | 112303       |
| SQL         | 74605        |
| R           | 58857        |
| SAS         | 27622        |
| Tableau     | 27097        |
| AWS         | 26137        |
| Spark       | 24912        |
| Azure       | 20759        |
| TensorFlow  | 20721        |
| PyTorch     | 16682        |

Here's the breakdown of skills most frequently requested in Data Scientist job postings:
- **Python** is the skill most in-demand , with count of 112,303.
- **SQL** immediately follows with the second highest demand count of 74,605.  


# What I learned

# Conclusions
