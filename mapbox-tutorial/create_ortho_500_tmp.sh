#!/bin/bash

wget http://nomads.ncep.noaa.gov/cgi-bin/filter_gfs_0p25.pl\?file\=gfs.t00z.pgrb2.0p25.anl\&lev_500_mb\=on\&var_TMP\=on\&leftlon\=0\&rightlon\=360\&toplat\=90\&bottomlat\=-90\&dir\=%2Fgfs.$1 -O data/$1_500_tmp.grib2

gribdoctor smoosh -dev -uw data/$1_500_tmp.grib2 data/$1_500_tmp.tif

gdalwarp -t_srs '+proj=ortho +lat_0=90 +lon_0=135 +x_0=0 +y_0=0 +a=6378140 +b=6356750 +units=m +no_defs +datum=WGS84' -wo SOURCE_EXTRA=150 data/$1_500_tmp.tif data/ortho_$1_500_tmp.tif

gdaldem color-relief data/ortho_$1_500_tmp.tif temp-c.cpt data/colored_ortho_$1_500_tmp.tif

gdal_translate -of png data/colored_ortho_$1_500_tmp.tif img/$1_500_tmp.png
