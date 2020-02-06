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
	teams (franchid,yearid, w, wswin,)
	teamsfranchises (franchid,franchname)

    DIMENSIONS ::
    team name

    FACTS ::
     wins, pct

    FILTERS ::
        * ...

    DESCRIPTION ::
        ...

    ANSWER ::
    From 1976-2016 the most wins for a team that did not win the World Series was 116.
	From 1976-2016 the fewest wins for a team that did win the World Series was 63 in 1981,
	a seaon shortened by the player's strike.
	If we exclude 1981, the fewest wins for a team that won the World Series is 83.
*/

DROP TABLE IF EXISTS seasons_max_w_wsr;

CREATE TEMP TABLE seasons_max_w_wsr AS
	SELECT 
	 	t.yearid, 
		t.teamid,
		t.w,
		MAX(t.w) AS max_wins, 
		t.wswin
	 FROM teams AS t
	 GROUP BY t.yearid, t.teamid, t.w, t.wswin
	 HAVING t.w = MAX(t.w) AND yearid BETWEEN '1976' AND '2016'
	 ORDER BY t.yearid;
SELECT *
FROM seasons_max_w_wsr;
	 
	 
/*SELECT
	 (SELECT
		MAX(t.w) AS max_gw_wsl
	 	FROM teams as t
	 	WHERE t.wswin = 'N' AND yearid >= '1976' AND yearid <= '2016') AS max_gw_wsl,--116 
	 (SELECT
		MIN(t.w) AS min_gw_wsw
	 	FROM teams as t
	 	WHERE t.wswin = 'Y' AND yearid >= '1976' AND yearid <= '2016' AND yearid != '1981') AS min_gw_wsl,--83
FROM teams AS t*/

/*JOIN teamsfranchises AS tf
ON t.franchid = tf.franchid
WHERE yearid >= '1976' AND yearid <= '2016';*/

/*SELECT 
	t.yearid, 
	tf.franchname, 
	t.w,
	t.g,
	t.wswin
FROM teams as t
JOIN teamsfranchises AS tf
ON t.franchid = tf.franchid
WHERE yearid >= '1976' AND yearid <= '2016' AND t.wswin = 'Y'; */-- lowest wins 1981 LAD 63 wins, next lowest 2006 StL 
