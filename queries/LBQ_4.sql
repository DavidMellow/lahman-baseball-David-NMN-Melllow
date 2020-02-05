/*
    QUESTION :: 4
	Using the fielding table, group players into three groups based on their position: 
		label players with position OF as "Outfield", 
		those with position "SS", "1B", "2B", and "3B" as "Infield", 
		and those with position "P" or "C" as "Battery". 
	Determine the number of putouts made by each of these three groups in 2016.
	
    SOURCES ::
	fielding table

    DIMENSIONS ::
     position

    FACTS ::
     put outs

    FILTERS ::
    SUM, CASE, WHERE, GROUP

    DESCRIPTION ::
     Summed put outs and agregated positions per the question. Limited to put outs in 2016

    ANSWER ::
       Battery 41424 put outs in 2016
	   Outfield 29560 put outs in 2016
	   Infield 58934 put outs in 2016
	   (129918 total put outs)
*/

/*SELECT DISTINCT POS
FROM fielding; --check position abbreviations in fielding.pos */

SELECT 
	SUM (po) AS po_2016,
	CASE 
		WHEN pos = 'OF' THEN 'outfield'
		WHEN pos = '1B' OR pos = '2B' OR pos = 'SS' or pos = '3B' THEN 'infield'
		ELSE 'battery' END AS position
FROM fielding AS f
WHERE yearid = '2016'
GROUP BY position;

/*SELECT yearid, SUM(po)
FROM fielding
WHERE yearid = '2016'
GROUP BY yearid; --129918  matches sum of three position groups*/

