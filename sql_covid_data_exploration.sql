
--selecting database to work on
select *
from PortfolioProject..covidData


-- Selecting data I will be using (I couldn't select total_cases as I deleted the column at some point and couldn't restore it)
select location, date, population, new_cases, new_tests, total_deaths, new_deaths
from PortfolioProject..covidData
order by 1, 2


-- New cases vs new deaths
select location, date, new_cases, new_deaths, (new_deaths/ nullif (new_cases, 0))*100 as DeathPercentage
from PortfolioProject..covidData
order by 1, 2


-- Covid situation in Bangladesh (My country)
select location, date, population, new_cases, new_deaths, total_deaths, icu_patients, (new_deaths/new_cases)*100 as DeathPercentageInBD
from PortfolioProject..covidData
where location = 'Bangladesh' and new_cases > 0 
order by 2


-- Number of deaths countrywise
select location, max(cast(total_deaths as int)) as Total_deaths
from PortfolioProject..covidData
where continent is not null
group by location
order by Total_deaths desc 


-- Number of deaths continentwise
select location, max(cast(total_deaths as int)) as Total_deaths
from PortfolioProject..covidData
where continent is null and location != 'World' and location != 'International' and location != 'European Union'
group by location
order by Total_deaths desc 


-- New tests vs new case
select location, date, new_tests, new_cases
from PortfolioProject..covidData
where continent is not null and location != 'World' and location != 'International' and location != 'European Union'
order by 1


-- ICU patients
select location, date, cast(icu_patients as int) as icu_patients
from PortfolioProject..covidData
where continent is not null and location != 'World' and location != 'International' and location != 'European Union'
order by 3 desc
