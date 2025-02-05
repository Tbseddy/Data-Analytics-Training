# Exploratory Data Analysis (EDA)

-- Here we are jsut going to explore the data and find trends or patterns or anything interesting like outliers
-- normally when you start the EDA process you have some idea of what you're looking for
-- with this info we are just going to look around and see what we find!

SELECT * 
FROM layoffs_staging2;


-- Looking at Percentage to see how big these layoffs were
SELECT MAX(percentage_laid_off),  MIN(percentage_laid_off)
FROM layoffs_staging2
WHERE  percentage_laid_off IS NOT NULL;


SELECT MAX(total_laid_off) 
FROM layoffs_staging2;

SELECT MIN(total_laid_off) 
FROM layoffs_staging2;

-- Let's look at the maximum percentage laid off
SELECT MAX(total_laid_off), MAX(percentage_laid_off)
FROM layoffs_staging2;
-- one(1) represent 100%. Which means 100% of the company was laid off

-- Which companies had 1 which is basically 100 percent of they company laid off
SELECT *
FROM layoffs_staging2
WHERE  percentage_laid_off = 1;
-- these are mostly startups it looks like who all went out of business during this time


SELECT * 
FROM layoffs_staging2
WHERE percentage_laid_off = 1
ORDER BY total_laid_off DESC;

-- if we order by funcs_raised_millions we can see how big some of these companies were
SELECT * 
FROM layoffs_staging2
WHERE percentage_laid_off = 1
ORDER BY funds_raised_millions DESC;
-- BritishVolt looks like an EV company, Quibi! I recognize that company - wow raised like 2 billion dollars and went under


SELECT company, SUM(total_laid_off)
FROM layoffs_staging2
Group by company;

SELECT company, SUM(total_laid_off)
FROM layoffs_staging2
Group by company
order by 2 desc;   -- 2 refers to the second column in the SELECT statement, which is SUM(total_laid_off).
-- This means companies with the highest number of total layoffs will appear at the top of the results.



-- Companies with the biggest single Layoff
SELECT company, total_laid_off
FROM layoffs_staging
ORDER BY 2 DESC     -- sorts by the second column (total_laid_off) in descending order.
LIMIT 5;    -- restricts the output to the top 5 rows.
-- now that's just on a single day


SELECT company, total_laid_off
FROM layoffs_staging
ORDER BY 2 DESC     -- sorts by the second column (total_laid_off) in descending order.
LIMIT 10;    -- restricts the output to the top 10 rows.


-- by location
SELECT location, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY location
ORDER BY 2 DESC
LIMIT 10;


SELECT country, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY country
ORDER BY 2 DESC;

SELECT MIN(`date`), MAX(`date`)
FROM layoffs_staging2;


SELECT industry, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY industry
ORDER BY 2 DESC;



SELECT stage, SUM(total_laid_off)
FROM world_layoffs.layoffs_staging2
GROUP BY stage
ORDER BY 2 DESC;

SELECT `date`, SUM(total_laid_off)
FROM world_layoffs.layoffs_staging2
GROUP BY `date`
ORDER BY 2 DESC;


SELECT `date`, SUM(total_laid_off)
FROM world_layoffs.layoffs_staging2
GROUP BY `date`
ORDER BY 1 DESC;


SELECT YEAR(`date`), SUM(total_laid_off)
FROM world_layoffs.layoffs_staging2
GROUP BY YEAR(`date`)
ORDER BY 1 ASC;



SELECT * 
FROM layoffs_staging2;


SELECT substring(`date`,6,2) as `Month`      -- to pull out the month
FROM layoffs_staging2;


-- Rolling Total of Layoffs Per Month

SELECT substring(`date`,6,2) as `Month`,  sum(total_laid_off)
FROM layoffs_staging2
group by `Month`;

SELECT substring(`date`,1,7) as `Month`,  sum(total_laid_off)
FROM layoffs_staging2
where substring(`date`,1,7) is not null
group by `Month`
order by 1 asc;

SELECT substring(`date`,1,10) as `Month`,  sum(total_laid_off)
FROM layoffs_staging2
group by `Month`;


with rolling_total as 
(
SELECT substring(`date`,1,7) as `Month`,  sum(total_laid_off) as total_off
FROM layoffs_staging2
where substring(`date`,1,7) is not null
group by `Month`
order by 1 asc
)
select `Month`, total_off,  sum(total_off) over(order by `Month`) as rolling_total
from rolling_total;
-- Month by month progression of total laid off 


SELECT company, SUM(total_laid_off)
FROM layoffs_staging2
Group by company
order by 2 desc;


SELECT company, year(`date`), SUM(total_laid_off)
FROM layoffs_staging2
Group by company, year(`date`)
order by company asc;


SELECT company, year(`date`), SUM(total_laid_off)
FROM layoffs_staging2
Group by company, year(`date`)
order by 3 desc;


-- TOUGHER QUERIES-------------------------------------------------------------------------------------------------------------------------------

-- Earlier we looked at Companies with the most Layoffs. Now let's look at that per year. It's a little more difficult.

With Company_Year (company, years, total_laid_off) AS 
(
SELECT company, year(`date`), SUM(total_laid_off)
FROM layoffs_staging2
Group by company, year(`date`)
)
select *
from Company_Year;




With Company_Year (company, years, total_laid_off) AS 
(
SELECT company, year(`date`), SUM(total_laid_off)
FROM layoffs_staging2
Group by company, year(`date`)
)
select *, dense_rank() over (partition by years order by total_laid_off desc) as ranking
from Company_Year
where years is not null
order by ranking asc;



With Company_Year (company, years, total_laid_off) AS 
(
SELECT company, year(`date`), SUM(total_laid_off)
FROM layoffs_staging2
Group by company, year(`date`)
), Company_Year_Rank as
(
select *, dense_rank() over (partition by years order by total_laid_off desc) as ranking
from Company_Year
where years is not null
)
select * 
from Company_Year_Rank
where ranking <= 5;


