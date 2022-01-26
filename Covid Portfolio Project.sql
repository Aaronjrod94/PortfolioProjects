Select *
From PortfolioProject..CovidDeaths
Where continent is not null
order by 3,4

Select Location, date, total_cases, new_cases, total_deaths, population
From PortfolioProject..CovidDeaths
order by 1,2

--Total Cases VS vs Total Deaths
-- Shows likelihood of death if infected

Select Location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
From PortfolioProject..CovidDeaths
Where location like '%states%'
order by 1,2

-- Total Cases vs Population
-- Shows percentage of population infected
Select Location, date, total_cases, population, (total_cases/population)*100 as InfectionRate
From PortfolioProject..CovidDeaths
--Where location like '%states%'
order by 1,2

-- Looking at Countries with Highest Infection Rate Compared to Population
Select Location, population, MAX(total_cases) as HighestInfectionCount, MAX((total_cases/population))*100 as InfectionRate
From PortfolioProject..CovidDeaths
group by Location, population
order by population desc

-- Countries With Highest Death Count per population
Select Location, MAX(cast(Total_deaths as int)) as TotalDeaths
From PortfolioProject..CovidDeaths
Where continent is not null
group by Location
order by TotalDeaths desc

-- By Continent

Select location, MAX(cast(Total_deaths as int)) as TotalDeaths
From PortfolioProject..CovidDeaths
Where continent is null
group by location
order by TotalDeaths desc

-- Global Numbers

Select date, SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths,
SUM(cast(new_deaths as int))/SUM(new_cases)*100 as DeathPercentage
From PortfolioProject..CovidDeaths
--Where location like '%states%'
Where continent is not null
Group By date
order by 1,2


-- Death Rate For World
Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths,
SUM(cast(new_deaths as int))/SUM(new_cases)*100 as DeathPercentage
From PortfolioProject..CovidDeaths
--Where location like '%states%'
Where continent is not null
--Group By date
order by 1,2

-- Total Population vs Vaccinations
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(Convert(bigint,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.date)
as RollingPeopleVaccinated 
--(RollingPeopleVaccinated/population)
from PortfolioProject..CovidDeaths dea
join PortfolioProject..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
Where dea.continent is not null
Order by 2,3

--CTE Example

with PopvsVac (Continent, location, date, population, New_Vaccinations, RollingPeopleVaccinated)
as
(select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(Convert(bigint,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.date)
as RollingPeopleVaccinated 
--(RollingPeopleVaccinated/population)
from PortfolioProject..CovidDeaths dea
join PortfolioProject..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
Where dea.continent is not null
--Order by 2,3
) 
Select *, (RollingPeopleVaccinated/Population)*100
from PopvsVac



-- Temp Table
Create Table #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric,
RollingPeopleVaccinated numeric
)
Insert Into #PercentPopulationVaccinated
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(Convert(bigint,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.date)
as RollingPeopleVaccinated 
--(RollingPeopleVaccinated/population)
from PortfolioProject..CovidDeaths dea
join PortfolioProject..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
Where dea.continent is not null

Select *, (RollingPeopleVaccinated/Population)*100
from #PercentPopulationVaccinated

--Creating View to store data for visualizations
Create View DeathRateForWorld as
Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths,
SUM(cast(new_deaths as int))/SUM(new_cases)*100 as DeathPercentage
From PortfolioProject..CovidDeaths
--Where location like '%states%'
Where continent is not null
Group By date
--order by 1,2

Select *
from DeathRateForWorld