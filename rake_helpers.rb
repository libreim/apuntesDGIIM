# coding: utf-8

@error_log = []

#------------ Helper functions ------------#

# pdf_for: Finds the paths of the target pdf files for a source code file
#   Arguments:
#     files: one or several filenames, or an array of filenames
#   Outputs: an array of paths to the targeted pdf files
def pdf_for *files
  files.flatten.map do |f|
    ".out/" + f.sub(/.([^.]*?)$/, ".pdf")
  end
end

# sources_for: finds the path of the source file for a given pdf file and filetype
#   Arguments:
#     f: path to the pdf file
#     type: extension of the source file
#   Outputs: the path of the source file
def sources_for f, type
  f.sub(".out/", "").sub(".pdf", ".#{type}")
end

# pandoc_rule: generates rules where pandoc handles the conversion to pdf
#   Arguments: one or several file extensions
def pandoc_rule *inputs
  # Generate PDFs from several sources with pandoc
  inputs.each do |i|
    rule ".pdf" => ->(f){sources_for f, i} do |t|
      begin
        dir = t.name.split("/")[-2]
        template_name = dir.downcase + ".tex"
        sh %(mkdir -p "#{t.name.split("/")[0...-1].join("/")}")
        Dir.chdir dir
        sh %(pandoc --latex-engine pdflatex apuntes.md ejercicios.md --template #{template_name} -o #{"../"+t.name.sub("apuntes", dir.downcase)} --listings)
      rescue StandardError => e
        @error_log << "\e[31mNo se pudo generar #{t.name}\e[m"
      ensure
        Dir.chdir ".."
      end

    end
  end
end

