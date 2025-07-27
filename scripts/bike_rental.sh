qgis_process run quickosm:downloadosmdataextentquery --distance_units=meters --area_units=m2 --ellipsoid=EPSG:7030 --KEY=amenity --VALUE=bicycle_rental --TYPE_MULTI_REQUEST= --EXTENT='-85.499100000,34.978800000,-84.927700000,35.474700000 [EPSG:4326]' --TIMEOUT=25 --SERVER='https://overpass-api.de/api/interpreter' --FILE=/data/local_projects/bikeanooga/data/bike_rental.gpkg

ogr2ogr -f "GeoJSON" /data/local_projects/bikeanooga/data/bike_rental.geojson /data/local_projects/bikeanooga/data/bike_rental.gpkg bike_rental_points
