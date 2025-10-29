WITH outer_ring AS (
  SELECT ST_MakePolygon(
    ST_LineMerge(ST_Collect(ARRAY[
      ST_MakeLine(ST_MakePoint(10,6), ST_MakePoint(14,6)),
      ST_GeomFromText('CIRCULARSTRING(14 6, 16 4, 14 2)'),
      ST_GeomFromText('CIRCULARSTRING(14 2, 12 0, 10 2)'),
      ST_MakeLine(ST_MakePoint(10,2), ST_MakePoint(10,6))
    ]))
  ) AS geom
),
inner_hole AS (
  SELECT ST_Buffer(ST_MakePoint(12,2), 1) AS geom
)
INSERT INTO obiekty (nazwa, geom)
SELECT 
  'obiekt2',
  ST_Difference(outer_ring.geom, inner_hole.geom)
FROM outer_ring, inner_hole;