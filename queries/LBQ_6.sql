/*
    QUESTION :: 6
	Find the player who had the most success stealing bases in 2016, 
		where success is measured as the percentage of stolen base attempts which are successful. 
		(A stolen base attempt results either in a stolen base or being caught stealing.) 
	Consider only players who attempted at least 20 stolen bases.
	
    SOURCES ::
	people(playerid,namefirst,namelast), batting (playerid,yearid,sb,cs)

    DIMENSIONS ::
    % successfully stolen bases with min 20 attempts

    FACTS ::
    Payer name

    FILTERS ::
    DISTINCT, HAVING 

    DESCRIPTION ::
    Select player names and id from people table and join on id to batting table.
	Select stolen bases, caught stealing and year from batting table.
	Calculate 

    ANSWER ::
    Chris Owings 91% successful with at least 20 steal attempts

*/

/*SELECT SUM(sb)
FROM batting --302195*/

/*SELECT SUM(sb)
FROM batting
WHERE yearid = '2016'*/ --2537 use for checking answer script


SELECT 
	DISTINCT CONCAT(p.namefirst,' ', p.namelast) AS full_name,
	SUM(b.sb) AS stolen_bases, --used this to eyeball if percentage correct 
	SUM(b.sb + b.cs) AS steal_attempts,--used this to if eyeball percentage correct
	100* (SUM(b.sb))/(SUM(b.sb + b.cs)) AS pct_success --calculates percentage successfull
FROM people AS p
JOIN batting AS b
ON p.playerid = b.playerid 
GROUP BY full_name, yearid
HAVING yearid= '2016' AND SUM(b.sb + b.cs) >= 20
ORDER BY pct_success DESC
LIMIT 1;


/*DROP TABLE IF EXISTS sb;

CREATE TEMP TABLE sb AS
SELECT 
	DISTINCT CONCAT(p.namefirst,' ', p.namelast) AS full_name,
	SUM(b.sb) AS stolen_bases, --used this to eyeball if percentage correct 
	SUM(b.sb + b.cs) AS steal_attempts,--used this to if eyeball percentage correct
	100* (SUM(b.sb))/(SUM(b.sb + b.cs)) AS pct_success --calculates percentage successfull
FROM people AS p
JOIN batting AS b
ON p.playerid = b.playerid
GROUP BY full_name, yearid
HAVING yearid = '2016' and SUM(b.sb + b.cs) >0 --neccessary to avoid error code abot dividing by zero
ORDER BY pct_success DESC;

SELECT SUM (stolen_bases)
FROM sb; --2537 checks*/
