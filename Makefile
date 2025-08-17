.EXPORT_ALL_VARIABLES:
_BARF_DOMAIN = https://ivaylokuzev.eu
_BARF_FEED_TITLE = Ivaylo Kuzev posts feed
_BARF_FEED_DESCRIPTION = El Feed oficial de Ivaylo Kuzev
_BARF_FEED_AUTHOR = Ivaylo Kuzev

build:
	sh ./barf
	rsync -r public/ build/public

deploy: build
	rsync -rv --exclude='**/*.swp' build/ /var/www/ivaylokuzev.eu

clean:
	rm -rf build/*

watch:
	while true; do \
	ls -d .git/* * posts/* pages/* header.html | entr -cd make ;\
	done

.PHONY: build deploy clean watch
