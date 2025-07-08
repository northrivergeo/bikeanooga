#!/bin/bash 

#delete the old data if it exists
[ -f ../data/bicycle_ways.overpassql ] && rm ../data/bicycle_ways.overpassql
[ -f ../data/bicycle_routes.geojson ] && rm ../data/bicycle_routes.geojson
[ -f ../data/bicycle_final.geojson ] && rm ../data/bicycle_final.geojson
[ -f ../data/bicycle_ways.geojson ] && rm ../data/bicycle_ways.geojson

[ -f ../data/riverwalk_ways.overpassql ] && rm ../data/riverwalk_ways.overpassql
[ -f ../data/riverwalk_routes.geojson ] && rm ../data/riverwalk_routes.geojson
[ -f ../data/riverwalk_final.geojson ] && rm ../data/riverwalk_final.geojson
[ -f ../data/riverwalk_ways.geojson ] && rm ../data/riverwalk_ways.geojson

[ -f ../data/schick_ways.overpassql ] && rm ../data/schick_ways.overpassql
[ -f ../data/schick_routes.geojson ] && rm ../data/schick_routes.geojson
[ -f ../data/schick_final.geojson ] && rm ../data/schick_final.geojson
[ -f ../data/schick_ways.geojson ] && rm ../data/schick_ways.geojson

[ -f ../data/bike_rentals.overpassql ] && rm ../data/bike_rentals.overpassql
[ -f ../data/bike_rentals_points.geojson ] && rm ../data/bike_rentals_points.geojson
[ -f ../data/bike_rentals_final.geojson ] && rm ../data/bike_rentals_final.geojson
[ -f ../data/bike_rentals.geojson ] && rm ../data/bike_rentals.geojson

[ -f ../data/bicycle_tracks.overpassql ] && rm ../data/bicycle_tracks.overpassql
[ -f ../data/bicycle_tracks_routes.geojson ] && rm ../data/bicycle_tracks_routes.geojson
[ -f ../data/bicycle_tracks_final.geojson ] && rm ../data/bicycle_tracks_final.geojson
[ -f ../data/bicycle_tracks.geojson ] && rm ../data/bicycle_tracks.geojson

#grab the data 
wget -O ../data/bicycle_ways.overpassql --post-file=bicycle_request.overpassql "https://overpass-api.de/api/interpreter"
wget -O ../data/schick_ways.overpassql --post-file=schick_greenway_request.overpassql "https://overpass-api.de/api/interpreter"
wget -O ../data/riverwalk_ways.overpassql --post-file=riverwalk_request.overpassql "https://overpass-api.de/api/interpreter"
wget -O ../data/bike_rentals.overpassql --post-file=bike_rentals_request.overpassql "https://overpass-api.de/api/interpreter"
wget -O ../data/bicycle_tracks.overpassql --post-file=bike_rentals_request.overpassql "https://overpass-api.de/api/interpreter"

#process the data 
ogr2ogr -f "GEOJSON" --config OSM_USE_CUSTOM_INDEXING NO ../data/bicycle_routes.geojson ../data/bicycle_ways.overpassql lines 
ogr2ogr -f "GEOJSON" --config OSM_USE_CUSTOM_INDEXING NO ../data/schick_routes.geojson ../data/schick_ways.overpassql lines 
ogr2ogr -f "GEOJSON" --config OSM_USE_CUSTOM_INDEXING NO ../data/riverwalk_routes.geojson ../data/riverwalk_ways.overpassql lines 
ogr2ogr -f "GEOJSON" --config OSM_USE_CUSTOM_INDEXING NO ../data/bike_rentals_points.geojson ../data/bike_rentals.overpassql points 
ogr2ogr -f "GEOJSON" --config OSM_USE_CUSTOM_INDEXING NO ../data/bicycle_tracks_routes.geojson ../data/bicycle_tracks.overpassql lines 

#clip it at the county line
ogr2ogr -clipsrc ../data/hamilton_county.geojson ../data/bicycle_final.geojson ../data/bicycle_routes.geojson
ogr2ogr -clipsrc ../data/hamilton_county.geojson ../data/riverwalk_final.geojson ../data/riverwalk_routes.geojson
ogr2ogr -clipsrc ../data/hamilton_county.geojson ../data/schick_final.geojson ../data/schick_routes.geojson
ogr2ogr -clipsrc ../data/hamilton_county.geojson ../data/bicycle_tracks_final.geojson ../data/bicycle_tracks_routes.geojson


