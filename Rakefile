# coding: utf-8
task :default => [:algebra1]
task :algebra1 => [".out/Álgebra I/tema1.pdf"]

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
