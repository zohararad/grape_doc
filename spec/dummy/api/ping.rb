module Api
  class Ping < Grape::API
    prefix 'api'
    version 'v1', :using => :path
    format :json

    resource :pings do

      desc "Returns all pings"
      get do
        # Do something
      end

      desc "Returns a ping", { :params => { :id => "[Integer] Ping ID" } }
      get ':id' do
        # Do something
      end

    end

    #mount Api::Public::Yell
  end
end