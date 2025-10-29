WITH new_buildings AS (
	SELECT t2019.*
	FROM t2019_kar_buildings AS t2019
	LEFT JOIN t2018_kar_buildings AS t2018 
	ON t2019.geom = t2018.geom AND t2019.height = t2018.height
	WHERE t2018.geom IS NULL
), buffer AS (
	SELECT ST_Buffer(ST_Union(geom), 0.005) AS geom FROM new_buildings
), pois AS (
	SELECT poi2019.*
	FROM T2019_KAR_POI_TABLE AS poi2019
	LEFT JOIN T2018_KAR_POI_TABLE AS poi2018
	ON poi2019.geom = poi2018.geom
	WHERE poi2018.geom IS NULL
), count_poi AS (
	SELECT 
		COUNT(
			CASE WHEN ST_Contains(poi2019.geom, poi2018.geom) THEN 1 END 
			) AS counter, type
	FROM pois AS poi2018
	CROSS JOIN buffer AS poi2019
	GROUP BY type
)

SELECT * FROM count_poi 
WHERE counter != 0
ORDER BY counter DESC;