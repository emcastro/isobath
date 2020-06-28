IsoBath
=======

Construction d'isobath en fonction de contraintes diverses à partir d'un grid bathymétrique

# TODO

* Découpage (cf. compétences) sur la zone US4MA13M
  * `gdalwarp -of GTiff -tr 30.0 -30.0 -tap -cutline /tmp/processing_tUFKXm/d2141618117a4f748786662cf68c1f29/MASK.shp -cl MASK -crop_to_cutline /home/ecastro/isobath/data/navd_bath_30m /tmp/processing_tUFKXm/5b1965931e864ffdb686f28e1e27d838/OUTPUT.tif`
  * https://pcjericks.github.io/py-gdalogr-cookbook/raster_layers.html#clip-a-geotiff-with-shapefile
  * https://www.youtube.com/watch?v=n33MswNARkE

* Apprendre à écrire des fichers ~~Raster~~ & Vector

* Parcourir les géométries des features DEPARE et filtrer en fonction de la valeur de Bathy.

# Docs

## GDAL/OGR
* https://pcjericks.github.io/py-gdalogr-cookbook/
* https://gdal.org/tutorials/index.html
* https://gdal.org/api/index.html#id3
* https://www.programcreek.com/python/index/8908/osgeo.ogr
* https://www.programcreek.com/python/index/6873/gdal

## Général
* https://hub.packtpub.com/libraries-for-geospatial-analysis/
* https://shapely.readthedocs.io/en/latest/project.html
* https://fiona.readthedocs.io/en/latest/README.html
* https://rasterio.readthedocs.io/en/latest/
* https://stackoverflow.com/questions/4681737/how-to-calculate-the-area-of-a-polygon-on-the-earths-surface-using-python
* https://spacetelescope.github.io/spherical_geometry/spherical_geometry/user.html
* https://gist.github.com/sgillies/7e5cd548110a5b4d45ac1a1d93cb17a3
* https://www.dataquest.io/blog/jupyter-notebook-tips-tricks-shortcuts/

# Compétences

* Découper des fichiers de grids et de vectoriels pour faire des tests du des petits volumes
* Lister les resources de données (pour ne pas les mettre dans Git)
* Tester les algos de ~~GRASS~~, GDAL et ~~SAGA~~

# Données de test

## Au large de Boston

* ENC : US4MA13M   
  Dans le zip https://charts.noaa.gov/ENCs/MA_ENCs.zip
* Bathy : http://pubs.usgs.gov/of/2012/1157/GIS_catalog/SourceData/bathy/bathy_30m.zip

### Zone couverte
* La zone couverte est accessible via M_COVR avec CATCOV = 1 (valider qu'il est unique)

### Trait de côte
* Le trait de côte est interompu : il est intermittant. Soit il se superpose à la zone −2,9, ou à la zone 0. Donc en cas, d'interruption, il faut regarder la ligne qui est dessous, et continuer jusqu'à retrouver un autre segment du trait de côte. 
* Une approche alternative est de prendre le trait 0 et de comparer avec la bathy.

# Trucs

## Import de données dans PostGIS
_N'a pas semblé avantageux avec QGIS_
```bash
raster2pgsql -I -C -M -F -t auto ~/win/Documents/local/Bathymap/bathy_30m/navd_bath_30m/w001001.adf | psql -U admin -d gis -h localhost
```

## Création de données OGR

```python
featureDefn = LAYER.GetLayerDefn()
featureDefn.AddFieldDefn(ogr.FieldDefn('NAME', ogr.OFTString))
featureDefn.AddFieldDefn(ogr.FieldDefn('TRUC', ogr.OFTString))

covr_f.SetFieldString(0,'Hello')
covr_f.SetFieldString(1,'World')

LAYER.CreateFeature(covr_f)

DATASOURCE.Destroy()
```

## Reprojection fichier

```
%time x=gdal.VectorTranslate('toto.gpkg', 'data/ENC_ROOT/US4MA13M/US4MA13M.000', options = gdal.VectorTranslateOptions(layers='DEPARE', dstSRS='EPSG:32619'))
del x
```

# Poste de dev

* Ubuntu 20.04 (focal)
* QGIS 3.12 Bucaresti
  * Installé depuis https://qgis.org/ubuntu
  * ```bash
    sudo add-apt-repository https://qgis.org/ubuntu
    sudo apt install qgis qgis-plugin-grass
    ```

 * SAGA 7.3.0
   * Installation à partir des paquets Debian/Ubuntu
 * SAGA 7.6.3 (utilité voir)
   * Installé à partir des sources
   * ```bash
     sudo apt-get install libwxgtk3.0-gtk3-dev libtiff5-dev libgdal-dev libproj-dev libexpat-dev wx-common libogdi-dev unixodbc-dev 
     sudo apt-get install g++ make automake libtool git
     autoreconf -fi
     ./configure # --enable-python et autres fonctionnalités
     make
     ```
   * Algo utiles : http://www.saga-gis.org/saga_tool_doc/7.6.3/index.html
   * Visualiseur inefficace sous VirtualBox

   * Pour l'utiliser depuis QGIS, il semble suffir de mettre `saga_gui` dans le `PATH`.
   * Mais il semble plus simple d'invoquer `saga_cmd`.

 * Wine, pour faire tourner quelques trucs Windows
   * ```bash
     sudo add-apt-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ focal main'
     wget -O - https://dl.winehq.org/wine-builds/winehq.key | sudo apt-key  add -
     sudo apt install --install-recommends winehq-stable

 * Pour faire marche `raster2psql`
   * Installation de Postgis complet et désactivation du service
   * ```
     sudo apt install postgis
     sudo systemctl stop postgresql
     sudo systemctl disable postgresql
     ``` 
# Docker

## PostGIS

C.f. le `docker-compose.yml` du répertoire `docker` 