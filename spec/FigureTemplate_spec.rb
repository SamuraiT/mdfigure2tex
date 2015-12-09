require 'spec_helper'

describe FigureTemplate do
  let(:template) do
    <<-EOD
# markdown
texの図をレンダーするよ
<%= figure("image_path", {width: 50}, "caption hoge", "label") %>
  ほげ
EOD
  end

  let(:tex_figure) do
    <<-EOD
# markdown
texの図をレンダーするよ

\\begin{figure}[htbp]
\\centering
\\includegraphics[width=50cm]{image_path}
\\caption{caption hoge}
\\label{label}
\\end{figure}

  ほげ
EOD
  end

  it 'has a version number' do
    expect(FigureTemplate::VERSION).not_to be nil
  end

  describe 'figure and render' do
    let(:template) {
      "<%= figure('image_path', \
        {width: 50}, \
        'caption', \
        'label') %>"
    }

    let(:tex_figure) {
      <<-EOD.gsub(/ /, '')

          \\begin{figure}[htbp]
          \\centering
          \\includegraphics[width=50cm]{image_path}
          \\caption{caption}
          \\label{label}
          \\end{figure}
      EOD
    }

    let(:tex_figure_height) {
      <<-EOD.gsub(/ /, '')

          \\begin{figure}[htbp]
          \\centering
          \\includegraphics[width=50cm,height=50cm]{image_path}
          \\caption{caption}
          \\label{label}
          \\end{figure}
      EOD
    }

    context "with width" do
      it 'generate figure correctly' do
        figure = FigureTemplate::Engine::new(template)
        expect(figure.render).to eq(tex_figure)
      end
    end

    context "width height" do
      let(:template){ "<%= figure('image_path', {width: 50, height: 50},'caption', 'label') %>" }

      it 'generate figure correctly' do
        figure = FigureTemplate::Engine::new(template)
        expect(figure.render).to eq(tex_figure_height)
      end
    end
  end

  describe 'render' do
    it 'render' do
      figure = FigureTemplate::Engine::new(template)
      expect(figure.render).to eq(tex_figure)
    end
  end
end
