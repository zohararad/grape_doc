module Api
  class Shout < Grape::API
    prefix 'api'
    version 'v1', :using => :path
    format :json

    resource :shouts do

      desc "Returns all shouts"
      get do
        # Do something
      end

      desc "Returns a shout", { :params => { :id => "[Integer] Shout ID" } }
      get ':id' do
        # Do something
      end

      desc "Create a shout", { :params => {:shout => '[String] Shout to create', :voice => {:sound => '[String] Sound to play (male|female)', :pitch => '[Integer] Pitch Level'}}}
      post do
        # Do something
      end

      desc "Update a shout", { :params => { :id => "[Integer] Shout ID", :shout => "[String] Shout to update" }, :optional_params => { :owner => '[Integer] Shout owner ID'} }
      put ':id' do
        # Do something
      end
    end

    #mount Api::Public::Yell
  end
end