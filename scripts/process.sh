#!/bin/bash 

#delete the old data if it exists


[ -f ../data/bicycle_ways.gpkg ] && rm ../data/bicycle_ways.gpkg
[ -f ../data/riverwalk_ways.gpkg ] && rm ../data/riverwalk_ways.gpkg
[ -f ../data/schick_ways.gpkg ] && rm ../data/schick_ways.gpkg
[ -f ../data/bike_rentals.gpkg ] && rm ../data/bike_rentals.gpkg
[ -f ../data/bicycle_tracks.gpkg ] && rm ../data/bicycle_tracks.gpkg
[ -f ../data/shared_lanes.gpkg ] && rm ../data/shared_lanes.gpkg

[ -f ../data/bicycle_ways_final.geojson ] && rm ../data/bicycle_ways_final.geojson
[ -f ../data/riverwalk_ways_final.geojson ] && rm ../data/riverwalk_ways_final.geojson
[ -f ../data/schick_ways_final.geojson ] && rm ../data/schick_ways_final.geojson
[ -f ../data/bike_rentals_final.geojson ] && rm ../data/bike_rentals_final.geojson
[ -f ../data/shared_lanes_final.geojson ] && rm ../data/shared_lanes_final.geojson


#grab the data 
qgis_process run quickosm:downloadosmdataextentquery --distance_units=meters --area_units=m2 --ellipsoid=EPSG:7030 --KEY=amenity --VALUE=bicycle_rental --TYPE_MULTI_REQUEST= --EXTENT='-85.499100000,-84.927700000,34.978800000,35.474700000 [EPSG:4326]' --TIMEOUT=25 --SERVER='https://overpass-api.de/api/interpreter' --FILE=/data/local_projects/bikeanooga/data/bike_rental.gpkg

qgis_process run quickosm:downloadosmdataextentquery --distance_units=meters --area_units=m2 --ellipsoid=EPSG:7030 --KEY=name --VALUE='South Chickamauga Creek Greenway' --TYPE_MULTI_REQUEST= --EXTENT='-85.499100000,-84.927700000,34.978800000,35.474700000 [EPSG:4326]' --TIMEOUT=25 --SERVER='https://overpass-api.de/api/interpreter' --FILE=/data/local_projects/bikeanooga/data/schick_greenway.gpkg

qgis_process run quickosm:downloadosmdataextentquery --distance_units=meters --area_units=m2 --ellipsoid=EPSG:7030 --KEY=name --VALUE='Tennessee Riverwalk' --TYPE_MULTI_REQUEST= --EXTENT='-85.499100000,-84.927700000,34.978800000,35.474700000 [EPSG:4326]' --TIMEOUT=25 --SERVER='https://overpass-api.de/api/interpreter' --FILE=/data/local_projects/bikeanooga/data/riverwalk.gpkg

qgis_process run quickosm:downloadosmdataextentquery --distance_units=meters --area_units=m2 --ellipsoid=EPSG:7030 --KEY='cycleway:right' --VALUE=track --TYPE_MULTI_REQUEST= --EXTENT='-85.499100000,-84.927700000,34.978800000,35.474700000 [EPSG:4326]' --TIMEOUT=25 --SERVER='https://overpass-api.de/api/interpreter' --FILE=/data/local_projects/bikeanooga/data/bicycle_tracks.gpkg

qgis_process run quickosm:downloadosmdataextentquery --distance_units=meters --area_units=m2 --ellipsoid=EPSG:7030 --KEY='cycleway' --VALUE=shared_lane --TYPE_MULTI_REQUEST= --EXTENT='-85.499100000,-84.927700000,34.978800000,35.474700000 [EPSG:4326]' --TIMEOUT=25 --SERVER='https://overpass-api.de/api/interpreter' --FILE=/data/local_projects/bikeanooga/data/shared_lane.gpkg

#process the data 
ogr2ogr -f "GeoJSON" -clipsrc ../data/hamilton_county.geojson /data/local_projects/bikeanooga/data/bike_rental_final.geojson /data/local_projects/bikeanooga/data/bike_rental.gpkg bike_rental_points
ogr2ogr -f "GeoJSON" -clipsrc ../data/hamilton_county.geojson /data/local_projects/bikeanooga/data/schick_final.geojson /data/local_projects/bikeanooga/data/schick_greenway.gpkg schick_greenway_lines
ogr2ogr -f "GeoJSON" -clipsrc ../data/hamilton_county.geojson /data/local_projects/bikeanooga/data/riverwalk_final.geojson /data/local_projects/bikeanooga/data/riverwalk.gpkg riverwalk_lines
ogr2ogr -f "GeoJSON" -clipsrc ../data/hamilton_county.geojson /data/local_projects/bikeanooga/data/bicycle_tracks_final.geojson /data/local_projects/bikeanooga/data/bicycle_tracks.gpkg bicycle_tracks_lines
ogr2ogr -f "GeoJSON" -clipsrc ../data/hamilton_county.geojson /data/local_projects/bikeanooga/data/shared_lane_final.geojson /data/local_projects/bikeanooga/data/shared_lane.gpkg shared_lane_lines

