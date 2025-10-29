SELECT t2019.*
FROM t2019_kar_buildings AS t2019
LEFT JOIN t2018_kar_buildings AS t2018 
ON t2019.geom = t2018.geom AND t2019.height = t2018.height
WHERE t2018.geom IS NULL;