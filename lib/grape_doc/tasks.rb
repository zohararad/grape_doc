require 'grape_doc'
require 'grape'

namespace :grape do

  desc "Document your Grape API"
  task :doc do
    print "API Resources Path [lib/api]: "
    path = STDIN.gets.chomp
    print "Output Format (markdown/html) [markdown]: "
    format = STDIN.gets.chomp
    output = ''
    if format == 'html'
      print "Output Directory [public/api]: "
      output = STDIN.gets.chomp
    end
    options = {
      :format => (format.empty? ? 'markdown' : format),
      :path => (path.empty? ? 'lib/api' : path),
      :output => (output.empty? ? 'public/api' : output)
    }
    base_dir = File.expand_path('.', options[:path])
    parser = GrapeDoc::Parser.new base_dir
    parser.build_routes

    if options[:format] == 'markdown'
      parser.resources_as_markdown
    elsif options[:format] == 'html'
      parser.resources_as_html(options[:output])
    end

  end

end