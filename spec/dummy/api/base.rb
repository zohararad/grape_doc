require File.join(File.dirname(__FILE__),'shout')
require File.join(File.dirname(__FILE__),'ping')
module Api
  class Base < Grape::API
    prefix 'api'
    version 'v1', :using => :path
    format :json

    mount Api::Shout
    mount Api::Ping
  end
end