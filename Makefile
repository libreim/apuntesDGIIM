TARGET= apuntes.tar.gz
OUT = .out

UNAME := $(shell uname)

ifeq ($(UNAME), Linux)
	FIND := find
endif
ifeq ($(UNAME), Darwin)
	FIND := gfind
endif

SUBJECTS=$(shell $(FIND) * -mindepth 1 -maxdepth 1 -name "apuntes.*" -printf "%h\n")
PDFS=$(addprefix $(OUT)/, $(addsuffix .pdf, $(SUBJECTS)))


# tar build
$(OUT)/$(TARGET): $(PDFS)
	tar -C $(OUT) -zcvf $@ $(notdir $^)


# individual phony subjects rules
.PHONY: $(SUBJECTS) clean publish
$(SUBJECTS): % : .out/%.pdf


# LaTeX compilation
latex_args = --shell-escape --interaction=nonstopmode -output-directory=$(OUT) -jobname=$(strip $(1))
$(OUT)/%.pdf: plantilla_tex.tex %/apuntes.tex %/ejercicios.tex
	mkdir -p $(OUT)
	TEXINPUTS="$*/:_assets:" pdflatex $(call latex_args, $*) plantilla_tex.tex
	TEXINPUTS="$*/:_assets:" pdflatex $(call latex_args, $*) plantilla_tex.tex
	rm -rf $(OUT)/*.log $(OUT)/*.aux $(OUT)/*.toc $(OUT)/*.out


# Markdown compilation
pandoc_args = --pdf-engine=lualatex --template plantilla_md.tex --listings --resource-path="$(strip $(1))/:_assets:"
$(OUT)/%.pdf: plantilla_md.tex %/apuntes.md %/ejercicios.md
	mkdir -p $(OUT)
	TEXINPUTS="$*/:_assets:" pandoc $(call pandoc_args, $*) $*/apuntes.md $*/ejercicios.md -o $@


# clean output directory
clean:
	rm -rf $(OUT)


# publish in repository
REPO_DIR=.out-repo/
publish: $(PDFS)
	git clone -b pdf $(git remote get-url origin) $(REPO_DIR)
	cp -r $(OUT)/* $(REPO_DIR)
	cd $(REPO_DIR)
	git add *; git add . --all; true
	git commit -m "Compiled PDFs at $(date)"
	git push origin pdf --quiet
	rm -rf $(REPO_DIR)
