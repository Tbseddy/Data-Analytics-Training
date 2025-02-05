-- Having vs Where



SELECT gender, avg(age)
FROM employee_demographics
group by gender
Having avg(age) > 40;


SELECT *
FROM employee_salary;


SELECT occupation, avg(salary)
FROM employee_salary
group by occupation;


SELECT occupation, avg(salary)
FROM employee_salary
where occupation like '%manager%'
group by occupation
having avg(salary) > 75000;

