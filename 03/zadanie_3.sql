UPDATE obiekty
SET geom = ST_MakePolygon(
  ST_AddPoint(geom, ST_StartPoint(geom))
)
WHERE nazwa = 'obiekt4';