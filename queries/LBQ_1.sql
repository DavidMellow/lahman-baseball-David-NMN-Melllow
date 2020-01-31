/*
    QUESTION :: 1
	What range of years does the provided database cover?
	
    SOURCES ::
   	Teams Table  

    DIMENSIONS ::
   	start_year,most_recent_year
	check: count
    FACTS ::
 	MIN(yearid), MAX(yearid)
	check: yearid
    FILTERS ::
   	none

    DESCRIPTION ::
   	Find first and most recent years
	check: count number of years in table
    ANSWER ::
   	1871-2016
	check: no years within span id omitted
*/

SELECT MIN (yearid) AS start_year, Max(yearid) AS most_recent_year		
FROM Teams;

--check for years with no stats
/*SELECT COUNT (DISTINCT yearid)
FROM TEAMS; --counts years in the table and returns 146. No years skipped*/

