-- SPORTS ANALYTICS SQL PROJECT - JORDAN

USE new_schema;

SELECT * FROM jordan_career;

-- COUNT: NUMBER OF GAMES 
-- Michael Jordan has played 1072 regular season games.

SELECT
	COUNT(*) 
FROM jordan_career;

-- MAX: CAREER HIGHS: 69 points

SELECT 
	MAX(pts)
FROM jordan_career;

-- COUNT: NUMBER OF 50 points game in the regular season 

-- JORDAN - 31
SELECT 
	COUNT(pts) AS number_of_50_pts_game
FROM jordan_career
WHERE pts >=50;

-- WHERE & AND: TRIPLE DOUBLE AMOUNTS 

-- JORDAN - 28
SELECT 
	COUNT(pts) AS number_of_triple_doubles
FROM jordan_career
WHERE pts >= 10
AND ast >= 10
AND trb >= 10;

-- *** 3 POINT % (at least 5 attempts) IN CORRELATION TO WINS ***
-- (WHERE, LIKE and other criteria)

-- Jordan has won 706 regular season games in his career out of his 1072 games played. That is a win percentage of 65.9%.
SELECT 
	COUNT(*)
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
	COUNT(*)
FROM jordan_career
WHERE threeatt >= 5 AND result LIKE "W%";

-- Breakdown of his shot attempts in Jordan when shooting 5+ 3-pointers.
SELECT 
    date,
    opp,
	three AS three_pt_made,
    threeatt AS three_pt_attempt,
    threep AS three_pt_percentage,
    result
FROM jordan_career
WHERE 
	threeatt >= 5 AND
    result LIKE "W%";
    
-- COUNT & CASE STATEMENTS: 

-- Jordan games played against the Detroit Bad Boys (64), Larry Bird's Celtics (56) and Magic Johnson's Lakers (26)
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


   

    





