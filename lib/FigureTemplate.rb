require "FigureTemplate/version"
require 'erb'

module FigureTemplate
  class Engine
    include ERB::Util
    attr_accessor :template

    def initialize(template)
      @template = template
    end

    def render()
      ERB.new(@template).result(binding)
    end

    def save(file)
      File.open(file, "w+") do |f|
        f.write(render)
      end
    end

    def figure(image_path, size, caption, label)
      <<-EOD.gsub(/ /, '')

        \\begin{figure}[htbp]
        \\centering
        \\includegraphics[width=#{size[:width]}cm]{#{image_path}}
        \\caption{#{caption}}
        \\label{#{label}}
        \\end{figure}
      EOD
    end

    def self.readfile
      template = ARGV.first
      Figure.new(template)
    end
  end
end
