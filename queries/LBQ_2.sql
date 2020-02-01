/*
    QUESTION :: 2
	   Find the name and height of the shortest player in the database.
	   How many games did he play in? 
	   What is the name of the team for which he played?
    
	SOURCES ::
	people, appearances, teams tables
	
	DIMENSIONS ::
	namefist, namelast, namegiven, games played, team

    FACTS ::
    height

    FILTERS ::
    LIMIT

    DESCRIPTION ::
    Combine people, appearnces, and people tables to find asked for information 
	on shortest player

    ANSWER :
	Shortest Player is Edward Carl Gaedel height 43" (3'7")
	Edward Carl Gaedel played in 1 game
	Edward Carl Gaedel played for 
*/

/*SELECT playerid, namefirst, namelast, namegiven, MIN(height)
FROM people
GROUP BY playerid
ORDER BY height; --Edward Carl Gaedel height 43" (3'7")*/

/*SELECT p.playerid, g_all, namefirst, namelast, namegiven
FROM appearances AS a
JOIN people AS p ON a.playerid = p.playerid
WHERE namelast ILIKE 'Gaedel';*/

/*SELECT DISTINCT (playerid), teams.name
FROM appearances AS apps
JOIN teams
ON apps.teamid = teams.teamid
JOIN teamsfranchises AS tf
ON  teams.franchid = tf.franchid
WHERE apps.playerid = 'gaedeed01'; -- St. Loius Browns*/

SELECT
p.namefirst, p.namelast, p.namegiven, MIN(height) AS height, g_all AS games_played, t.name AS team
FROM people AS p
JOIN  appearances AS apps
ON p.playerid = apps.playerid
JOIN teams AS t
ON apps.teamid = t.teamid
GROUP BY p.namefirst, p.namelast, p.namegiven, apps.g_all, t.name
ORDER BY height
LIMIT 1;




