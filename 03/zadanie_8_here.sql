SELECT DISTINCT(ST_Intersection(railways.geom, waterlines.geom)) AS geom
INTO T2019_KAR_BRIDGES
FROM t2019_kar_railways AS railways
CROSS JOIN t2019_kar_water_lines AS waterlines
WHERE ST_Intersects(railways.geom, waterlines.geom)