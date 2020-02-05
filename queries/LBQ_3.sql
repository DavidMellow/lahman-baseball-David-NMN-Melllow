/*
    QUESTION :: 3
	Find all players in the database who played at Vanderbilt University. 
	Create a list showing each player’s first and last names as well as the total salary they earned in the major leagues. 
	Sort this list in descending order by the total salary earned. 
	Which Vanderbilt player earned the most money in the majors?
	
    SOURCES ::
	people, college playing, schools, salaries tables

    DIMENSIONS ::
    namefirst, namelast

    FACTS ::
    Total salary

    FILTERS ::
    MAX, LIMIT

    DESCRIPTION ::
        ...

    ANSWER ::
       David Price
*/
DROP TABLE IF EXISTS vandy;

CREATE TEMP TABLE vandy AS
SELECT  
	DISTINCT CONCAT(p.namefirst,' ', p.namelast) AS full_name,  
	sch.schoolname AS college, 
	p.playerid
FROM people AS p
	JOIN collegeplaying AS colp
	ON p.playerid = colp.playerid
	JOIN schools AS sch
	ON colp.schoolid = sch.schoolid
WHERE sch.schoolname ILIKE '%Vanderbilt%';
/*SELECT *
FROM vandy  -- check table read out*/
/*SELECT COUNT (full_name)
FROM vandy --24 */
/*SELECT COUNT (DISTINCT playerid)
FROM collegeplaying
WHERE collegeplaying.schoolid ILIKE '%Vand%'; --24 checks */
/*SELECT 
	DISTINCT full_name,
	SUM(salary) AS total_salary_earn
FROM salaries
JOIN vandy
ON salaries.playerid = vandy.playerid
GROUP BY full_name
ORDER BY total_salary_earn DESC
LIMIT 1;*/
SELECT
	DISTINCT full_name,
	SUM(salary) AS total_salary_earn
FROM vandy
FULL OUTER JOIN salaries
ON vandy.playerid = salaries.playerid
GROUP BY full_name
HAVING SUM(salary) IS NULL;--trying to see why 24 Vandy players but only 15 with salaries

