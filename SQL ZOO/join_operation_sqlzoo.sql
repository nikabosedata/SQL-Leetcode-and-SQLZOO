--JOIN Operation 
-- Problem solving JOIN SQL questions on SQL ZOO 
--mySQL database: https://sqlzoo.net/euro2012.sql


--1. show the matchid and player name for all goals scored by Germany. To identify German players, check for: teamid = 'GER'
SELECT matchid, player FROM goal 
  WHERE teamid = 'GER';

--2. From the previous query you can see that Lars Bender's scored a goal in game 1012. Now we want to know what teams were playing in that match.
SELECT id,stadium,team1,team2
  FROM game
WHERE id = 1012;

--3. show the player, teamid, stadium and mdate for every German goal.
SELECT player,teamid,stadium,mdate
FROM game JOIN goal ON (game.id=goal.matchid)
WHERE teamid = 'GER'

--4. Show the team1, team2 and player for every goal scored by a player called Mario player LIKE 'Mario%'
SELECT team1, team2, player FROM game JOIN goal ON (game.id = goal.matchid) 
WHERE player LIKE '%Mario%'

--5. Show player, teamid, coach, gtime for all goals scored in the first 10 minutes gtime<=10
SELECT player, teamid, coach, gtime
  FROM goal JOIN eteam on teamid = id
 WHERE gtime<=10

 --6. List the the dates of the matches and the name of the team in which
-- 'Fernando Santos' was the team1 coach.
SELECT mdate, teamname
FROM game
JOIN eteam ON (game.team1 = eteam.id)
WHERE coach = 'Fernando Santos'

-- 7. List the player for every goal scored in a game where the staium was
-- 'National Stadium, Warsaw'
SELECT player
FROM goal
JOIN game ON (goal.matchid = game.id)
WHERE stadium = 'National Stadium, Warsaw'

-- 8. Show names of all players who scored a goal against Germany.
SELECT DISTINCT player
FROM game
JOIN goal ON goal.matchid = game.id
WHERE (team1 = 'GER' OR team2 = 'GER')
AND teamid <> 'GER'

-- 9. Show teamname and the total number of goals scored.
SELECT teamname, COUNT(player) goals_scored
FROM eteam JOIN goal ON eteam.id = goal.teamid
GROUP BY teamname

-- 10. Show the stadium and the number of goals scored in each stadium.
SELECT stadium, COUNT(player) goals_scored
FROM game
JOIN goal ON game.id = goal.matchid
GROUP BY stadium

-- 11. For every match involving 'POL', show the matchid, date and the number of
-- goals scored.
SELECT matchid, mdate, COUNT(player) goals_scored
FROM game
JOIN goal ON goal.matchid = game.id
WHERE (team1 = 'POL' OR team2 = 'POL')
GROUP BY goal.matchid

-- 12. For every match where 'GER' scored, show matchid, match date and the
-- number of goals scored by 'GER'
SELECT matchid, mdate, COUNT(player)
FROM game
JOIN goal ON game.id = goal.matchid
WHERE teamid = 'GER'
GROUP BY game.id

-- 13. List every match with the goals scored by each team as shown.
-- Sort your result by mdate, matchid, team1 and team2.
SELECT mdate,
  team1,
  SUM(CASE WHEN teamid=team1 THEN 1 ELSE 0 END) score1,
  team2,
  SUM(CASE WHEN teamid=team2 THEN 1 ELSE 0 END) score2
FROM game JOIN goal ON goal.matchid = game.id
GROUP BY game.id
ORDER BY mdate, matchid, team1, team2