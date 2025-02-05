-- group By 
#GROUP is used to group together rows that have the same values in a specified column or columns that you are actually grouping on

SELECT * 
FROM employee_demographics;


SELECT gender
FROM employee_demographics
group by gender;


SELECT gender, avg(age)
FROM employee_demographics
group by gender;





SELECT occupation
FROM employee_salary
group by occupation;


SELECT occupation, salary
FROM employee_salary
group by occupation, salary
;


SELECT gender, avg(age), max(age), min(age), count(age)
FROM employee_demographics
group by gender;

-- Order By
#Order By is used to sort the result set in either ascending or descending order


SELECT *
FROM employee_demographics
order by first_name;      #By default this sorting is in ascending order



SELECT *
FROM employee_demographics
order by first_name desc;



SELECT *
FROM employee_demographics
order by gender;



SELECT *
FROM employee_demographics
order by gender, age;