# Subqueries

#So subqueries are queries within queries. Let's see how this looks.

SELECT *
FROM employee_demographics;

#Now let's say we wanted to look at employees who actually work in the Parks and Rec Department, 
-- we could join tables together or we could use a subquery
#We can do that like this:


SELECT *
FROM employee_demographics
WHERE employee_id IN 
			(SELECT employee_id
				FROM employee_salary
                WHERE dept_id = 1);
                
# We are selecting everything from the employee_demographics table where employee_id in this table 
-- matches or is in the select employee_id from the salary table where the department_id is equal to 1



# now if we try to have more than 1 column in the subquery we get an error saying the operand should contain 1 column only 
#We can also use subqueries in the select and the from statements - let's see how we can do this
-- Let's say we want to look at the salaries and compare them to the average salary

SELECT first_name, salary, AVG(salary)
FROM employee_salary;
-- if we run this it's not going to work, we are using columns with an aggregate function so we need to use group by
-- if we do that though we don't exactly get what we want
SELECT first_name, salary, AVG(salary)
FROM employee_salary
GROUP BY first_name, salary;



-- it's giving us the average PER GROUP which we don't want
-- here's a good use for a subquery

SELECT first_name, 
salary, 
(SELECT AVG(salary) 
	FROM employee_salary) as salary_avg
FROM employee_salary;





-- We can also use it in the FROM Statement
-- when we use it here it's almost like we are creating a small table we are querying off of
SELECT *
FROM (SELECT gender, MIN(age), MAX(age), COUNT(age),AVG(age)
FROM employee_demographics
GROUP BY gender) 
;
-- now this doesn't work because we get an error saying we have to name it

SELECT gender, AVG(Min_age)
FROM (SELECT gender, 
MIN(age) as Min_age,
 MAX(age) as Max_age,
 COUNT(age) as Count_age, 
 AVG(age) as Avg_age
FROM employee_demographics
GROUP BY gender) AS Agg_Table
GROUP BY gender
;

