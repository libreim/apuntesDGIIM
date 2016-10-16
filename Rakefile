# coding: utf-8
require_relative "rake_helpers"

task :default => [:algebra1, :analisis1, :ecomputadores, :edatos, :sistemas]

# Compilation tasks
task :algebra1 => (pdf_for "Álgebra I/tema1.tex")
task :analisis1 => (pdf_for FileList["Análisis Matemático/*.tex"])
task :ecomputadores => (pdf_for Dir["Estructura de Computadores/*.md"])
task :edatos => (pdf_for FileList["Estructura de datos/*.tex", "Estructura de datos/*.md"])
task :sistemas => (pdf_for "Sistemas Operativos/repasoFS.md", "Sistemas Operativos/Prácticas/Modulo2/LlamadasSistema.md")

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
