WITH intersections AS (
    SELECT node_id, ST_Transform(geom, 3068) AS geom
    FROM t2019_kar_street_node
    WHERE "intersect" = 'Y'
),
new_line AS (
    SELECT ST_MakeLine(geom ORDER BY id) AS geom
    FROM input_points
)
SELECT DISTINCT node.*
FROM intersections AS node
JOIN new_line AS line
ON ST_DWithin(node.geom, line.geom, 200) 
ORDER BY node_id;