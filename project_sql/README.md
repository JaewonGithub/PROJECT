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
- **Seniority and Experience:** Senior-level positions like "Senior Data Scientist," "Principal Data Scientist," and "Distinguished Data Scientist" offer lucrative salary packages. These roles typically demand extensive experience in data science, machine learning, and big data technologies, highlighting the importance of seniority and expertise in driving higher compensation.
- **Remote Work Opportunities:** Notably, all these top-paying data scientist positions are location-flexible, allowing professionals to work remotely ("Anywhere"). This trend emphasizes the growing acceptance and prevalence of remote work in the data science domain, enabling companies to access top talent globally and offering professionals greater flexibility in their careers.

### 2. Skills for the Top Paid Data Scientist jobs 
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

- **Diverse Skill Sets:** The top-paid data scientist jobs require a diverse skill set, reflecting the multifaceted nature of modern data science roles. Skills such as SQL, Python, Java, Scala, and cloud platforms (AWS, Azure) are highly valued, indicating the need for both data manipulation and programming capabilities.

- **Advanced Technologies:** Roles with higher salaries, such as Distinguished Data Scientist and Principal Data Scientist, often require expertise in advanced technologies like TensorFlow, PyTorch, Spark, and big data processing tools like Hadoop. This highlights the importance of machine learning, big data analytics, and distributed computing skills in commanding higher salaries.

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
- **Python and SQL Dominance:** Python continues to lead with high demand across industries, reflecting its versatility in data science, machine learning, and automation. SQL remains crucial for database management and querying tasks, underscoring the persistent need for data handling skills.

- **Diverse Toolset Significance:** Skills in statistical tools like R and SAS, alongside visualization tools such as Tableau, signify ongoing demand for professionals adept in data modeling, statistical analysis, and data visualization, crucial for informed decision-making.

- **Emerging Technology Focus:** Increasing demand for cloud computing platforms like AWS and Azure, machine learning frameworks such as TensorFlow and PyTorch, and big data technologies like Spark, reflects the industry's shift towards cloud-based analytics, AI/ML, and big data processing for scalable and efficient data solutions.
### 4. Top paid skills for Data Scientist jobs
```sql
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
```
| Skills        | Average Salary |
|---------------|----------------|
| Asana         | $200,284       |
| Airtable      | $189,600       |
| Redhat        | $189,500       |
| Watson        | $183,460       |
| Ringcentral   | $182,500       |
| Neo4j         | $170,861       |
| Elixir        | $170,824       |
| Lua           | $170,500       |
| Solidity      | $166,980       |
| Ruby on Rails | $166,500       |

Here's the breakdown of top paid skills for Data Scientist jobs:

- **Specialized Skills:** Skills like Neo4j (graph databases) and Solidity (blockchain development) offer competitive salaries, showcasing the value placed on niche or specialized expertise in certain technology domains.
- **Technology Sector Impact:** Skills related to cloud computing (Airtable, Redhat) and AI/ML (Watson) tend to have higher average salaries, reflecting the ongoing growth and investment in these sectors across industries.

