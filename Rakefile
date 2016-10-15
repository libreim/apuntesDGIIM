# coding: utf-8
task :default => [:algebra1]

# Compilation rules
task :algebra1 => [".out/Álgebra I/tema1.pdf"]
task :analisis1 => [".out/Análisis Matemático I/apuntes.pdf",
                    ".out/Análisis Matemático I/resultados.pdf"]
task :ecomputadores => Dir[".out/Estructura de Computadores/*.md"].map(:pdf_for)
task :edatos => [".out/Estructura de datos/tema1.pdf"]
task :sistemas => [".out/Sistemas Operativos/repasoFS.pdf"]

def pdf_for(f)
  ".out/" + f.sub(/.([^.]*?)$/, ".pdf")
end

# Generating pdfs from Latex source
def tex_for(f)
  f.sub(/.out\//, "").sub(/.pdf/, ".tex")
end
     
rule ".pdf" => ->(f){tex_for f} do |t|
  sh %(pdflatex --shell-escape --interaction=nonstopmode "#{t.source}")
  sh %(mkdir -p "#{t.name.split("/")[0...-1].join("/")}")
  sh %(mv "#{t.source.split("/").last.sub(".tex", ".pdf")}" "#{t.name}")
  sh "rm -f *.log *.aux"
end

def sources_for f, type
  f.sub(".out/", "").sub(".pdf", ".#{type}")
end

rule ".pdf" => ->(f){sources_for f, ".md"} do |t|
  sh %(pandoc --latex-engine pdflatex #{t.source} -o #{t.name})
end

task :clean do |t|
  sh "rm .out -rf"
end
