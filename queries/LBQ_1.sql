/*
    QUESTION :: 1
	What range of years does the provided database cover?
	
    SOURCES ::
   	batting, ptching,fielding,Teams Table  

    DIMENSIONS ::
   	*-
	
	FACTS ::
 	MIN year, MAX year
    
	FILTERS ::
   	only using 4 main tables from database 

    DESCRIPTION ::
   	Assumptions from READ.me :1871- 2016 
	Find first and most recent years
	
    ANSWER ::
   	1871-2016
	
*/
/*SELECT MIN (yearid) AS start_year, Max(yearid) AS most_recent_year		
FROM Batting;*/
/*SELECT MIN (yearid) AS start_year, Max(yearid) AS most_recent_year		
FROM Teams;*/

WITH combined_years AS 
	(SELECT
		MIN(yearid) AS min_year, MAX(yearid) AS max_year
		FROM batting
	UNION ALL
	SELECT
	MIN(yearid), Max(yearid)
		FROM pitching
	 UNION ALL
	SELECT	
		MIN(yearid), Max(yearid)
		FROM fielding
	 UNION ALL
	SELECT
	 MIN(yearid), Max(yearid)
		FROM teams)
SELECT MIN(min_year), MAX(max_year)
FROM combined_years;