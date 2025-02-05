-- Limit & Aliasing


SELECT * 
FROM employee_demographics;


SELECT * 
FROM employee_demographics
LIMIT 3;



SELECT * 
FROM employee_demographics
ORDER BY age desc
LIMIT 3;
# To extract the top three oldest people in the table


SELECT * 
FROM employee_demographics
ORDER BY age desc
LIMIT 2, 1;            # start at position 2 and select the one after it


-- Aliasing: Is a way to change the name of the column 


Select gender, avg(age) As avg_age
From employee_demographics
group by gender
Having avg_age > 40;