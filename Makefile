### CONSTANTS ###

TARGET= apuntes.tar.gz
OUT = .out

TEX_SUBJECTS=$(shell find * -mindepth 1 -maxdepth 1 -name "apuntes.tex" -or -name "ejercicios.tex" -printf "%h\n" | sort | uniq)
MD_SUBJECTS=$(shell find * -mindepth 1 -maxdepth 1 -name "apuntes.md" -or -name "ejercicios.md" -printf "%h\n" | sort | uniq)

TEX_PDFS=$(addprefix $(OUT)/, $(addsuffix .pdf, $(TEX_SUBJECTS)))
MD_PDFS=$(addprefix $(OUT)/, $(addsuffix .pdf, $(MD_SUBJECTS)))

### FUNCTIONS ###

latex_args = --shell-escape --interaction=nonstopmode -output-directory=$(OUT) -jobname=$(strip $(1))
pandoc_args = --pdf-engine=xelatex --template plantilla_md.tex --listings --resource-path="$(strip $(1))/:_assets:"


### RULES ###

# tar build
$(TARGET): $(TEX_PDFS) $(MD_PDFS)
	cd $(OUT)
	rm -f $(TARGET)
	tar -zcvf $(TARGET) *
	cd ..

# individual phony subjects rules
.PHONY: $(TEX_SUBJECTS) $(MD_SUBJECTS)
$(TEX_SUBJECTS) $(MD_SUBJECTS): % : .out/%.pdf

# LaTeX subjects compilation
$(TEX_PDFS): $(OUT)/%.pdf : plantilla_tex.tex %/apuntes.tex %/ejercicios.tex
	mkdir -p $(OUT)
	TEXINPUTS="$*/:_assets:" pdflatex $(call latex_args, $*) plantilla_tex.tex
	TEXINPUTS="$*/:_assets:" pdflatex $(call latex_args, $*) plantilla_tex.tex
	rm -rf $(OUT)/*.log $(OUT)/*.aux $(OUT)/*.toc $(OUT)/*.out

# Markdown subjects compilation
$(MD_PDFS): $(OUT)/%.pdf : plantilla_md.tex %/apuntes.md %/ejercicios.md
	mkdir -p $(OUT)
	TEXINPUTS="$*/:_assets:" pandoc $(call pandoc_args, $*) $*/apuntes.md $*/ejercicios.md -o $@

# Clean output directory
clean:
	rm $(OUT) -rf

# Publish
REPO_DIR=.out-repo/
publish: $(TARGET)
	git clone -b pdf $(git remote get-url origin) $(REPO_DIR)
	cp -r $(OUT)/* $(REPO_DIR)
	cd $(REPO_DIR)
	git add *; git add . --all; true
	git commit -m "Compiled PDFs at $(date)"
	git push origin pdf --quiet
	rm -rf $(REPO_DIR)
