# coding: utf-8

# Helper functions
def pdf_for(f)
  ".out/" + f.sub(/.([^.]*?)$/, ".pdf")
end

def sources_for f, type
  f.sub(".out/", "").sub(".pdf", ".#{type}")
end

def pandoc_rule *inputs
  # Generate PDFs from several sources with pandoc
  inputs.each do |i|
    rule ".pdf" => ->(f){sources_for f, i} do |t|
      begin
        sh %(mkdir -p "#{t.name.split("/")[0...-1].join("/")}")
        sh %(pandoc --latex-engine pdflatex "#{t.source}" -o "#{t.name}")
      rescue StandardError => e
        puts "\e[31m[ERROR] Couldn't generate #{t.name}\e[m"
      end
    end
  end
end

task :default => [:algebra1, :analisis1, :ecomputadores, :edatos, :sistemas]

# Compilation rules
task :algebra1 => [".out/Álgebra I/tema1.pdf"]
task :analisis1 => [".out/Análisis Matemático I/apuntes.pdf",
                    ".out/Análisis Matemático I/resultados.pdf",
                    ".out/Análisis Matemático I/ejercicios.pdf"]
task :ecomputadores => Dir["Estructura de Computadores/*.md"].map {|f| pdf_for f}
task :edatos => FileList["Estructura de datos/*.tex", "Estructura de datos/*.md"].map {|f| pdf_for f}

task :sistemas => FileList["Sistemas Operativos/repasoFS.md", "Sistemas Operativos/Prácticas/Modulo2/LlamadasSistema.md"].map {|f| pdf_for f}

# Generating pdfs from Latex sources
rule ".pdf" => ->(f){sources_for f, :tex} do |t|
  begin
    2.times { sh %(pdflatex --shell-escape --interaction=nonstopmode "#{t.source}") }
    sh %(mkdir -p "#{t.name.split("/")[0...-1].join("/")}")
    sh %(mv "#{t.source.split("/").last.sub(".tex", ".pdf")}" "#{t.name}")
    sh "rm -f *.log *.aux"
  rescue StandardError => e
    puts "\e[31m[ERROR] Couldn't generate #{t.name}\e[m"
  end
end

pandoc_rule :md, :org

task :clean do |t|
  sh "rm .out -rf"
end

task :publish => :default do |t|
  # Might refactor this to use the git gem
  repo_dir = ".out-repo/"
  begin
    sh %[git clone -b pdf $(git remote get-url origin) #{repo_dir}]
    sh %[cp -r .out/* #{repo_dir}]
    Dir.chdir repo_dir
    # sh %[git ls-files --deleted -z | xargs -0 git rm]
    sh %[git add *; git add . --all; true]
    sh %[git commit -m "Compiled PDFs at $(date)"]
    sh %[git push origin pdf --quiet]
  rescue StandardError => e
    puts "\e[31m[ERROR] #{e.message}\e[m"
  end
  sh %[rm -rf #{repo_dir}]
end
