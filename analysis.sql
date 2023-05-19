-- now we have 11 question to answer
-- QUESTIONS

select * from hr;
-- 1. What is the gender breakdown of employees in the company?

select gender, count(*) as count from hr
where age > 18 and termdate='0000-00-00'
group by gender;

-- 2. What is the race/ethnicity breakdown of employees in the company?
select race, count(*) as count from hr
where age > 18 and termdate='0000-00-00'
group by race
order by count desc;

-- 3. What is the age distribution of employees in the company?
select 
case 
when age>=18 and age <=24 then '18-24'
when age>=25 and age <=34 then '25-34'
when age>=35 and age <=44 then '35-44'
when age>=45 and age <=54 then '45-54'
when age>=55 and age <=64 then '55-64'
else '65+'
end as age_group,gender
,count(*) as count
from hr
where age > 18 and termdate='0000-00-00'
group by age_group,gender
order by age_group,gender;

-- 4. How many employees work at headquarters versus remote locations?

select location,count(*) as count from hr
where age > 18 and termdate='0000-00-00'
group by location;

-- 5. What is the average length of employment for employees who have been terminated?
select * from hr;

select round(avg(datediff(termdate,hire_date))/365,0) as avg_length_employment
from hr
where termdate<=curdate() and termdate != '0000-00-00' and age >18;

-- 6. How does the gender distribution vary across departments and job titles?
select department, gender, count(*) as count from hr
where age > 18 and termdate='0000-00-00'
group by department, gender
order by department;

-- 7. What is the distribution of job titles across the company?
select department,jobtitle, count(*) as count from hr
where age > 18 and termdate='0000-00-00'
group by jobtitle,department
order by jobtitle desc;

-- 8. Which department has the highest turnover rate?

SELECT department, COUNT(*) as total_count, 
    SUM(CASE WHEN termdate <= CURDATE() AND termdate <> '0000-00-00' THEN 1 ELSE 0 END) as terminated_count, 
    SUM(CASE WHEN termdate = '0000-00-00' THEN 1 ELSE 0 END) as active_count,
    (SUM(CASE WHEN termdate <= CURDATE() THEN 1 ELSE 0 END) / COUNT(*)) as termination_rate
FROM hr
WHERE age >= 18
GROUP BY department
ORDER BY termination_rate DESC;

-- 9. What is the distribution of employees across locations by state?
select * from hr;

select location_state, location_city, count(*) as count 
from hr
where age>=18 and termdate='0000-00-00'
group by location_state, location_city
order by count desc;

-- 10. How has the company's employee count changed over time based on hire and term dates?

SELECT 
    year, 
    hires, 
    terminations, 
    (hires - terminations) AS net_change,
    ROUND(((hires - terminations) / hires * 100), 2) AS net_change_percent
FROM (
    SELECT 
        YEAR(hire_date) AS year, 
        COUNT(*) AS hires, 
        SUM(CASE WHEN termdate <> '0000-00-00' AND termdate <= CURDATE() THEN 1 ELSE 0 END) AS terminations
    FROM 
        hr
    WHERE age >= 18
    GROUP BY 
        YEAR(hire_date)
) subquery
ORDER BY 
    year ASC;

-- 11. What is the tenure distribution for each department?


select department, round(avg(datediff(termdate, hire_date)/365),0) as avg_tenure
from hr
where termdate <= curdate() and age>=18 and termdate<>'0000-00-00'
group by department
order by avg_tenure desc;



