# IsoBath

Construction d'isobath en fonction de contraintes diverses à partir d'un grid bathymétrique

## Compétences

* Découper des fichiers de grids et de vectoriels pour faire des tests du des petits volumes
* Lister les resources de données (pour ne pas les mettre dans Git)
* Tester les algos de GRASS, GDAL et SAGA

## Code à écrire
* 

## Poste de dev

* Ubuntu 20.04 (focal)
* QGIS 3.12 Bucaresti
  * Installé depuis https://qgis.org/ubuntu
  * ```bash
    sudo add-apt-repository https://qgis.org/ubuntu
    sudo apt update
    sudo apt install qgis qgis-plugin-grass
    ```

 * SAGA 7.6.3 (à voir)
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
