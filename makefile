#SAVEIFS=$IFS
#IFS=$(echo -en "\n\b")
SOURCES_TEX = $(find ./ -type f -name '*.tex' -exec echo "\"{}\"" \;)
OUTPUT_TEX = $(patsubst ./%.tex, .out/%.pdf, $(SOURCES_TEX))

all: $(OUTPUT_TEX)

.out/%.pdf: %.tex
	@mkdir -p "$(@D)"
	pdflatex "$<"
	mv $(basename "$<").pdf "$@"

# IFS=$SAVEIFS