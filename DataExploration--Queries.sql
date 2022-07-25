/* COVID 19 DATA EXPLORATION
SKILLS USED: Joins, CTE's, Temp Tables, Window Functions, Aggregate Functions, Creating Views, Converting Data Types
*/

-- Checking tables

SELECT *
FROM CovidData..CovidDeaths
WHERE continent IS NOT NULL
ORDER BY 3, 4

SELECT *
FROM CovidData..CovidVaccinations
WHERE continent IS NOT NULL
ORDER BY 3, 4

-- Select the data we are going to use

SELECT location, date, total_cases, new_cases, total_deaths, population
FROM CovidData..CovidDeaths
WHERE continent IS NOT NULL
ORDER BY 1, 2

-- Looking at Total Cases vs Total Deaths

SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as death_percentage
FROM CovidData..CovidDeaths
WHERE continent IS NOT NULL
ORDER BY 1, 2

-- Lebanon's DeathPercentage change

SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as death_percentage
FROM CovidData..CovidDeaths
WHERE location = 'Lebanon'
ORDER BY 1, 2

-- Looking at Total Cases vs Population
-- Showing what percentage of population got infected with Covid

SELECT location, date, population, total_cases, (total_cases/population)*100 as percent_pop_infected
FROM CovidData..CovidDeaths
WHERE continent IS NOT NULL
ORDER BY 1, 2

-- Infection Rate in Lebanon

SELECT location, date, population, total_cases, (total_cases/population)*100 as percent_pop_infected
FROM CovidData..CovidDeaths
WHERE location = 'Lebanon'
ORDER BY 1, 2

-- Looking at countries with the Highest Infection Rates compared to Population

SELECT location, population, MAX(total_cases) as highest_infection_count, MAX((total_cases/population))*100 as percent_pop_infected
FROM CovidData..CovidDeaths
WHERE continent IS NOT NULL
GROUP BY location, population
ORDER BY percent_pop_infected DESC

-- Showing countries with the Highest Death Count per Population

SELECT location, population, MAX(CAST(total_deaths as int)) as total_death_count,
	MAX(CAST(total_deaths as int)/population)*100 as percent_pop_dead
FROM CovidData..CovidDeaths
WHERE continent IS NOT NULL
GROUP BY location, population
ORDER BY percent_pop_dead DESC

-- Let's break things down by Continent

SELECT location, MAX(CAST(total_deaths as int)) as highest_death_count
FROM CovidData..CovidDeaths
WHERE continent IS NULL
GROUP BY location
ORDER BY highest_death_count DESC

SELECT continent, MAX(CAST(total_deaths as int)) as highest_death_count
FROM CovidData..CovidDeaths
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY highest_death_count DESC

-- Global Numbers (Totals)

SELECT SUM(new_cases) as total_cases, SUM(CAST(new_deaths as int)) as total_deaths,
	SUM(CAST(new_deaths as int))/SUM(new_cases)*100 as death_percentage
FROM CovidData..CovidDeaths
WHERE continent IS NOT NULL

-- Daily Global Numbers

SELECT date, SUM(new_cases) as total_cases, SUM(CAST(new_deaths as int)) as total_deaths,
	SUM(CAST(new_deaths as int))/SUM(new_cases)*100 as death_percentage
FROM CovidData..CovidDeaths
WHERE continent IS NOT NULL
GROUP BY date
ORDER BY date

-- Looking at Total Population vs Vaccinations

SELECT dea.continent, dea.location, dea.date, population, new_vaccinations,
	SUM(CAST(new_vaccinations as bigint)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) as RollingPeopleVaccinated
FROM CovidData..CovidDeaths dea
JOIN CovidData..CovidVaccinations vac
	ON dea.location = vac.location
	AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
ORDER BY 2, 3

-- Create a CTE

WITH PopVsVac (Continent, Location, Date, Population, New_Vaccinations, RollingPeopleVaccinated)
AS
(
SELECT dea.continent, dea.location, dea.date, population, new_vaccinations,
	SUM(CAST(new_vaccinations as bigint)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) as RollingPeopleVaccinated
FROM CovidData..CovidDeaths dea
JOIN CovidData..CovidVaccinations vac
	ON dea.location = vac.location
	AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
)
SELECT *, (RollingPeopleVaccinated/Population)*100 AS PercentPopVaccinated
FROM PopVsVac

-- Create a Temp Table

DROP TABLE IF EXISTS #PercentPopulationVaccinated
CREATE TABLE #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric,
RollingPeopleVaccinated numeric
)

INSERT INTO #PercentPopulationVaccinated
SELECT dea.continent, dea.location, dea.date, population, new_vaccinations,
	SUM(CAST(new_vaccinations as bigint)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) as RollingPeopleVaccinated
FROM CovidData..CovidDeaths dea
JOIN CovidData..CovidVaccinations vac
	ON dea.location = vac.location
	AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
ORDER BY 2, 3

SELECT *, (RollingPeopleVaccinated/Population)*100 AS PercentPopVaccinated
FROM #PercentPopulationVaccinated

-- Create a View to store data for later visualizations

GO
CREATE OR ALTER VIEW PercentPopulationVaccinated
AS
SELECT dea.continent, dea.location, dea.date, population, new_vaccinations,
	SUM(CAST(new_vaccinations as bigint)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) as RollingPeopleVaccinated
FROM CovidData..CovidDeaths dea
JOIN CovidData..CovidVaccinations vac
	ON dea.location = vac.location
	AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
GO

SELECT *
FROM PercentPopulationVaccinated
