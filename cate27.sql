
-- CATE27 PORTFOLIO: SQL PROJECT --

USE CATE27;

SELECT * FROM JUNERPD;

-- TERRITORY OVERVIEW: HIGH-LEVEL

-- How is your RPD/SPD compared to previous years?
SELECT 
	Year,
	AVG(RPD) AS average_rpd,
	AVG(SPD) AS average_spd
FROM yearlyresults
GROUP BY YEAR


-- Who are my current top customers? 
SELECT 
	SITE_NAME,
	YTD
FROM JUNERPD
ORDER BY YTD DESC;


-- CURRENT MONTH RESULTS: IN-DEPTH LEVEL
-- ***JOINS***

-- How is your RPD, SPD and how many FTBs do you have this month?

SELECT * FROM yearlyresults;
SELECT * FROM monthlyinputs;

SELECT 
	yearlyresults.month AS Month,
	yearlyresults.RPD AS RPD,
	yearlyresults.SPD AS SPD,
	monthlyinputs.FTB_count AS FTB
FROM yearlyresults
	INNER JOIN monthlyinputs
		ON yearlyresults.month = monthlyinputs.month
		AND yearlyresults.year = 2022
		AND yearlyresults.month = 'JUN';
-- ANS: Month, RPD, SPD, FTB
--		Jun, 2939.6, 10.5, 3


-- **COMPARING CUSTOMERS JUNE RESULTS***
-- **SUBQUERIES**
-- What was the average RPD in June and how did your customer compared to it? 

SELECT
	AVG(JUN2022)
FROM JUNERPD
WHERE JUN2022 > 0

-- ANS: The average RPD is $68.36

-- Table: Adding the average rpd to each customer as a baseline comparison
SELECT 
	SITE_NAME,
	JUN2022,
	(SELECT
		AVG(JUN2022)
	FROM JUNERPD
	WHERE JUN2022 > 0) AS AVG_RPD
FROM JUNERPD

-- How many customers produced over the average? 
SELECT 
	COUNT(*)
FROM JUNERPD
WHERE JUN2022 > (SELECT
					AVG(JUN2022)
				FROM JUNERPD
				WHERE JUN2022 > 0)
-- ANS: There were 9 customers. 

	
