CREATE EXTENSION postgis

CREATE TABLE buildings (
	id SERIAL PRIMARY KEY,
	name VARCHAR(50),
	geometry GEOMETRY(POLYGON)
);

CREATE TABLE roads (
	id SERIAL PRIMARY KEY,
	name VARCHAR(50),
	geometry GEOMETRY(LINESTRING)
);

CREATE TABLE poi (
	id SERIAL PRIMARY KEY,
	name VARCHAR(50),
	geometry GEOMETRY(POINT)
);

INSERT INTO buildings (name, geometry) VALUES
('BuildingA', ST_GeomFromText('POLYGON((8 4, 10.5 4, 10.5 1.5, 8 1.5, 8 4))')),
('BuildingB', ST_GeomFromText('POLYGON((4 7, 4 5, 6 5, 6 7, 4 7))')),
('BuildingC', ST_GeomFromText('POLYGON((3 8, 5 8, 5 6, 3 6, 3 8))')),
('BuildingD', ST_GeomFromText('POLYGON((9 9, 9 8, 10 8, 10 9, 9 9))')),
('BuildingF', ST_GeomFromText('POLYGON((1 2, 2 2, 2 1, 1 1, 1 2))'));


INSERT INTO poi (name, geometry) VALUES
('I', ST_GeomFromText('POINT(9.5 6)')),
('J', ST_GeomFromText('POINT(6.5 6)')),
('K', ST_GeomFromText('POINT(6 9.5)')),
('G', ST_GeomFromText('POINT(1 3.5)')),
('H', ST_GeomFromText('POINT(5.5 1.5)'));

INSERT INTO roads (name, geometry) VALUES
('RoadX', ST_GeomFromText('LINESTRING(0 4.5, 12 4.5)')),
('RoadY', ST_GeomFromText('LINESTRING(7.5 10.5, 7.5 0)'));

--całkowita długość dróg
SELECT SUM(ST_Length(geometry)) AS total_length FROM roads;

--geometria wkt, pole powierzchni i obwod BuildingA
SELECT 
name, 
ST_AsText(geometry) AS wkt_geom,
ST_Area(geometry) AS area,
ST_Perimeter(geometry) AS perimeter
FROM buildings 
WHERE name = 'BuildingA';

--nazwy i pola pow budynkow alfabetycznie
SELECT name, ST_Area(geometry) AS area
FROM buildings
ORDER BY name ASC;

--nazwy i obw dwoch najwiekszych budynkow
SELECT name, ST_Perimeter(geometry) AS perimeter, ST_Area(geometry) AS area
FROM buildings
ORDER BY area DESC
LIMIT 2;

--najkrotsza odl miedzy BuildingC a punktem K
SELECT 
ST_Distance(
	(SELECT geometry FROM buildings WHERE name='BuildingC'),
	(SELECT geometry FROM poi WHERE name='K')
) AS min_dist;

--pole pow tej czesci budynku, ktora znajduje sie dalej niz 0.5 od Building B

SELECT 
ST_Area(
	ST_Difference(
		(SELECT geometry FROM buildings WHERE name = 'BuildingC'),
		ST_Buffer((SELECT geometry FROM buildings WHERE name='BuildingB'), 0.5)
	)
) AS area_farther;

--budynki, ktorych centroid jest powyzej ROadX
SELECT 
    name,
    ST_Y(ST_Centroid(geometry)) AS centroid_y
FROM buildings
WHERE ST_Y(ST_Centroid(geometry)) > 4.5;

--pole pow czesci buildingC i poligonu, ktore nie sa wspolne

WITH 
polyg AS (
    SELECT ST_GeomFromText('POLYGON((4 7, 6 7, 6 8, 4 8, 4 7))') AS geom
),
diff_buildingC AS (
    SELECT ST_Difference(b.geometry, p.geom) AS diff1
    FROM buildings b, polyg p
    WHERE b.name = 'BuildingC'
),
diff_polygon AS (
    SELECT ST_Difference(p.geom, b.geometry) AS diff2
    FROM buildings b, polyg p
    WHERE b.name = 'BuildingC'
)
SELECT 
    ST_Area(diff1) + ST_Area(diff2) AS non_common_area
FROM diff_buildingC, diff_polygon;
