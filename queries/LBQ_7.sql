/*
    QUESTION :: 7
	From 1970 – 2016, what is the largest number of wins for a team that did not win the world series?
	What is the smallest number of wins for a team that did win the world series? 
	Doing this will probably result in an unusually small number of wins for a world series champion 
		– determine why this is the case. 
	Then redo your query, excluding the problem year. 
	How often from 1970 – 2016 was it the case that a team with the most wins also won the world series? 
	What percentage of the time?
	
    SOURCES ::
	teams (yearid, w, wswins)

    DIMENSIONS ::
    world series winner/ most wins and world series win  
	from 1970
    FACTS ::
     wins/count/pct

    FILTERS ::
    MAX, MIN, CASE, SUM, COUNT

    DESCRIPTION ::
     Created temporary table

    ANSWER ::
    From 1970-2016 the most wins for a team that did not win the World Series was 116.
	From 1970-2016 the fewest wins for a team that did win the World Series was 63 in 1981,
	a seaon shortened by the player's strike.
	If we exclude 1981, the fewest wins for a team that won the World Series is 83.
	From 1970-2016 the team with most won the World Series 12 times, or 26% of the time. 
	This excludes the 1981 strike shortened season and the 1994 season which did not have a World Series.
*/

/*SELECT --Answer part 1
	yearid,
	teamid,
	MAX(w) AS most_wins,
	wswin
FROM teams
GROUP BY  yearid, teamid, w, wswin
HAVING yearid >= '1970' AND yearid <= '2016' AND wswin = 'N'
ORDER BY most_wins DESC
LIMIT 1;*/ --SEA 116 wins, lost WS

/*SELECT --Answer part 2
	yearid,
	teamid,
	MIN(w) AS fewest_wins,
	wswin
FROM teams
GROUP BY  yearid, teamid, w, wswin
HAVING yearid >= '1970' AND yearid <= '2016' AND yearid != '1981' AND wswin = 'Y'
ORDER BY fewest_wins
LIMIT 1;*/ -- lowest wins 1981 LAN 63 wins, next lowest 2006 SLN with 83

--Answer Parts 1,2, and 3

DROP TABLE IF EXISTS wsr_mw;

CREATE TEMP TABLE wsr_mw AS
WITH max_w AS(
		SELECT 
 			yearid,
			MAX(w) AS most_wins
			--wswin
		FROM teams
		GROUP BY yearid, wswin 
		HAVING yearid >='1970' AND yearid <= '2016' AND yearid != '1994' AND yearid != '1981' AND wswin = 'Y'
		ORDER BY yearid),
	max_l AS(
		SELECT 
 			yearid,
			MAX(w) AS most_wins
			--wswin
		FROM teams
		GROUP BY yearid, wswin 
		HAVING yearid >='1970' AND yearid <= '2016' AND yearid != '1994' AND yearid != '1981' AND wswin = 'N'
		ORDER BY yearid) 
SELECT	
	t.yearid,
	MAX(w) AS wins,
	(CASE 
		WHEN max_w.most_wins >= max_l.most_wins THEN 1
		WHEN max_w.most_wins < max_l.most_wins THEN 0
		END) AS wsr
FROM teams AS t
JOIN max_w
ON t.yearid = max_w.yearid
JOIN max_l
ON max_w.yearid = max_l.yearid
GROUP BY t.yearid, wsr
ORDER BY yearid;

/*SELECT *
FROM wsr_mw;*/ --check output

SELECT
(SELECT
	MAX(wins)  
	FROM wsr_mw
	WHERE wsr =0) AS mw_wsl,
(SELECT 
	MIN(w) AS fewest_wins
	FROM teams
	GROUP BY yearid, wswin
	HAVING yearid >= '1970' AND yearid <= '2016' AND yearid != '1981' AND wswin = 'Y'
	ORDER BY fewest_wins
	LIMIT 1) AS lw_wsw,
SUM(wsr) AS mw_wsw_count,
100 * SUM(wsr)/COUNT(wsr) AS pct_mw_wsw_
FROM wsr_mw;





		 