# coding: utf-8
task :default => [:algebra1]
task :algebra1 => [".out/Álgebra I/tema1.pdf"]

def tex_for(f)
  f.sub(/.out\//, "").sub(/.pdf/, ".tex")
end
     
rule ".pdf" => ->(f){tex_for f} do |t|
  `pdflatex --shell-escape --interaction=nonstopmode "#{t.source}"`
  `mkdir -p "#{t.name.split("/")[0...-1].join("/")}"`
  `mv "#{t.source.split("/").last.sub(".tex", ".pdf")}" "#{t.name}"`
end
