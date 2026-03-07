-- EXPLORATORY DATA ANALYSIS

SELECT * FROM layoffs_staging2;	

-- 1. How many companies appear in the dataset?
SELECT COUNT(DISTINCT(company)) AS number_of_distinct_companies 
FROM layoffs_staging2;

-- 2. What is the total number of layoffs recorded in the dataset?
SELECT SUM(total_laid_off) AS total_laidoffs FROM layoffs_staging2;

-- 3. What is the earliest and latest layoff date?
SELECT min(`date`) AS start_date,  max(`date`) AS end_date 
FROM layoffs_staging2 WHERE total_laid_off IS NOT NULL;

-- 4. Which companies had the largest single layoff event and by company?
SELECT max(total_laid_off) AS max_laidoff_event FROM layoffs_staging2;
SELECT company, max(total_laid_off) AS max_laid_off 
FROM  layoffs_staging2 GROUP BY company ORDER BY max_laid_off DESC LIMIT 10;

-- 5. Which industries appear in the dataset?
SELECT DISTINCT(industry) FROM layoffs_staging2;

-- 6. How many countries are represented in the dataset?
SELECT COUNT(DISTINCT(country)) FROM layoffs_staging2;

-- 7. Which companies laid off the most employees overall?
SELECT company, SUM(total_laid_off) AS sum_laid_off
FROM  layoffs_staging2 GROUP BY company ORDER BY sum_laid_off DESC LIMIT 5;

-- 8. Which companies had 100% layoffs?
SELECT company, percentage_laid_off 
FROM layoffs_staging2 WHERE percentage_laid_off = 1;

-- 9 Which companies had multiple layoff rounds
SELECT company, count(company) AS total_company_count
FROM layoffs_staging2 GROUP BY company HAVING total_company_count > 1 
ORDER BY total_company_count DESC; 

-- 1O Which industries had the most layoffs overall?
SELECT industry, sum(total_laid_off) AS total_laid_industry 
FROM layoffs_staging2 GROUP BY industry ORDER BY total_laid_industry DESC LIMIT 5;

-- 11. Which industries had the highest average layoffs per event?
SELECT industry, avg(total_laid_off) AS avg_laidoff 
FROM layoffs_staging2 GROUP BY industry ORDER BY avg_laidoff DESC LIMIT 5;

-- 12. Which industries had the most companies affected by layoffs?
SELECT industry, count(DISTINCT(company)) AS company_count 
FROM layoffs_staging2 GROUP BY industry ORDER BY company_count DESC LIMIT 5; 

-- 13. Which countries had the highest total layoffs?
SELECT country, sum(total_laid_off) AS total_laidoff_country 
FROM layoffs_staging2 GROUP BY country ORDER BY total_laidoff_country DESC LIMIT 5;

-- 14. Which locations had the highest layoffs?
SELECT location, sum(total_laid_off) AS total_laidoff_loaction 
FROM layoffs_staging2 GROUP BY location ORDER BY total_laidoff_loaction DESC LIMIT 5;

-- 15. Which country had the most layoff events?
SELECT country, count(company) AS layoff_events 
FROM layoffs_staging2 GROUP BY country ORDER BY layoff_events DESC LIMIT 5;

-- 16. How many layoffs occurred each year?
SELECT YEAR(`date`) AS `year`, sum(total_laid_off) AS laidoff_by_year
FROM layoffs_staging2 GROUP BY `year` ORDER BY laidoff_by_year DESC;

-- 17. How many layoffs occurred each month?
SELECT MONTH(`date`) AS `month`, sum(total_laid_off) AS laidoff_by_month 
FROM layoffs_staging2 GROUP BY `month` ORDER BY laidoff_by_month DESC; 

-- 18. Which month had the highest layoffs?
SELECT MONTH(`date`) AS `month`, sum(total_laid_off) AS laidoff_by_month 
FROM layoffs_staging2 GROUP BY `month` ORDER BY laidoff_by_month DESC LIMIT 1;

-- 19. What is the trend of layoffs over time?
#SELECT `date`, sum(total_laid_off) AS laidoff_mon_year FROM layoffs_staging2 GROUP BY YEAR(`date`) AND month(`date`) ORDER BY YEAR(`date`), month(`date`); 

