## VARIABLES ##

# Output .tar.gz
TARGET= apuntes.tar.gz

# Output directory
OUT = .out
OUT_AUX = $(OUT)/.aux

# Templates
TEX_TEMPLATE=plantilla_tex.tex
MD_TEMPLATE=plantilla_md.tex

# Continuous compilation option
ifeq ($(CONT), true)
	CONTARG = -pvc
else
	CONTARG =
endif


# Use gfind in macOS
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
.PRECIOUS: $(PDFS)
$(SUBJECTS): % : $(OUT)/%.pdf


# LaTeX compilation
latex_args = -pdf --shell-escape --interaction=nonstopmode -output-directory=$(OUT_AUX) -halt-on-error -file-line-error -jobname=$(1)
$(OUT)/%.pdf: $(TEX_TEMPLATE) %/config.sty %/apuntes.tex %/ejercicios.tex
	mkdir -p $(OUT_AUX)
	mkdir -p $(OUT)
	TEXINPUTS="$*:_assets:" latexmk $(call latex_args,$*) $(CONTARG) $(TEX_TEMPLATE)
	mv $(OUT_AUX)/*.pdf $(OUT)

ifneq ($(KEEP_AUX), true)
	rm -rf $(OUT_AUX)
endif


# Markdown compilation
pandoc_args = --pdf-engine=lualatex --template $(MD_TEMPLATE) --listings --resource-path="$(1):_assets:"
$(OUT)/%.pdf: $(MD_TEMPLATE) %/config.sty %/apuntes.md %/ejercicios.md
	mkdir -p $(OUT)
	TEXINPUTS="$*:_assets:" pandoc $(call pandoc_args,$*) $*/apuntes.md $*/ejercicios.md -o $@


# clean output directory
clean:
	latexmk -C -output-directory=$(OUT) *

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
