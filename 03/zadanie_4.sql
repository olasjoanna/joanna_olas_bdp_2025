INSERT INTO obiekty (nazwa, geom)
SELECT 'obiekt7',
       ST_Union(
         (SELECT geom FROM obiekty WHERE nazwa = 'obiekt3'),
         (SELECT geom FROM obiekty WHERE nazwa = 'obiekt4')
       );