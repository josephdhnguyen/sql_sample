-- DATA EXPLORATION: SPORTS ANALYTICS SQL PROJECT - JORDAN

USE new_schema;

SELECT * FROM jordan_career
	ORDER BY date;

-- How many games has Jordan played?
SELECT
	COUNT(*) 
FROM jordan_career;
-- Michael Jordan has played 1072 regular season games.

-- ***PART A: THE ERA OF 3-POINTERS***
-- 3 POINT % (at least 5 attempts) IN CORRELATION TO WINS
-- (WHERE, LIKE)

-- 1. What is his win percentage in his career? 
SELECT 
	COUNT(result)
FROM jordan_career
WHERE result LIKE "W%";
-- Jordan has won 706 regular season games in his career out of his 1072 games played. That is a win percentage of 65.9%.

-- 2. How many times did he shot at least 5 3-pointers?
SELECT 
	COUNT(*)
FROM jordan_career
WHERE threeatt >= 5;
-- Jordan has shot at least 5 3-pointers a game 84 times in his career. 

-- 3. How many of those games were wins? 
SELECT 
    date,
    opp,
	three AS three_pt_made,
    threeatt AS three_pt_attempt,
    (three/threeatt)*100 AS three_pt_percentage,
    result
FROM jordan_career
WHERE 
	threeatt >= 5 AND
    result LIKE "W%";
-- There are 62 times where Jordan shot at least 5 3-pointers in a game and received a win. 
-- Therefore, he is 62-22. That is a 73.8% win rate. 

-- CONCLUSION: It is more likely that Jordan would win a game if he shot more than 5 3-pointers a game.

-- ***PART B: THE ERA OF 3-POINTERS(PLAYOFFS INCLUDED)***
-- (UNION, subqueries)

-- 1. What if we include his playoffs performance? Let's see a side-by-side comparison between career and playoffs.

SELECT
	COUNT(*)
FROM jordan_career
WHERE
	threeatt >= 5

UNION

SELECT
	COUNT(*)
FROM jordan_playoffs
WHERE
	threeatt >= 5;

-- Regular season: 84, Playoffs: 27

-- 2. Final table: Side-by-side comparison - Type, shot 5 3s, shot 5 3s + W, win-rate.
SELECT 
	'regular' AS type,
    (SELECT COUNT(*) FROM jordan_career WHERE threeatt >= 5) AS five,
    COUNT(*) AS five_W,
    COUNT(*)/(SELECT COUNT(*) FROM jordan_career WHERE threeatt >= 5)*100 AS win_rate
FROM jordan_career
WHERE 
	threeatt >= 5 AND
	result LIKE "W%"

UNION

SELECT 
	'playoffs' AS type,
    (SELECT COUNT(*) FROM jordan_playoffs WHERE threeatt >= 5) AS five,
	COUNT(*) AS five_W,
    COUNT(*)/(SELECT COUNT(*) FROM jordan_playoffs WHERE threeatt >= 5)*100 AS win_rate
FROM jordan_playoffs 
WHERE 
	threeatt >= 5 AND
	result LIKE "W%";
    
-- regular, 84, 62, 73.8% 
-- playoffs, 27, 14, 51.9%

-- CONCLUSION: 3-pointers isn't heavily attributable to win-rate in the playoffs as regular season does.

-- ***PART C. FUSING JORDAN'S CAREER WITH LEBRON: LEBRON JORDAN ***
-- (JOINS)

-- 1. If we were to add's Lebron's career to Jordan's career, will that bring down the numbers?

-- Total games played by Lebron Jordan he shot 5 3-point attempts
SELECT 
	jordan_career.age,
    jordan_career.date AS jordans_date,
    jordan_career.opp AS jordans_opp,
    jordan_career.result AS jordans_result,
    jordan_career.threeatt AS jordan_threeatt,
    lebron_career.date AS lebrons_date,
    lebron_career.opp AS lebrons_opp,
    lebron_career.result AS lebrons_result,
    lebron_career.threeatt AS lebron_threeatt
FROM jordan_career
	INNER JOIN lebron_career
		ON jordan_career.age = lebron_career.age
        AND jordan_career.threeatt >= 5
        AND lebron_career.threeatt >= 5;
        
-- Result: 14 times Lebron Jordan shot 5 3-point attempts. 

-- 2. How many of those times are wins? 
SELECT
	jordan_career.age,
    jordan_career.date AS jordans_date,
    jordan_career.opp AS jordans_opp,
    jordan_career.result AS jordans_result,
	jordan_career.threeatt AS jordan_threeatt,
    lebron_career.date AS lebrons_date,
    lebron_career.opp AS lebrons_opp,
    lebron_career.result AS lebrons_result,
	lebron_career.threeatt AS lebron_threeatt
FROM jordan_career
	INNER JOIN lebron_career
		ON jordan_career.age = lebron_career.age
		AND jordan_career.threeatt >= 5
        AND lebron_career.threeatt >= 5
        AND jordan_career.result LIKE 'W%'
        AND lebron_career.result LIKE 'W%';

-- Result: Only 5 times Lebron Jordan shot 5 3-point attempts and have won. Win rate = 35.7%
-- Therefore: We can conclude that if you add LeBron's career stats to Jordan's career stats, it would lower the win rate. 


	
	
