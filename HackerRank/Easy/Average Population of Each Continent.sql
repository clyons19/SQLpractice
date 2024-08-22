SELECT co.continent, FLOOR(AVG(c.population)) FROM country AS co
JOIN city AS c ON c.countrycode=co.code
GROUP BY co.continent;