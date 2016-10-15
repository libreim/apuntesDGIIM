# coding: utf-8

# Helper functions
def pdf_for(f)
  ".out/" + f.sub(/.([^.]*?)$/, ".pdf")
end

def sources_for f, type
  f.sub(".out/", "").sub(".pdf", ".#{type}")
end

task :default => [:algebra1, :analisis1, :ecomputadores, :edatos, :sistemas]

# Compilation rules
task :algebra1 => [".out/Álgebra I/tema1.pdf"]
task :analisis1 => [".out/Análisis Matemático I/apuntes.pdf",
                    ".out/Análisis Matemático I/resultados.pdf",
                    ".out/Análisis Matemático I/ejercicios.pdf"]
task :ecomputadores => Dir["Estructura de Computadores/*.md"].map {|f| pdf_for f}
task :edatos => FileList["Estructura de datos/*.tex", "Estructura de datos/*.md"].map {|f| pdf_for f}

task :sistemas => [".out/Sistemas Operativos/repasoFS.pdf"]

# Generating pdfs from Latex sources
rule ".pdf" => ->(f){sources_for f, :tex} do |t|
  sh %(pdflatex --shell-escape --interaction=nonstopmode "#{t.source}")
  sh %(mkdir -p "#{t.name.split("/")[0...-1].join("/")}")
  sh %(mv "#{t.source.split("/").last.sub(".tex", ".pdf")}" "#{t.name}")
  sh "rm -f *.log *.aux"
end

# Generate PDFs from Markdown sources with pandoc
rule ".pdf" => ->(f){sources_for f, :md} do |t|
  sh %(mkdir -p "#{t.name.split("/")[0...-1].join("/")}")
  sh %(pandoc --latex-engine pdflatex "#{t.source}" -o "#{t.name}")
end

# Generate PDFs from Org-Mode sources with pandoc
rule ".pdf" => ->(f){sources_for f, :org} do |t|
  sh %(mkdir -p "#{t.name.split("/")[0...-1].join("/")}")
  sh %(pandoc --latex-engine pdflatex "#{t.source}" -o "#{t.name}")
end

task :clean do |t|
  sh "rm .out -rf"
end
