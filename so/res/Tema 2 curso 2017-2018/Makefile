# Uso esta plantilla para hacer el pdf
# https://github.com/Wandmalfarbe/pandoc-latex-template
# Hace falta tener instalado Pandoc y LaTex

OUT="pdf"
TEMP="templates/eisvogel.latex"
sources = Tema_2_Procesos_e_Hilos.md

all: $(OUT)/Tema2.pdf

$(OUT)/Tema2.pdf : $(sources)
	pandoc \
		--from markdown --template $(TEMP) \
		--listing \
		-f markdown $^ \
		--latex-engine=xelatex \
		-o $@

clean:
	rm -f $(OUT)/*
