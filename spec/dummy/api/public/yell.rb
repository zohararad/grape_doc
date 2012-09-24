module Api
  module Public
    class Yell < Grape::API

      prefix 'api'
      version 'v1', :using => :path
      format :json

      resource :public do

        resource :yells do

          desc "Return a yell", {:params => {:id => '[Integer] yell ID'}}
          get ':id' do

          end

        end

      end

    end
  end
end