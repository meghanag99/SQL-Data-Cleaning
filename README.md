# Global Layoffs Data Analysis (SQL)

## Project Background

Over the past few years, many companies across industries have announced large workforce reductions. Economic uncertainty, post-pandemic corrections, shifts in consumer demand, and changes in technology investment cycles have contributed to widespread layoffs.

This project analyzes a global layoffs dataset to understand **which companies, industries, and regions were most affected**, and how layoffs evolved over time.

Using SQL, the project performs **data cleaning and exploratory data analysis (EDA)** to identify patterns in layoffs across companies, industries, geographic regions, funding stages, and time.

The goal of this analysis is to transform raw layoff data into meaningful insights that help understand workforce reduction trends in the global technology and startup ecosystem.

---

# Executive Summary

The dataset contains **383,659 layoffs across 1,628 companies** between **March 2020 and March 2023**.

Key findings include:

- **2022 recorded the highest layoffs**, with over **160,000 layoffs and the highest number of layoff events (1,030)**.
- **The United States accounted for the majority of layoffs**, representing more than half of all layoffs recorded.
- **Major technology companies such as Amazon, Google, and Meta experienced some of the largest layoffs**.
- Layoffs were concentrated in **technology hubs such as the San Francisco Bay Area, Seattle, and New York City**.
- Companies at the **Post-IPO stage accounted for the largest share of layoffs**, showing that workforce reductions affected mature companies as well as startups.
- High levels of funding did not necessarily protect companies from layoffs.

---

# Analytical Approach

## Dataset

The dataset includes global layoff events across companies and industries.

Key fields include:

| Column | Description |
|------|-------------|
| company | Name of the company |
| location | City where layoffs occurred |
| industry | Industry of the company |
| total_laid_off | Number of employees laid off |
| percentage_laid_off | Percentage of workforce laid off |
| date | Date of the layoff event |
| stage | Company funding stage |
| country | Country where layoffs occurred |
| funds_raised_millions | Total funding raised by the company |

---

## Data Cleaning

## SQL Skills Used
- CTEs
- Window Functions
- Data Standardization
- NULL Handling
- Data Transformation

Before performing analysis, several data cleaning steps were performed using SQL:

- Created staging tables to avoid modifying the raw dataset.
- Removed duplicate records using **ROW_NUMBER()**.
- Standardized text values for **company names, industries, and countries**.
- Converted the `date` column into a proper **DATE data type**.
- Replaced blank values with **NULL** where appropriate.
- Filled missing industry values using **self joins on company names**.
- Removed rows where both **total_laid_off and percentage_laid_off were missing**.

These steps ensured the dataset was clean and consistent before performing analysis.

---

## Exploratory Data Analysis (EDA)

SQL queries were used to explore key business questions, including:

- Total layoffs and number of companies affected
- Companies with the largest layoffs
- Industries and countries most affected
- Layoff distribution across locations
- Layoffs by funding stage
- Layoffs by funding amount
- Yearly and monthly layoff trends
- Running totals and year-over-year changes in layoffs

Advanced SQL techniques such as **Common Table Expressions (CTEs)** and **window functions (LAG, SUM OVER)** were used to analyze time trends.

---

# Key Portfolio Findings and Insights

### Overall Layoff Volume
The dataset records **383,659 layoffs across 1,628 companies**, highlighting the scale of workforce reductions across the global startup and technology ecosystem.

---

### Largest Layoff Announcements

Some of the largest single layoff announcements came from major technology companies:

| Company | Largest Layoff |
|------|------|
| Google | 12,000 |
| Meta | 11,000 |
| Microsoft | 10,000 |
| Amazon | 10,000 |
| Ericsson | 8,500 |

These layoffs demonstrate that even highly established technology companies were significantly impacted.

---

### Companies with the Highest Total Layoffs

| Company | Total Layoffs |
|------|------|
| Amazon | 18,150 |
| Google | 12,000 |
| Meta | 11,000 |
| Salesforce | 10,090 |
| Microsoft | 10,000 |

Large technology firms contributed significantly to overall layoffs.

---

### Industries Most Impacted

Industries with the highest layoffs include:

| Industry | Total Layoffs |
|------|------|
| Consumer | 45,182 |
| Retail | 43,613 |
| Transportation | 33,748 |
| Finance | 28,344 |

These industries experienced significant disruption due to economic uncertainty and changing market demand.

