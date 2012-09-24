require 'rspec'
require 'grape'
require 'grape_doc'

Dir["#{File.dirname(__FILE__)}/dummy/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  require 'rspec/mocks'
  require 'rspec/expectations'
  config.include RSpec::Matchers
  config.mock_with :rspec
  config.color_enabled = true
  config.formatter     = 'documentation'
end