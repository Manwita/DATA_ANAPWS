/*Use “ ” Database to solve the following questions */
use world;
/*Question 1 : Count how many cities are there in each country?*/

SELECT c.country_Name AS Country, COUNT(ci.city_ID) AS City_Count
FROM country c
JOIN city ci 
ON c.country_Code = ci.CountryCode
GROUP BY c.country_Name
ORDER BY City_Count DESC;


/*Question 2 : Display all continents having more than 30 countries.*/
SELECT Continent, COUNT(*) AS Country_Count
FROM country
GROUP BY Continent
HAVING COUNT(*) > 30;
/*Question 3 : List regions whose total population exceeds 200 million.*/

select region, sum(country_pop) as total_pop
from country
group by region
having  sum(country_pop) >20000000;

/*Question 4 : Find the top 5 continents by average GNP per country.*/
SELECT Continent, AVG(GNP) AS Avg_GNP
FROM country
GROUP BY Continent
ORDER BY Avg_GNP DESC
LIMIT 5;

/*Question 5 : Find the total number of official languages spoken in each continent.*/

SELECT c.Continent, COUNT(DISTINCT cl.Language) AS Official_Languages
FROM country c
JOIN countrylanguage cl 
ON c.country_Code = cl.CountryCode
WHERE cl.IsOfficial = 'T'
GROUP BY c.Continent
ORDER BY Official_Languages DESC;

/*Question 6 : Find the maximum and minimum GNP for each continent.*/
SELECT Continent,
       MAX(GNP) AS Max_GNP,
       MIN(GNP) AS Min_GNP
FROM country
GROUP BY Continent;

/*Question 7 : Find the country with the highest average city population.*/

SELECT c.country_Name AS Country,
       AVG(ci.Population) AS Avg_City_Population
FROM country c
JOIN city ci 
ON c.country_Code = ci.CountryCode
GROUP BY c.country_Name
ORDER BY Avg_City_Population DESC
LIMIT 1;

/*Question 8 : List continents where the average city population is greater than 200,000.*/
SELECT c.Continent,
       AVG(ci.Population) AS Avg_City_Population
FROM country c
JOIN city ci 
ON c.country_Code = ci.CountryCode
GROUP BY c.Continent
HAVING AVG(ci.Population) > 200000
ORDER BY Avg_City_Population DESC;

/*Question 9 : Find the total population and average life expectancy for each continent, ordered by average life 
expectancy descending.*/

SELECT Continent,
       SUM(country_pop) AS Total_Population,
       AVG(LifeExpectancy) AS Avg_Life_Expectancy
FROM country
GROUP BY Continent
ORDER BY Avg_Life_Expectancy DESC;

/*Question 10 : Find the top 3 continents with the highest average life expectancy, but only include those where 
the total population is over 200 million*/

SELECT Continent,
       SUM(country_pop) AS Total_Population,
       AVG(LifeExpectancy) AS Avg_Life_Expectancy
FROM country
GROUP BY Continent
HAVING SUM(country_pop) > 200000000
ORDER BY Avg_Life_Expectancy DESC
LIMIT 3;