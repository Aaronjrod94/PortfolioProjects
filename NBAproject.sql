-- Bringing up the stats for all NBA teams as of Feb 3rd 2022
-- This dataset contains Win/Loss records which we will use
Select *
From NBAProject.dbo.GeneralStats
-- This dataset contains FG% and 3PM% which we will focus on
Select *
From NBAProject.dbo.ShootingStats
-- This dataset contains the raw numbers for all NBA teams
Select * 
From NBAProject.dbo.TotalNumbers

-- Joining TotalNumbers and GeneralStats Tables
Select *
From GeneralStats
Inner Join TotalNumbers
	On GeneralStats.Team = TotalNumbers.Team

--Selecting the relevant information from these data sets, Ordering by Losses
Select GeneralStats.Team, G, W, L, FGA, FG, [FG%], [3PA], [3P], [3P%], [2PA], [2P], [2P%], PTS, ORtg
From NBAProject.dbo.GeneralStats
Inner Join NBAProject.dbo.TotalNumbers
	On GeneralStats.Team = TotalNumbers.Team
	Order by L ASC

=--Looking at the league leaders in FG%

Select GeneralStats.Team, FGA, FG, [FG%]
From NBAProject.dbo.GeneralStats
Inner Join NBAProject.dbo.TotalNumbers
	On GeneralStats.Team = TotalNumbers.Team
	Order by [FG%] DESC

--Looking at which team shot the most threes

Select GeneralStats.Team, [3PA], [3P], [3P%]
From NBAProject.dbo.GeneralStats
Inner Join NBAProject.dbo.TotalNumbers
	On GeneralStats.Team = TotalNumbers.Team
	Order by [3PA] DESC

-- League leaders in 2 Point Attempts. Intrestingly, we see the Utah Jazz was first in 3PA and is last in 2PA

Select GeneralStats.Team, [2PA], [2P], [2P%]
From NBAProject.dbo.GeneralStats
Inner Join NBAProject.dbo.TotalNumbers
	On GeneralStats.Team = TotalNumbers.Team
	Order by [2PA] DESC

