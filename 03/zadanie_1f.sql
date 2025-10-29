INSERT INTO obiekty(nazwa, geom)
VALUES ('obiekt6',
  ST_Collect(ARRAY[
    ST_GeomFromText('LINESTRING(1 1, 3 2)'),
    ST_GeomFromText('POINT(4 2)')
  ])
);