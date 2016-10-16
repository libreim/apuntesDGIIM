# coding: utf-8

# Helper functions
def pdf_for *files
  files.map do |f|
    ".out/" + f.sub(/.([^.]*?)$/, ".pdf")
  end
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

