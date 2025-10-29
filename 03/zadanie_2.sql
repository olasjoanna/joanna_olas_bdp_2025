SELECT ST_Area(
         ST_Buffer(
           ST_ShortestLine(
             (SELECT geom FROM obiekty WHERE nazwa='obiekt3'),
             (SELECT geom FROM obiekty WHERE nazwa='obiekt4')
           ),
           5
         )
       ) AS pole_powierzchni;