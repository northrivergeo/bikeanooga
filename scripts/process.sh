#!/bin/bash 

[ -f ../data/bicycle_ways.overpassql ] && rm ../data/bicycle_ways.overpassql
[ -f ../data/bicycle_routes.geojson ] && rm ../data/bicycle_routes.geojson
[ -f ../data/bicycle_final.geojson ] && rm ../data/bicycle_final.geojson
[ -f ../data/bicycle_ways.geojson ] && rm ../data/bicycle_ways.geojson


#grab the data 
wget -O ../data/bicycle_ways.overpassql --post-file=bicycle_request.overpassql "https://overpass-api.de/api/interpreter"

ogr2ogr -f "GEOJSON" --config OSM_USE_CUSTOM_INDEXING NO ../data/bicycle_routes.geojson ../data/bicycle_ways.overpassql lines 

ogr2ogr -clipsrc ../data/hamilton_county.geojson ../data/bicycle_final.geojson ../data/bicycle_routes.geojson


