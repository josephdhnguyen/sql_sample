-- SPORTS ANALYTICS SQL PROJECT - JORDAN

USE new_schema;

SELECT * FROM jordan_career
	ORDER BY 2;
SELECT * FROM jordan_playoffs
	ORDER BY 2;

-- Michael Jordan has played 1072 regular season games.
-- (COUNT)

SELECT
	COUNT(*) 
FROM jordan_career;

-- *** 3 POINT % (at least 5 attempts) IN CORRELATION TO WINS ***
-- (WHERE, LIKE and other criteria)
-- MAX: Most 3-pointers made in a game. ANS: 7-pointers in the regular-season

SELECT 
	opp,
    date,
	MAX(three)
FROM jordan_career
	ORDER BY MAX(three) DESC;

-- Jordan has won 706 regular season games in his career out of his 1072 games played. That is a win percentage of 65.9%.
SELECT 
	COUNT(result)
FROM jordan_career
WHERE result LIKE "W%";

-- Jordan has shot at least 5 3-pointers 84 times in his career. 
SELECT 
	COUNT(*)
FROM jordan_career
WHERE threeatt >= 5;

-- There are 62 times where Jordan shot at least 5 3-pointers in a game and received a win. 
-- Therefore, he is 62-22. That is a 73.8% win rate. 
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
 
-- Jordan games played against the Detroit Bad Boys (64), Larry Bird's Celtics (56) and Magic Johnson's Lakers (26)
-- (COUNT & CASE)
SELECT
    COUNT(CASE WHEN opp = "DET" THEN result ELSE NULL END) AS detroit_games,
	COUNT(CASE WHEN opp = "BOS" THEN result ELSE NULL END) AS boston_games,
	COUNT(CASE WHEN opp = "LAL" THEN result ELSE NULL END) AS lakers_games
FROM jordan_career;

-- Record against each opponent: DETROIT (33-31), BOSTON (34-22), LAKERS (12-14)
SELECT
    COUNT(CASE WHEN opp = "DET" AND result LIKE "W%" THEN result ELSE NULL END) AS detroit_games,
	COUNT(CASE WHEN opp = "BOS" AND result LIKE "W%" THEN result ELSE NULL END) AS boston_games,
	COUNT(CASE WHEN opp = "LAL" AND result LIKE "W%" THEN result ELSE NULL END) AS lakers_games
FROM jordan_career;

-- JORDAN'S PERFORMANCE: PLAYOFFS INCLUDED
-- (UNIONS)
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
	result LIKE "W%"

UNION

SELECT 
	date,
    opp,
	three AS three_pt_made,
    threeatt AS three_pt_attempt,
    (three/threeatt)*100 AS three_pt_percentage,
    result
FROM jordan_playoffs 
WHERE 
	threeatt >= 5 AND
	result LIKE "W%";

-- JORDAN'S WIN-RATE VS LEBRON AT THE SAME AGE
-- (JOINS)

-- Total games played by both players at the same age
SELECT 
	jordan_career.age,
    jordan_career.date AS jordans_date,
    jordan_career.opp AS jordans_opp,
    jordan_career.result AS jordans_result,
    lebron_career.date AS lebrons_date,
    lebron_career.opp AS lebrons_opp,
    lebron_career.result AS lebrons_result
FROM jordan_career
	INNER JOIN lebron_career
		ON jordan_career.age = lebron_career.age;

-- Wins by both players at the same age
SELECT
	jordan_career.age,
    jordan_career.date AS jordans_date,
    jordan_career.opp AS jordans_opp,
    jordan_career.result AS jordans_result,
    lebron_career.date AS lebrons_date,
    lebron_career.opp AS lebrons_opp,
    lebron_career.result AS lebrons_result
FROM jordan_career
	INNER JOIN lebron_career
		ON jordan_career.age = lebron_career.age
        AND jordan_career.result LIKE 'W%'
        AND lebron_career.result LIKE 'W%';
	
-- Jordan's points per game in his final year 
-- (SUBQUERIES)

SELECT
	game, 
    date,
    age,
    opp,
    pts,
    (SELECT AVG(pts) FROM jordan_career) AS career_avg
FROM jordan_career
WHERE date LIKE '2003%';

SELECT
	game,
    date,
    age,
    opp,
    pts
FROM jordan_career
WHERE pts >= (SELECT AVG(pts) FROM jordan_career AS career_avg)
AND date LIKE '2003%';


    




