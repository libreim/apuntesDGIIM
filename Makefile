SHELL := /bin/bash
YARN := yarn
VENDOR_DIR = assets/vendor
JEKYLL := jekyll

PROJECT_DEPS := package.json

.PHONY: all clean install update

all : serve

check:
	$(JEKYLL) doctor
	$(HTMLPROOF) --check-html \
		--http-status-ignore 999 \
		--internal-domains localhost:4000 \
		--assume-extension \
		_site

install: $(PROJECT_DEPS)
	$(YARN) install

update: $(PROJECT_DEPS)
	$(YARN) upgrade

include-yarn-deps:
	mkdir -p $(VENDOR_DIR)/
	mkdir -p $(VENDOR_DIR)/bootstrap/scss
	cp node_modules/jquery/dist/jquery.min.js $(VENDOR_DIR)/
	cp node_modules/bootstrap/dist/js/bootstrap.bundle.js $(VENDOR_DIR)/
	cp node_modules/bootstrap/dist/js/bootstrap.bundle.js.map $(VENDOR_DIR)/
	cp -r node_modules/bootstrap/scss/* $(VENDOR_DIR)/bootstrap/scss

build: install include-yarn-deps
	$(JEKYLL) build

serve: install include-yarn-deps
	JEKYLL_ENV=production $(JEKYLL) serve