-- 20. Which funding stage had the highest layoffs?
SELECT stage, sum(total_laid_off) AS laidoff_stage FROM layoffs_staging2 GROUP BY stage ORDER BY laidoff_stage DESC; 

-- 21 Which companies raised the most funding but still had layoffs?
SELECT company, MAX(funds_raised_millions) AS funds_raised_millions, sum(total_laid_off) 
FROM layoffs_staging2 WHERE total_laid_off IS NOT NULL GROUP BY company ORDER BY funds_raised_millions DESC LIMIT 10; 

-- 22. What is the average funding amount of companies that laid off employees?
SELECT company, avg(funds_raised_millions)AS avg_funds_millions, sum(total_laid_off) 
FROM layoffs_staging2 WHERE total_laid_off IS NOT NULL GROUP BY company ORDER BY avg_funds_millions DESC;

-- 23. Do companies with higher funding tend to lay off more employees?
SELECT 
	CASE
		WHEN funds_raised_millions BETWEEN 0 AND 100 THEN '0-100M'
        WHEN funds_raised_millions BETWEEN 101 AND 500 THEN '101-500M'
        WHEN funds_raised_millions BETWEEN 501 AND 1000 THEN '501-1000M'
        WHEN funds_raised_millions BETWEEN 1001 AND 5000 THEN '1001-5000M'
        WHEN funds_raised_millions BETWEEN 5001 AND 10000 THEN '5001-10000M'
        ELSE '10001M+'
	END AS funding_range,
    sum(total_laid_off) AS sum_laid_off
FROM layoffs_staging2
WHERE total_laid_off IS NOT NULL AND funds_raised_millions IS NOT NULL
GROUP BY funding_range;

with sum_cte as (
SELECT company, sum(total_laid_off) AS sum1 FROM layoffs_staging2 WHERE total_laid_off IS NOT NULL AND funds_raised_millions IS NOT NULL group by company having max(funds_raised_millions ) > 10000)
SELECT sum(sum1) FROM sum_cte;

-- Companies with different fundings. 
SELECT company, COUNT(DISTINCT funds_raised_millions) AS funding_values
FROM layoffs_staging2
WHERE funds_raised_millions IS NOT NULL
GROUP BY company
HAVING COUNT(DISTINCT funds_raised_millions) > 1;

-- 24. Which industry had the largest single layoff event?
SELECT * FROM layoffs_staging2 ORDER BY total_laid_off DESC LIMIT 1;

-- 25. Which companies had layoffs across multiple years?
SELECT COUNT(DISTINCT(YEAR(`date`))) AS count_year, company FROM layoffs_staging2 
GROUP BY company HAVING count_year > 1 ORDER BY count_year DESC;

-- 26. Which year had the most layoff events and the most total layoffs?
SELECT YEAR(`date`) AS year1, count(*) as events_year 
FROM layoffs_staging2 WHERE YEAR(`date`) IS NOT NULL GROUP BY year1 
ORDER BY events_year desc limit 1;

SELECT YEAR(`date`) AS year1, sum(total_laid_off) AS Tot_laid 
FROM layoffs_staging2 WHERE YEAR(`date`) IS NOT NULL GROUP BY year1 
ORDER BY Tot_laid DESC;

-- 27. What is the running total of layoffs over time?
WITH rolling_total AS
(
SELECT SUBSTRING(`date`, 1,7) AS `month`, sum(total_laid_off) AS total_off 
FROM layoffs_staging2
WHERE SUBSTRING(`date`, 1,7) IS NOT NULL
GROUP BY `month`
)
SELECT `month`,total_off, sum(total_off) OVER(ORDER BY `month`) AS rolling_tot
FROM rolling_total;

-- 28. How did layoffs change year-over-year?
WITH year_total_laid_off AS 
(
SELECT YEAR(`date`) AS year1, sum(total_laid_off) AS sum_total_laid FROM layoffs_staging2 GROUP BY year1)
SELECT year1, sum_total_laid,  LAG(sum_total_laid) OVER (ORDER BY year1) AS previous_year,
 sum_total_laid - LAG(sum_total_laid) OVER (ORDER BY year1) AS yoy_change
FROM year_total_laid_off WHERE year1 IS NOT NULL;
