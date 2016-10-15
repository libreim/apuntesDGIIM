SOURCES=$(wildcard *.tex)
TARGETS=$(addprefix ../.out/, $(addsuffix .pdf, $(basename $(SOURCES))))

default: $(TARGETS)

../.out/%.pdf: %.tex
	pdflatex $<
	mv $(basename $<).pdf $@
