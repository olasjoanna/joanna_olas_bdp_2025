CREATE EXTENSION IF NOT EXISTS postgis;

CREATE TABLE IF NOT EXISTS obiekty(
    id serial PRIMARY KEY,
    nazwa text,
    geom geometry
);

INSERT INTO obiekty (nazwa, geom)
VALUES ('obiekt1',
  ST_Collect(ARRAY[
    ST_MakeLine(ST_MakePoint(0,1), ST_MakePoint(1,1)), 
    ST_GeomFromText('CIRCULARSTRING(1 1, 2 0, 3 1)'), 
    ST_GeomFromText('CIRCULARSTRING(3 1, 4 2, 5 1)'),
    ST_MakeLine(ST_MakePoint(5,1), ST_MakePoint(6,1))      
  ])
);