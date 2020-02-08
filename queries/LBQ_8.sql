/*
    QUESTION :: 8
	Using the attendance figures from the homegames table, 
	find the teams and parks which had the top 5 average attendance per game in 2016 
		(where average attendance is defined as total attendance divided by number of games). 
	Only consider parks where there were at least 10 games played. 
	Report the park name, team name, and average attendance. 
	Repeat for the lowest 5 average attendance.
	
    SOURCES ::
	homegames (park,year, games, attendance)
	
	teams (yearid, park, name)

    DIMENSIONS ::
    2016

    FACTS ::
        * ...

    FILTERS ::
        * ...

    DESCRIPTION ::
        ...

    ANSWER ::
        ...

*/

--Part 1
/*DROP TABLE IF EXISTS d_avg_att;	
CREATE TEMP TABLE d_avg_att AS --descending average attendance table
 SELECT
	 	team AS d_team,
		games AS d_games,
		SUM(attendance)/games AS d_avg_attendance
		FROM homegames AS h 
		GROUP BY d_team, games, year
		HAVING h.year = '2016' AND games > 10
		ORDER BY d_avg_attendance DESC;*/
		
/*SELECT *
FROM d_avg_att; */ --table readout check

/*SELECT 
	t.name AS d_name,
	t.park AS d_park,
	d.d_avg_attendance
FROM teams AS t
JOIN d_avg_att AS d
ON t.teamid = d.d_team
GROUP BY t.yearid, t.name, t.park, d.d_avg_attendance, d.d_games, t.teamid, d_team 
HAVING t.yearid = '2016' AND d.d_games > 10
ORDER BY d.d_avg_attendance DESC
LIMIT 5;*/

--Part 2
DROP TABLE IF EXISTS a_avg_att;
CREATE TEMP TABLE a_avg_att AS --ascending average attendance table
	SELECT
	 	team AS a_team,
		games AS a_games,
		SUM(attendance)/games AS a_avg_attendance
		FROM homegames AS h 
		GROUP BY a_team, games, year
		HAVING h.year = '2016' AND games > 10
		ORDER BY a_avg_attendance;
		
/*SELECT *
FROM a_avg_att;*/ --table readout check

SELECT 
	t.name AS a_name,
	t.park AS a_park,
	a.a_avg_attendance
FROM teams AS t
JOIN a_avg_att AS a
ON t.teamid = a.a_team
GROUP BY t.yearid, t.name, t.park, a.a_avg_attendance, a.a_games, t.teamid, a_team 
HAVING t.yearid = '2016' AND a.a_games > 10
ORDER BY a.a_avg_attendance 
LIMIT 5;
