/*
    QUESTION :: 9
	Which managers have won the TSN Manager of the Year award 
	in both the National League (NL) and the American League (AL)? 
	Give their full name and the teams that they were managing when they won the award.
    
	SOURCES ::
	awardsmanagers(playerid, awardid, lgid, yearid)
	people (playerid,namefirst,namelast)
	managers (playerid, teamid)
	teams (teamid,name)

    DIMENSIONS ::
        * ...

    FACTS ::
        * ...

    FILTERS ::
        * ...

    DESCRIPTION ::
        ...

    ANSWER ::
    Davey Jonson Baltimore Oriels (AL) and Washington Nationals(NL)
	Jim Leyland Detoit Tigers (AL) and Pittsburg Pirates (NL)

*/


		/*SELECT CONCAT(namefirst,' ', namelast) AS mgr_name,
		p.playerid AS ppid,
	 	t.name AS team
		FROM people AS p
		JOIN managers AS m
		ON p.playerid = m.playerid
		JOIN teams as t
		ON m.teamid = t.teamid
		GROUP BY ppid, mgr_name, team*/
WITH nl_award AS(
		SELECT
		playerid,
		lgid
		FROM awardsmanagers
		WHERE awardid  LIKE '%TSN%' AND lgid = 'NL'
		GROUP BY playerid, lgid
		ORDER BY playerid),
	al_award AS(
		SELECT
		playerid,
		lgid
		FROM awardsmanagers
		WHERE awardid  LIKE '%TSN%' AND lgid = 'AL'
		GROUP BY playerid, lgid
		ORDER BY playerid)
SELECT CONCAT(namefirst,' ', namelast) AS mgr_name,
	 	t.name AS team
FROM people AS p
	JOIN managers AS m
	ON p.playerid = m.playerid
	JOIN teams as t
	ON m.teamid = t.teamid
	JOIN nl_award
	ON p.playerid = nl_award.playerid
	JOIN al_award
	ON p.playerid = al_award.playerid
	WHERE nl_award.playerid = al_award.playerid 
GROUP BY mgr_name, team;
	
		 
		
