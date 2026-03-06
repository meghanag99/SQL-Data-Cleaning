-- DATA CLEANING 

CREATE TABLE layoffs_staging
LIKE layoffs;  -- CREATING A STAGING TABLE TO ALTER AND MODIFY THE VALUES SO AS TO NOT AFFECT THE ORIGINAL DATA

INSERT layoffs_staging 
(SELECT * FROM layoffs); -- INSERTING THE VALUES INTO THE STAGING TABLE. 

SELECT * FROM layoffs_staging;
SELECT COUNT(*) FROM layoffs_staging; -- CHECKING WHETHER ALL ROWS WERE COPIED INTO THE STAGING TABLE. 

-- 1) REMOVE DUPLICATES FROM THE DATA

-- SINCE THERE IS NO UNIQUE PRIMARY KEY TO IDENTIFY DUPLICATES,
-- WE GENERATE ROW NUMBERS FOR EACH RECORD
-- ROW NUMBER SHOULD BE 1 FOR UNIQUE RECORDS BECAUSE WE PARTITION BY ALL COLUMNS
-- IF MULTIPLE ROWS CONTAIN IDENTICAL VALUES ACROSS ALL COLUMNS, SUBSEQUENT ROWS WILL RECEIVE ROW NUMBERS GREATER THAN 1

WITH row_num_cte AS (SELECT *, row_number() OVER(PARTITION BY company,
location,
industry,
total_laid_off,  
percentage_laid_off,  
`date`,
stage,  
country,  
funds_raised_millions) AS row_numb FROM layoffs_staging)
SELECT * FROM row_num_cte WHERE row_numb >1;

-- SINCE WE CANNOT DIRECTLY DELETE ROWS FROM A CTE, WE CREATE ANOTHER STAGING TABLE TO STORE ROW NUMBERS
-- AND REMOVE DUPLICATE RECORDS 

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
  `row_numb` int 
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO layoffs_staging2 SELECT *, row_number() OVER(PARTITION BY company,
location,
industry,
total_laid_off,  
percentage_laid_off,  
`date`,
stage,  
country,  
funds_raised_millions) AS row_numb FROM layoffs_staging;

DELETE FROM layoffs_staging2 WHERE row_numb>1;
SELECT * FROM layoffs_staging2 WHERE row_numb>1;

-- 2) STANDARDIZING THE DATA

SELECT DISTINCT(TRIM(company)) FROM layoffs_staging2;
UPDATE layoffs_staging2 SET company = TRIM(company); -- UPDATING THE COMPANY COLUMN WITH ADDITIONAL SPACES TAKEN OUT.
SELECT * FROM layoffs_staging2;

SELECT DISTINCT(industry) FROM layoffs_staging2; 
UPDATE layoffs_staging2 SET industry = 'Crypto' WHERE industry LIKE 'Crypto%'; -- STANDARDIZING INDUSTRY NAMES THAT APPEAR WITH MINOR VARIATIONS

SELECT DISTINCT(country) FROM layoffs_staging2 ORDER BY 1;
UPDATE layoffs_staging2 SET country = 'United States' WHERE country LIKE 'United States%'; -- STANDARDIZING COUNTRY NAMES THAT APPEAR WITH MINOR VARIATIONS

SELECT `date`, str_to_date(`date`, '%m/%d/%Y') AS converted_date FROM layoffs_staging2;
UPDATE layoffs_staging2 SET `date`= str_to_date(`date`, '%m/%d/%Y');
ALTER TABLE layoffs_staging2
MODIFY COLUMN `date` DATE; -- CONVERTING THE DATE COLUMN FROM TEXT FORMAT TO A PROPER DATE DATATYPE

-- 3) NULL VALUES HANDLING

-- INDUSTRIES OF THE COMPANY HAVING NULL VALUES IN FEW ROWS BUT THE SAME COMPANIES HAVE AN
-- INDUSTRY IN THE OTHER ROWS. WE WILL COMPARE AND POPULATE THESE NULL OR BLANK VALUES.

UPDATE layoffs_staging2 SET industry = NULL WHERE industry = ''; -- CHANGING ALL THE BLANK VALUES INTO TO NULL
SELECT * FROM layoffs_staging2 WHERE industry IS NULL OR industry = ''; 

SELECT l1.industry, l2.industry FROM layoffs_staging2 l1 JOIN layoffs_staging2 l2 ON l1.company = l2.company
WHERE (l1.industry IS NULL OR l1.industry = '') AND l2.industry IS NOT NULL; -- USING A SELF JOIN TO POPULATE MISSING INDUSTRY VALUES
-- BASED ON OTHER ROWS FROM THE SAME COMPANY

UPDATE layoffs_staging2 l1 JOIN layoffs_staging2 l2 ON l1.company = l2.company SET l1.industry = l2.industry WHERE (l1.industry IS NULL OR l1.industry = '') AND l2.industry IS NOT NULL;

SELECT * FROM layoffs_staging2 WHERE company = "Bally's Interactive"; -- THE ONLY ROW THAT DOES NOT HAVE AN INDUSTRY

-- REMOVING ROWS WHERE BOTH LAYOFF INDICATORS ARE MISSING

DELETE FROM layoffs_staging2 WHERE total_laid_off IS NULL AND percentage_laid_off IS NULL;
SELECT * FROM layoffs_staging2 WHERE total_laid_off IS NULL AND percentage_laid_off IS NULL; 

-- REMOVING THE HELPER COLUMN USED TO IDENTIFY DUPLICATE RECORDS
ALTER TABLE layoffs_staging2
DROP COLUMN row_numb;