### 5. Optimal skills to learn as a Data Scientist
Combining insights from demand and salary data, this query aimed to pinpoint skills that are both in high demand and have high salaries, offering a strategic focus for skill development. Also, included ratings column for better representation. (Tier 1 represents most optimal skills)
```sql
WITH optimal_skills AS (
    SELECT 
        skills_dim.skill_id,
        skills,
        COUNT(skills) AS demand_count,
        ROUND(AVG(salary_year_avg),0) as avg_salary

    FROM
        job_postings_fact
        INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
        INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE 
        job_title_short LIKE '%Data_Scientist%' AND 
        salary_year_avg IS NOT NULL
    GROUP BY skills_dim.skill_id
    HAVING COUNT(skills) > 5
)
SELECT *,
    CASE 
        WHEN demand_count > 1000 AND avg_salary > 140000 THEN 'Tier 1'
        WHEN demand_count > 500 AND avg_salary > 140000 THEN 'Tier 2'
        ELSE 'Tier 3'
    END AS ratings
FROM 
    optimal_skills
ORDER BY 
    demand_count DESC , avg_salary DESC
LIMIT 20
```
| Skill ID | Skills       | Demand Count | Average Salary | Ratings | 
|----------|--------------|--------------|----------------|---------|
| 1        | python       | 5616         | $141,976       | Tier 1  |
| 0        | sql          | 4175         | $142,319       | Tier 1  |
| 5        | r            | 3177         | $138,714       | Tier 3  |
| 182      | tableau      | 1607         | $134,753       | Tier 3  |
| 76       | aws          | 1349         | $141,748       | Tier 1  |
| 92       | spark        | 1291         | $149,662       | Tier 1  |
| 99       | tensorflow   | 880          | $146,920       | Tier 2  |
| 74       | azure        | 823          | $135,560       | Tier 3  |
| 101      | pytorch      | 772          | $149,663       | Tier 2  |
| 97       | hadoop       | 767          | $141,181       | Tier 2  |
| 181      | excel        | 763          | $127,406       | Tier 3  |
| 186      | sas          | 762          | $125,255       | Tier 3  |
| 7        | sas          | 762          | $125,255       | Tier 3  |
| 4        | java         | 701          | $135,183       | Tier 3  |
| 93       | pandas       | 639          | $142,440       | Tier 2  |
| 183      | power bi     | 592          | $120,971       | Tier 3  |
| 3        | scala        | 531          | $146,704       | Tier 2  |
| 210      | git          | 520          | $131,711       | Tier 3  |
| 106      | scikit-learn | 513          | $145,940       | Tier 2  |
| 8        | go           | 460          | $153,973       | Tier 3  |

Here's the breakdown of optimal skills to learn as a Data Scientist:

- **Tier 1 Skills (High Demand, High Salary):** Python and SQL Widely demanded (5616 and 4175 job postings) with competitive salaries ($141,976 and $142,319). AWS and Spark offer substantial job opportunities (1349 and 1291 job postings) with attractive salaries ($141,748 and $149,662).
- **Tier 2 Skills (Moderate Demand, Competitive Salary):** TensorFlow, PyTorch, Hadoop, Scala, Pandas, and Scikit-Learn: Good demand (ranging from 513 to 880 job postings) with competitive salaries ($120,971 to $146,920).
- **Tier 3 Skills (Steady Demand, Varied Salary):** R, Tableau, Azure, Java, Excel, SAS, Power BI, Git, and Go: Exhibit steady demand (ranging from 460 to 3177 job postings) with varying salaries ($120,971 to $153,973). Specific roles within data science, analytics, and software development benefit from these skills.

# What I learned
Throughout this journey, I have significantly enhanced my SQL proficiency with advanced capabilities:

- 🧩 **Advanced Query Construction:** Mastered the intricacies of SQL by seamlessly merging tables and employing WITH clauses for sophisticated temporary table operations.

- 📊 **Data Aggregation Mastery:** Developed expertise in data summarization techniques using GROUP BY alongside aggregate functions like COUNT() , ROUND() and AVG(), enabling comprehensive data analysis.

-💡 **Analytical Expertise:** Enhanced my problem-solving skills by translating complex questions into actionable SQL queries, generating valuable insights for decision-making processes.

# Conclusions
From the analysis, several general insights emerged:

1. Top-Paying Data Scientist Jobs: The highest-paying jobs for data scientists that allow remote work offer a wide range of salaries, the highest at $550,000!
Skills for Top-Paying Jobs: High-paying data analyst jobs require advanced proficiency in SQL, suggesting it’s a critical skill for earning a top salary.
Most In-Demand Skills: SQL is also the most demanded skill in the data analyst job market, thus making it essential for job seekers.
Skills with Higher Salaries: Specialized skills, such as SVN and Solidity, are associated with the highest average salaries, indicating a premium on niche expertise.
Optimal Skills for Job Market Value: SQL leads in demand and offers for a high average salary, positioning it as one of the most optimal skills for data analysts to learn to maximize their market value.