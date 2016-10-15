SOURCES_TEX = $(shell find ./ -type f -name '*.tex')
OUTPUT_TEX = $(patsubst ./%.tex, .out/%.pdf, $(SOURCES_TEX))

all: SOURCES_TEX

.out/%.pdf: %.tex
	@mkdir -p "$(@D)"
	pdflatex "$<"
	mv $(basename "$<").pdf "$@"
