--For each continent show the number of countries:
SELECT continent, COUNT(name)
  FROM world
 GROUP BY continent
--For each continent show the total population:
SELECT continent, SUM(population)
  FROM world
 GROUP BY continent
--For each relevant continent show the number of countries that has a population of at least 200000000.
SELECT continent, COUNT(name)
  FROM world
 WHERE population >= 200000000
 GROUP BY continent
--Show the total population of those continents with a total population of at least half a billion.
SELECT continent, SUM(population)
  FROM world
 GROUP BY continent
HAVING SUM(population)>500000000
