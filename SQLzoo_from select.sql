--List each country name where the population is larger than that of 'Russia'.
SELECT name FROM world
  WHERE population >
     (SELECT population FROM world
      WHERE name='Russia')
--Show the countries in Europe with a per capita GDP greater than 'United Kingdom'.
SELECT name FROM world WHERE gdp/population > (SELECT gdp/population FROM world WHERE name = 'United Kingdom') AND continent = 'Europe'
--List the name and continent of countries in the continents containing either Argentina or Australia. Order by name of the country.
SELECT name, continent FROM world WHERE continent IN (SELECT continent FROM world WHERE name = 'Australia' OR name = 'Argentina') ORDER BY name
--Which country has a population that is more than Canada but less than Poland? Show the name and the population.
SELECT name, population FROM world WHERE population > (SELECT population FROM world WHERE name = 'Canada') AND population < (SELECT population FROM world WHERE name = 'Poland')
--Germany (population 80 million) has the largest population of the countries in Europe. Austria (population 8.5 million) has 11% of the population of Germany.

--Show the name and the population of each country in Europe. Show the population as a percentage of the population of Germany.

--Decimal places
--You can use the function ROUND to remove the decimal places.
--Percent symbol %
--You can use the function CONCAT to add the percentage symbol.
SELECT name, CONCAT(ROUND(population/(SELECT population FROM world WHERE name = 'Germany')*100), '%') FROM world WHERE continent = 'Europe'
--Which countries have a GDP greater than every country in Europe? [Give the name only.] (Some countries may have NULL gdp values)
SELECT name FROM world WHERE gdp > ALL(SELECT gdp FROM world WHERE continent = 'Europe' AND gdp > 0)
--Find the largest country (by area) in each continent, show the continent, the name and the area:
--The above example is known as a correlated or synchronized sub-query.

--Using correlated subqueries
--A correlated subquery works like a nested loop: the subquery only has access to rows related to a single record at a time in the outer query. The technique relies on table aliases to identify two different uses of the same table, one in the outer query and the other in the subquery.

--One way to interpret the line in the WHERE clause that references the two table is “… where the correlated values are the same”.

--In the example provided, you would say “select the country details from world where the population is greater than or equal to the population of all countries where the continent is the same”.
SELECT continent, name, area FROM world x
  WHERE area >= ALL
    (SELECT area FROM world y
        WHERE y.continent = x.continent)
--List each continent and the name of the country that comes first alphabetically.
Select  x.continent, x.name
From world x
Where x.name <= ALL (select y.name from world y where x.continent=y.continent)
ORDER BY name
--Find the continents where all countries have a population <= 25000000. Then find the names of the countries associated with these continents. Show name, continent and population.
SELECT name, continent, population FROM world x WHERE 25000000 >= ALL(SELECT population FROM world y WHERE x.continent = y.continent AND population > 0)
--Some countries have populations more than three times that of any of their neighbours (in the same continent). Give the countries and continents.
SELECT name, continent FROM world X WHERE population > ALL(SELECT population*3 FROM world Y WHERE X.continent = Y.continent AND X.name <> Y.name)
