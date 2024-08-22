SELECT SUM(c.population) FROM city AS c
JOIN country AS co ON c.countrycode=co.code
WHERE co.continent='Asia';