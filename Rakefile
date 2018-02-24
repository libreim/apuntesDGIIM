# coding: utf-8
require_relative "rake_helpers"

task :default => [
       :ac,
       :algi,
       :algii,
       :algo,
       :ami,
       :amii,
       :ec,
       :ed,
       :edf,
       :fbd,
       :fr,
       :geoiii,
       :ies,
       :mc,
       :mmi,
       :pdoo,
       :prob,
       :scd,
       :so,
       :vci,
       # add your task here
     ] do
  TARGET = "apuntes.tar.gz"
  sh "cd .out && rm -f #{TARGET} && tar -zcvf #{TARGET} * && cd .."
end

#------------ Compilation tasks ------------#
# A task must:
#   - Generate a PDF file for each corresponding source (LaTeX, Markdown...) file
#   - Replicate the same directory hierarchy inside the .out/ directory
#   - Place the newly generated PDF file(s) inside .out/, in the same spots the
#     sources hold in the hierarchy
#
# Ways to define a task:
#
#  1. Directly write the commands required:
#       task :example do |t|
#         sh "pdflatex apuntes.tex"
#         sh "mkdir -p .out"
#         sh "mv apuntes.pdf .out/"
#       end
#
#  2. Rely on predefined rules to do the work. Specify the desired output file(s):
#       task :example  => ".out/apuntes.pdf"
#       task :example2 => [".out/uno.pdf", "out/otro.pdf"]
#
#  3. Rely on pdf_for to find the paths to your dependencies:
#       task :example => (pdf_for "apuntes.tex")
#       task :example => (pdf_for FileList["tema*.tex"])
#
#-------------------------------------------#

#task :algoritmica=> (pdf_for Filelist["Algorítmica/Algorítmica.org"])
task :ac => (pdf_for FileList["AC/apuntes.md"])
task :algi => (pdf_for FileList["ALGI/algi.tex"])
task :algii => (pdf_for FileList["ALGII/algii.tex"])
task :algo => (pdf_for FileList["ALGO/apuntes.md"])
task :ami => (pdf_for FileList["AMI/ami.tex", "AMI/resumen.tex"])
task :amii => (pdf_for FileList["AMII/amii.tex"])
task :ec => (pdf_for FileList["EC/apuntes.md"])
task :ed => (pdf_for FileList["ED/apuntes.md"])
task :edf => (pdf_for FileList["EDF/edf.tex"])
task :fbd => (pdf_for FileList["FBD/apuntes.md"])
task :fr => (pdf_for FileList["FR/apuntes.md"])
task :geoiii => (pdf_for FileList["GEOIII/geoiii.tex"])
task :ies => (pdf_for FileList["IES/apuntes.md"])
task :mc => (pdf_for FileList["MC/apuntes.md"])
task :mmi => (pdf_for FileList["MMI/mmi.tex"])
task :pdoo => (pdf_for FileList["PDOO/apuntes.md"])
task :prob => (pdf_for FileList["PROB/prob.tex"])
task :scd => (pdf_for FileList["SCD/apuntes.md"])
task :so => (pdf_for FileList["SO/apuntes.md"])
task :vci => (pdf_for FileList["VCI/Ejercicios.tex"])

# Generating pdfs from Latex sources
rule ".pdf" => ->(f){sources_for f, :tex} do |t|
  begin
    2.times {
        sh %(TEXINPUTS="./#{t.source.split("/")[0...-1].join("/")}:" pdflatex --shell-escape --interaction=nonstopmode "#{t.source}")
    }
  rescue StandardError => e
    puts "\e[31m[ERROR] Couldn't generate #{t.name}\e[m"
  ensure
    out = t.source.split("/").last.sub(".tex", ".pdf")
    unless Dir[out].empty?
      sh %(mkdir -p "#{t.name.split("/")[0...-1].join("/")}";
             mv "#{t.source.split("/").last.sub(".tex", ".pdf")}" "#{t.name}")  
    end 
  end
  sh "rm -f *.log *.aux *.toc *.pdf *.out"
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
