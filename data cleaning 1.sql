SELECT * FROM projects.hr;

-- changing column name
alter table hr
change column ï»¿id emp_id varchar(20) null;

select * from hr;

-- now checking the datatype of HR
describe hr;

select birthdate from hr;

set sql_safe_updates =0;
-- changing the data type of birthday
update hr
set birthdate = case
when birthdate like '%/%' then date_format(str_to_date(birthdate, '%m/%d/%Y'), '%Y-%m-%d')
when birthdate like '%-%' then date_format(str_to_date(birthdate, '%m-%d-%Y'),'%Y-%m-%d')
else null
end;

select birthdate from hr;
-- now changing the datatype of birthdate text to date

alter table hr
modify column birthdate date;
describe hr;

-- now changing hire date
select hire_date from hr;

-- first we will change the format of hire_date
update hr
set hire_date = case
when hire_date like '%/%' then date_format(str_to_date(hire_date, '%m/%d/%Y'), '%Y-%m-%d')
when hire_date like '%-%' then date_format(str_to_date(hire_date, '%m-%d-%Y'), '%Y-%m-%d')
else null
end;

-- now changing the datatype of hire_date

alter table hr
modify hire_date date;

describe hr;

-- now changing format termdate
select termdate from hr;

UPDATE hr
SET termdate = date(str_to_date(termdate, '%Y-%m-%d %H:%i:%s UTC'))
WHERE termdate IS NOT NULL AND termdate != ' ';

ALTER TABLE hr
MODIFY COLUMN termdate DATE;

alter table hr
add column age int;

select * from hr;

-- now how to add age column

update hr
set age = timestampdiff(year, birthdate, curdate());

select age, birthdate from hr;







