-- Joins

-- joins allow you to combine 2 tables together (or more) if they have a common column.
-- doesn't mean they need the same column name, but the data in it are the same and can be used to join the tables together
-- there are several joins we will look at today, inner joins, outer joins, and self joins

-- here are the first 2 tables - let's see what columns and data in the rows we have in common that we can join on

SELECT *
FROM employee_demographics;

SELECT *
FROM employee_salary;


-- let's start with an inner join -- inner joins return rows that are the same in both columns

-- since we have the same columns we need to specify which table they're coming from

SELECT *
FROM employee_demographics
JOIN employee_salary
	ON employee_demographics.employee_id = employee_salary.employee_id;
    
    
-- notice Ron Swanson isn't in the results? This is because he doesn't have an employee id in the demographics table. He refused to give his birth date or age or gender

-- use aliasing to get the same result!
SELECT *
FROM employee_demographics AS dem
INNER JOIN employee_salary AS sal
	ON dem.employee_id = sal.employee_id;
    
    
-- OUTER JOINS

-- for outer joins we have a left and a right join
-- a left join will take everything from the left table even if there is no match in the join, but will only return matches from the right table
-- the exact opposite is true for a right join

SELECT *
FROM employee_salary AS sal
LEFT JOIN employee_demographics AS dem
	ON dem.employee_id = sal.employee_id;
    
-- so you'll notice we have everything from the left table or the salary table. Even though there is no match to ron swanson. 
-- Since there is not match on the right table it's just all Nulls

-- if we just switch this to a right join it basically just looks like an inner join
-- that's because we are taking everything from the demographics table and only matches from the left or salary table. Since they have all the matches
-- it looks kind of like an inner join

SELECT *
FROM employee_salary AS sal
RIGHT JOIN employee_demographics AS dem
	ON dem.employee_id = sal.employee_id;
    
-- Self Join

-- a self join is where you tie a table to itself

SELECT *
FROM employee_salary;



SELECT *
FROM employee_salary emp1
JOIN employee_salary emp2
	ON emp1.employee_id = emp2.employee_id;

-- what we could do is a secret santa so the person with the higher ID is the person's secret santa

SELECT *
FROM employee_salary emp1
JOIN employee_salary emp2
	ON emp1.employee_id + 1  = emp2.employee_id
    ;

SELECT emp1.employee_id as emp_santa,
 emp1.first_name as santa_first_name,
 emp1.last_name as santa_last_name,
 emp2.employee_id as emp_name,
 emp2.first_name as first_name_emp,
 emp2.last_name as last_name_emp
FROM employee_salary emp1
JOIN employee_salary emp2
	ON emp1.employee_id + 1  = emp2.employee_id
    ;
    
-- So leslie is Ron's secret santa and so on -- 
-- Mark Brandanowitz didn't get a secret santa, but he doesn't deserve one because he broke Ann's heart so it's all good

-- Joining multiple tables

-- now we have on other table we can join - let's take a look at it

SELECT * 
FROM parks_and_recreation.parks_departments;


SELECT *
FROM employee_demographics as dem
INNER JOIN employee_salary as sal
	ON dem.employee_id = sal.employee_id
    INNER JOIN parks_departments as pd
    ON sal.dept_id = pd.department_id
    ;
    
    -- now notice when we did that, since it's an inner join it got rid of andy because he wasn't a part of any department


-- if we do a left join we would still include him because we are taking everything from the left table which is the salary table in this instance


SELECT *
FROM employee_demographics as dem
INNER JOIN employee_salary as sal
	ON dem.employee_id = sal.employee_id
LEFT JOIN parks_departments dept
	ON dept.department_id = sal.dept_id;