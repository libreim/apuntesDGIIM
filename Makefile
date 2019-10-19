### CONSTANTS ###

TARGET= apuntes.tar.gz
OUT = .out

TEX_SUBJECTS=$(shell find * -mindepth 1 -maxdepth 1 -name "apuntes.tex" -or -name "ejercicios.tex" -printf "%h\n" | sort | uniq)
MD_SUBJECTS=$(shell find * -mindepth 1 -maxdepth 1 -name "apuntes.md" -or -name "ejercicios.md" -printf "%h\n" | sort | uniq)


### FUNCTIONS ###

template_name = $(1)/$(basename $(notdir $(1))).tex
latex_args = --shell-escape --interaction=nonstopmode -output-directory=$(OUT)/$(strip $(1)) -jobname=$(strip $(1))
pandoc_args = --pdf-engine=xelatex --template $(call template_name, $(1)) --listings --resource-path="$(strip $(1))/:"


$(TARGET): $(TEX_SUBJECTS) $(MD_SUBJECTS)
	cd $(OUT)
	rm -f $(TARGET)
	tar -zcvf $(TARGET) *
	cd ..

.PHONY: $(TEX_SUBJECTS) $(MD_SUBJECTS)

$(TEX_SUBJECTS): % : %/apuntes.tex %/ejercicios.tex
	mkdir -p $(OUT)/$@
	TEXINPUTS="$@/:" pdflatex $(call latex_args, $@) $(call template_name, $@)
	TEXINPUTS="$@/:" pdflatex $(call latex_args, $@) $(call template_name, $@)
	rm -rf $(OUT)/$@/*.log $(OUT)/$@/*.aux $(OUT)/$@/*.toc $(OUT)/$@/*$.out

$(MD_SUBJECTS): % : %/apuntes.md %/ejercicios.md
	mkdir -p $(OUT)/$@
	TEXINPUTS="$@/:" pandoc $(call pandoc_args, $@) $^ -o $(OUT)/$@/$@.pdf

clean:
	rm .out -rf

REPO_DIR=.out-repo/

publish: $(TARGET)
	git clone -b pdf $(git remote get-url origin) $(REPO_DIR)
	cp -r .out/* $(REPO_DIR)
	cd $(REPO_DIR)
	git add *; git add . --all; true
	git commit -m "Compiled PDFs at $(date)"
	git push origin pdf --quiet
	rm -rf $(REPO_DIR)
