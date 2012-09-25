require 'erb'
require 'json'
require 'uri'

module GrapeDoc
  class Parser

    attr_reader :base_module, :api_classes, :routes

    ROUTE_METHODS = %w(route_prefix route_version route_namespace route_method route_path route_params route_description)

    def initialize(base_dir)
      @base_module_name = File.basename(base_dir).split(/[\W_-]/).map(&:capitalize).join
      @base_module = nil
      @base_dir = base_dir
      @api_classes = []
      cleanup
      include_api_resources
    end

    def build_routes
      @routes = {}
      callbacks = ROUTE_METHODS
      @api_classes.each do |c|
        resource = c[:resource]
        key = resource.to_s
        @routes[key] ||= {
          :path => c[:path],
          :routes => [],
          :format => resource.format
        }
        resource.endpoints.each do |endpoint|
          route = endpoint.routes.first
          options = endpoint.options
          settings = {}
          endpoint.settings.stack.each do |s|
            settings.merge! s
          end
          next if settings[:namespace].nil? || settings[:namespace].empty?
          h = {:settings => settings}
          callbacks.each do |cb|
            h[cb.to_sym] = route.send cb.to_sym
          end
          h[:route_path].gsub! /\(\.\:format\)/, '.%s' % resource.format.to_s
          h[:route_path].gsub! /\:version/, h[:route_version]
          required = (options[:route_options][:params] ? options[:route_options][:params].dup : {})
          optional = (options[:route_options][:optional_params] ? options[:route_options][:optional_params].dup : {})
          all = required.merge(optional)

          h[:params] = {
            :required => required,
            :optional => optional,
            :all => prepare_mock_params(all)
          }
          @routes[key][:routes] << h
        end
      end
    end

    def resource_as_markdown
      resources_template = File.read(File.join(File.dirname(__FILE__),'templates','resource.erb'))
      @routes.each do |resource, config |
        next unless config[:routes].any?
        @resource = resource
        @resource_routes = config[:routes]
        template = ERB.new(resources_template, 0, '<>')
        md = template.result(binding)
        path = File.dirname(config[:path])
        File.open(File.join(path,'README.md'),'a') do |f|
          f.write(md)
        end
      end
    end

    def partial(options)
      partial_template = File.read(File.join(File.dirname(__FILE__),'templates','_%s.erb' % options[:template]))
      @locals = options[:locals]
      template = ERB.new(partial_template, 0, '<>')
      template.result(binding).gsub /\n{2}/, "\n"
    end

    private

    def include_api_resources
      files = Dir["#{@base_dir}/**/*.rb"]
      files = files.map { |file| [file.count("/"), file] }
      files = files.sort.map { |file| file[1] }
      files.each { |f|
        require f
        add_api_class f
      }
    end

    def add_api_class(path)
      parts = path.sub(@base_dir, '')[1...-3].split('/')
      c = parts.collect{|s| "const_get('#{s.capitalize}')" }.join('.')
      @base_module ||= Kernel.const_get @base_module_name
      @api_classes << {:resource => @base_module.instance_eval(c), :path => path}
    end

    def prepare_mock_params(params)
      h = {
        :Integer => 12,
        :Float => 3.5,
        :String => 'A String',
        :Array => [1,2,3],
        :Hash => {:a => 1, :b => 2},
        :JSON => {:a =>1, :b => 2}.to_json,
        :Date => Time.now.strftime('%Y-%m-%d'),
        :DateTime => Time.now.strftime('%Y-%m-%d %H:%M:%s'),
        :ISODate => Time.now.strftime('%FT%X.%LZ'),
        :ObjectId => '5011133611f1af2dfc0000f7'
      }
      params.each do |k,v|
        if v.is_a? Hash
          params[k] = prepare_mock_params(v.dup)
        elsif v.is_a? Array
          params[k] = v.collect{ |val| prepare_mock_params(val.dup) }
        else
          optional_match = v.match /\(([\w\s\|]+)\)/
          if optional_match != nil
            params[k] = optional_match[1].split('|').sample
          else
            type_match = v.match /\[(\w+)\]/
            unless type_match.nil?
              params[k] = h[type_match[1].to_sym]
            end
          end
        end
      end
      return params
    end

    def cleanup
      Dir["#{@base_dir}/**/*.md"].each do |f|
        File.delete f
      end
    end
  end
end
