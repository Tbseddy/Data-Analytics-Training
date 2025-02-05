# WHERE CLAUSE in MySQL 
# WHERE is used to help filter our records or rows of data while SELECT statement is used to help filter or select our actual columns


SELECT * 
FROM employee_salary
WHERE first_name = 'Leslie';



SELECT * 
FROM employee_salary
WHERE salary >= 50000;



SELECT * 
FROM employee_demographics
WHERE gender != 'female';    #where gender is not equal to female



SELECT * 
FROM employee_demographics
WHERE birth_date > "1985-01-01";          #this is the standard date format within MySQL which is year-month-day


-- AND OR NOT -- Logical operators

SELECT * 
FROM employee_demographics
WHERE birth_date > "1985-01-01"
AND gender = 'male';




SELECT * 
FROM employee_demographics
WHERE birth_date > "1985-01-01"
OR gender = 'male';



SELECT * 
FROM employee_demographics
WHERE birth_date > "1985-01-01"
OR NOT gender = 'male';



SELECT * 
FROM employee_demographics
WHERE (first_name = 'Leslie' AND age = 44) OR age > 55;



-- LIKE statement 
-- we can add special character with our LIKE statement e.g % and _ 
-- % this sign means anything while the underscore (_) means a specific value

SELECT * 
FROM employee_demographics
WHERE first_name LIKE 'Jer%';       # what this means is that the first name is starting with Jer but that has anything after it



SELECT * 
FROM employee_demographics
WHERE first_name LIKE '%a%';       #this means that the table should display any first name that has a in it





SELECT * 
FROM employee_demographics
WHERE first_name LIKE 'a__';      #this means that any first name that starts with a and has just two characters after it because we used two undrscores
# (__)




