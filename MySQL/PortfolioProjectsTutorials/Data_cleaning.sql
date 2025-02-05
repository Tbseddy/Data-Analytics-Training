#Data Cleaning

#Create a new database click on Schema from the standard tool bar and name it world_layoffs
-- Click on the database, you then right click on Table data import wizard to iport your table


SELECT * 
FROM layoffs;

# Now when we are data cleaning we usually follow a few steps
-- 1. check for duplicates and remove any
-- 2. standardize data and fix errors
-- 3. Look at null values and see what 
-- 4. remove any columns and rows that are not necessary - few ways


-- first thing we want to do is create a staging table. 
-- This is the one we will work in and clean the data. We want a table with the raw data in case something happens

#This below statement creates a new table layoffs_staging that is structurally identical to world_layoffs.layoffs, but it will be empty (no rows of data).
CREATE TABLE world_layoffs.layoffs_staging   
LIKE world_layoffs.layoffs;  

# The LIKE clause instructs MySQL to copy the structure of the layoffs table. These includes:
-- Column definitions (names, data types, default values, etc.).
-- Indexes (e.g., primary keys, unique indexes).
-- Constraints (e.g., NOT NULL constraints). However, data is not copied—only the table schema is duplicated.




SELECT * 
FROM layoffs_staging;


# Copy all the data from the original table into the staging table:
INSERT layoffs_staging 
SELECT * 
FROM world_layoffs.layoffs;

-- 1. Remove Duplicates

# First let's check for duplicates

SELECT *,
ROW_NUMBER() 
OVER(PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) AS row_num
FROM layoffs_staging;

WITH duplicate_cte AS
(
SELECT *,
ROW_NUMBER() 
OVER(PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) AS row_num
FROM layoffs_staging
)
SELECT * 
FROM duplicate_cte
WHERE row_num > 1;

SELECT *
FROM layoffs_staging
WHERE company = 'Casper';

# Right click on layoff_staging and select copy to clipboard and click on create statement you will then paste it

CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SELECT * 
FROM layoffs_staging2;


INSERT INTO layoffs_staging2
SELECT *,
ROW_NUMBER() 
OVER(PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) AS row_num
FROM layoffs_staging;

SELECT * 
FROM layoffs_staging2
WHERE row_num > 1;


DELETE
FROM layoffs_staging2
WHERE row_num > 1;


SELECT * 
FROM layoffs_staging2
WHERE row_num > 1;


SELECT * 
FROM layoffs_staging2;



-- 2. Standardize Data

SELECT DISTINCT (company)
FROM layoffs_staging2;

SELECT DISTINCT (TRIM(company))
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET company = (TRIM(company));

SELECT * 
FROM layoffs_staging2;


SELECT DISTINCT industry
FROM layoffs_staging2;
-- if we look at industry it looks like we have some null and empty rows, let's take a look at these

SELECT DISTINCT industry
FROM layoffs_staging2
ORDER BY industry;   -- Or you say ORDER BY 1 

SELECT *
FROM layoffs_staging2
WHERE industry LIKE 'crypto%';

# As we can see some is crptocurrency, now we want to update everything to be crypo
UPDATE layoffs_staging2
SET industry = 'Crypto'
WHERE industry LIKE 'crypto%';

SELECT *
FROM layoffs_staging2
WHERE industry LIKE 'crypto%';

SELECT DISTINCT location
FROM layoffs_staging2
ORDER BY 1;
# Everything seems okay

SELECT *
FROM layoffs_staging2
ORDER BY 1;


SELECT DISTINCT country
FROM layoffs_staging2
ORDER BY 1;
-- everything looks good except apparently we have some "United States" and some "United States." with a period at the end. Let's standardize this.

SELECT DISTINCT country, TRIM(TRAILING '.' FROM country)
FROM layoffs_staging2
ORDER BY 1;


UPDATE layoffs_staging2
SET country = TRIM(TRAILING '.' FROM country)
WHERE country LIKE 'United States%';

-- now if we run this again it is fixed
SELECT DISTINCT country
FROM layoffs_staging2
ORDER BY 1;


SELECT *
FROM layoffs_staging2;

-- Let's also fix the date columns:
SELECT `date`
FROM layoffs_staging2;


SELECT `date`,
STR_TO_DATE(`date`, '%m/%d/%Y')     #Be mindful this particular line is case sensitive 
FROM layoffs_staging2;

-- we can use str to date to update this field
UPDATE layoffs_staging2
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y');

SELECT `date`
FROM layoffs_staging2;

ALTER TABLE layoffs_staging2
MODIFY COLUMN `date` DATE;

SELECT *
FROM layoffs_staging2;



-- 3. Look at Null Values

SELECT * 
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

-- the null values in total_laid_off, percentage_laid_off, and funds_raised_millions all look normal. I don't think I want to change that
-- I like having them null because it makes it easier for calculations during the EDA phase
-- so there isn't anything I want to change with the null values

-- 4. remove any columns and rows we need to

SELECT DISTINCT industry
FROM layoffs_staging2;  # We'd notice there are a missing value and a null value

UPDATE layoffs_staging2
SET industry = NULL
WHERE industry = '';



SELECT *
FROM layoffs_staging2  # We'd notice there are a missing value and a null value
WHERE industry IS NULL
OR industry = '';

# We will now check if any of the listed has a row that populated:
SELECT *
FROM layoffs_staging2
WHERE company = 'Airbnb';
# As we can see we have a row that has Travel under the industry column, we then try to populate the second row:

SELECT *
FROM layoffs_staging2 AS t1
JOIN layoffs_staging2 AS t2
	ON t1.company = t2.company
WHERE (t1.industry IS NULL OR t1.industry = '')
AND t2.industry IS NOT NULL;

SELECT t1.industry, t2.industry
FROM layoffs_staging2 AS t1
JOIN layoffs_staging2 AS t2
	ON t1.company = t2.company
WHERE (t1.industry IS NULL OR t1.industry = '')
AND t2.industry IS NOT NULL;


UPDATE layoffs_staging2 t1
JOIN layoffs_staging2 t2
	ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE t1.industry IS NULL
AND t2.industry IS NOT NULL;

SELECT *
FROM layoffs_staging2
WHERE company = 'Airbnb';

SELECT *
FROM layoffs_staging2  
WHERE industry IS NULL
OR industry = '';

SELECT *
FROM layoffs_staging2
WHERE company LIKE 'Bally%';
# So we don't have any other row


SELECT *
FROM layoffs_staging2;


-- 4. remove any columns and rows we need to

SELECT * 
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;


DELETE 
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;


SELECT * 
FROM layoffs_staging2;

ALTER TABLE layoffs_staging2
DROP COLUMN row_num;