IsoBath
=======

Construction d'isobath en fonction de contraintes diverses à partir d'un grid bathymétrique

# Compétences

* Découper des fichiers de grids et de vectoriels pour faire des tests du des petits volumes
* Lister les resources de données (pour ne pas les mettre dans Git)
* Tester les algos de GRASS, GDAL et SAGA

# Données de test

## Au large de Boston

* ENC : US4MA13M   
  Dans le zip https://charts.noaa.gov/ENCs/MA_ENCs.zip
* Bathy : http://pubs.usgs.gov/of/2012/1157/GIS_catalog/SourceData/bathy/bathy_30m.zip

La zone couverte est accessible via M_COVR avec CATCOV = 1 (valider qu'il est unique)


# Trucs

## Import de données dans PostGIS
_N'a pas semblé avantageux avec QGIS_
```bash
raster2pgsql -I -C -M -F -t auto ~/win/Documents/local/Bathymap/bathy_30m/navd_bath_30m/w001001.adf | psql -U admin -d gis -h localhost
```

# Poste de dev

* Ubuntu 20.04 (focal)
* QGIS 3.12 Bucaresti
  * Installé depuis https://qgis.org/ubuntu
  * ```bash
    sudo add-apt-repository https://qgis.org/ubuntu
    sudo apt update
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