/*
    QUESTION :: 5
	Find the average number of strikeouts per game by decade since 1920. 
	Round the numbers you report to 2 decimal places. 
	Do the same for home runs per game. 
	Do you see any trends?
	
    SOURCES ::
	teams (yearid,so,hr)

    DIMENSIONS ::
     decade

    FACTS ::
     stikeouts, home runs

    FILTERS ::
        * ...

    DESCRIPTION ::
        ...

    ANSWER ::
        ...

*/
WITH bins AS (
	SELECT generate_series (1920,2010,10) AS start_decade,
		generate_series (1929,2019,10) AS end_decade),
avg_s AS ( 
	SELECT 
	DISTINCT yearid,
	SUM(so)/SUM(g) AS avg_so_g
	FROM teams
	WHERE so IS NOT NULL
	GROUP BY yearid),
avg_h AS ( 
	SELECT
	DISTINCT yearid,
SUM(hr)/SUM(g) AS avg_hr_g
	FROM teams
	WHERE hr IS NOT NULL
	GROUP BY yearid)
SELECT 
	start_decade, 
	end_decade, 
	ROUND(avg_so_g,2) AS avg_so_g,
	ROUND(avg_hr_g,2) AS avg_hr_g
	FROM bins
	JOIN avg_s
		ON avg_s.yearid >= start_decade
		AND avg_s.yearid <= end_decade
   	JOIN avg_h
		ON avg_h.yearid >= start_decade
		AND avg_h.yearid < end_decade
GROUP BY start_decade, end_decade, avg_so_g, avg_hr_g
ORDER BY start_decade;
