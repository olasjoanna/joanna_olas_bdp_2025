WITH buffer_parks AS (
    SELECT ST_Buffer(ST_Union(geom), 0.003) AS park_geom
    FROM t2019_kar_land_use_a
    WHERE "type" ILIKE '%park%'
),
sport_stores AS (
    SELECT geom AS store_geom
    FROM t2019_kar_poi_table
    WHERE "type" LIKE 'Sporting Goods Store'
)
SELECT COUNT(*) AS store_count
FROM sport_stores AS store
JOIN buffer_parks AS park
ON ST_Contains(park.park_geom, store.store_geom);