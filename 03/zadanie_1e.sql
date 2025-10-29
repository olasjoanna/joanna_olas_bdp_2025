INSERT INTO obiekty(nazwa, geom)
VALUES ('obiekt5',
  ST_Collect(ARRAY[
    ST_GeomFromText('POINT Z(30 30 59)'),
    ST_GeomFromText('POINT Z(38 32 234)')
  ])
);