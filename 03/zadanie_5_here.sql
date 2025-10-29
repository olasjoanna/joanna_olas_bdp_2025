ALTER TABLE input_points
ALTER COLUMN geom
TYPE geometry(Point, 4326)
USING ST_SetSRID(geom, 4326);

ALTER TABLE input_points
ALTER COLUMN geom
TYPE geometry(Point, 3068)
USING ST_Transform(geom, 3068);