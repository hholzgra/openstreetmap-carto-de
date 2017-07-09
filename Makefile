MAPNIK_API = $(shell mapnik-config -v)

TEMPFILE := $(shell mktemp -u)

osm-de.xml: *.mss project.mml
	sed '/\sname:/d' < project.mml > osm.mml
	carto -a $(MAPNIK_API) osm.mml > $(TEMPFILE)
	sed -e's/\[CDATA\[osm\]]/[CDATA[gis]]/g' -e's/planet_osm_/view_osm_/g' < $(TEMPFILE) > $@

preview-de.png: osm-de.xml
	nik2img.py osm-de.xml -d 850 300 -z 15 -c 11.625 48.106  -fPNG --no-open $@

clean:
	rm -f project-de.* osm-de.xml
