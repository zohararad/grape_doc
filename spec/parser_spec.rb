require 'spec_helper'

describe GrapeDoc::Parser do

  before :all do
    @base_dir = File.join(File.dirname(__FILE__),'dummy','api')
    @parser = GrapeDoc::Parser.new @base_dir
  end

  it 'should find API base module' do
    @parser.base_module.to_s.should == 'Api'
  end

  it 'should find API class definitions' do
    resources = @parser.api_classes.collect {|r| r[:resource] }.flatten
    resources.include?(Api::Shout).should == true
    resources.include?(Api::Public::Yell).should == true
  end

  it 'should parse route information for API classes' do
    @parser.build_routes
    h = @parser.routes['Api::Shout'][:routes].first
    GrapeDoc::Parser::ROUTE_METHODS.each do |m|
      h.keys.include?(m.to_sym).should == true
    end
    settings = h[:settings]
    settings.keys.include?(:version_options).should == true
  end

  it 'should generate Markdown files per resource' do
    @parser.resource_as_markdown
    Dir["#{@base_dir}/**/*.md"].size.should > 0
  end

end