---

### Geographic Distribution

The countries with the highest layoffs were:

| Country | Layoffs |
|------|------|
| United States | 256,559 |
| India | 35,993 |
| Netherlands | 17,220 |
| Sweden | 11,264 |
| Brazil | 10,391 |

The United States accounted for the **majority of layoffs**, reflecting its large technology and startup ecosystem.

---

### Layoffs Concentrated in Major Tech Hubs

| Location | Total Layoffs |
|------|------|
| SF Bay Area | 125,631 |
| Seattle | 34,743 |
| New York City | 29,364 |
| Bengaluru | 21,787 |
| Amsterdam | 17,140 |

This indicates layoffs were heavily concentrated in **global technology centers**.

---

### Layoffs Over Time

| Year | Total Layoffs |
|------|------|
| 2020 | 80,998 |
| 2021 | 15,823 |
| 2022 | 160,661 |
| 2023* | 125,677 |

*2023 data includes layoffs recorded only until March.*

Layoffs surged significantly in **2022**, which also recorded the highest number of layoff events.

Although 2023 appears lower than 2022, the dataset only includes the **first three months of the year**, suggesting layoffs continued at a high pace.

---

### Layoffs by Company Stage

| Stage | Total Layoffs |
|------|------|
| Post-IPO | 204,132 |
| Acquired | 27,576 |
| Series C | 20,017 |
| Series D | 19,225 |

Companies that had already gone public accounted for the largest share of layoffs.

---

### Funding vs Layoffs

Several highly funded companies still conducted layoffs:

| Company | Funding Raised | Layoffs |
|------|------|------|
| Netflix | $121.9B | 505 |
| Meta | $26B | 11,000 |
| Uber | $24.7B | 7,585 |
| Twitter | $12.9B | 3,940 |

This suggests that **large funding levels do not necessarily prevent layoffs**, particularly during broader economic downturns.

---

# Economic Context: Impact of COVID-19 and Strategic Recommendations

The time period covered in this dataset (March 2020 – March 2023) coincides with major global economic disruptions caused by the COVID-19 pandemic and its aftermath.

In early 2020, many companies experienced sudden declines in revenue due to lockdowns, reduced consumer demand, and supply chain disruptions. As a result, companies across industries implemented layoffs to reduce operational costs.

Following the pandemic, the technology sector experienced a period of rapid hiring during 2020–2021 as demand for digital services increased. However, as economic conditions stabilized and growth slowed in 2022, many companies began restructuring their workforce, resulting in a significant wave of layoffs.

The sharp increase in layoffs during 2022 reflects a broader correction following aggressive hiring during the pandemic years.

Therefore, the layoff trends observed in this dataset are strongly influenced by the economic conditions created by COVID-19 and the subsequent market adjustments.

## Strategic Recommendations

Based on the patterns observed in the dataset, a few practical takeaways emerge for companies and decision-makers.

### 1. Avoid Over-Hiring During Rapid Growth Periods
Many companies expanded aggressively during the COVID-19 digital boom in 2020–2021. When growth slowed, this led to large workforce reductions. Companies should align hiring with long-term business needs rather than short-term demand spikes to reduce the risk of large layoffs later.

### 2. Focus on Sustainable Business Growth
The analysis shows that even highly funded companies experienced large layoffs. This suggests that funding alone does not guarantee stability. Companies should prioritize sustainable revenue models and operational efficiency rather than relying heavily on external funding.

### 3. Improve Workforce Planning During Economic Uncertainty
Layoffs tend to increase during major economic disruptions such as the COVID-19 pandemic and market corrections that followed. Organizations can reduce the impact of future layoffs by improving workforce planning, monitoring economic signals, and building more flexible hiring strategies.

---

# Assumptions & Limitations

Several limitations should be considered when interpreting the results:

- The dataset only includes **layoffs reported between March 2020 and March 2023**.
- **2023 data is incomplete**, covering only the first three months of the year.
- Some records contain **missing or unknown funding stage information**.
- Layoff numbers represent **reported events and may not capture every workforce reduction globally**.

Despite these limitations, the dataset provides valuable insights into global layoff trends.

# Project Purpose
The goal of this project is to demonstrate SQL data cleaning skills that are commonly used in data analyst workflows.

# Acknowledgement
This project was done with the help of the SQL course from Alex The Analyst. I followed the workflow to practice data cleaning techniques and EDA. 
