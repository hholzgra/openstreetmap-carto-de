MAPNIK_API = $(shell mapnik-config -v)

TEMPFILE := $(shell mktemp -u)

osm-de.xml: *.mss project-de.mml
	carto -a $(MAPNIK_API) project-de.mml > $(TEMPFILE)
	sed -e's/\[CDATA\[osm\]]/[CDATA[gis]]/g' -e's/planet_osm_/view_osm_/g' < $(TEMPFILE) > $@

project-de.mml: project.yaml *.mss
	scripts/yaml2mml.py --yaml project.yaml --check >project-de.mml

clean:
	rm -f project-de.* osm-de.xml
