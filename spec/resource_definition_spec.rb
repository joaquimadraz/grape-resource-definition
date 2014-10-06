require 'pry'
require 'spec_helper'

describe Grape::ResourceDefinition do 

  module Resources
    module Todos
      
      include Grape::ResourceDefinition

      resource_define :show do          
        desc 'Get a todo by id', 
          http_codes: [
            [200, 'Ok'],
            [404, 'Not Found']
          ]

        params do
          requires :id, type: Integer
        end
      end
    
    end
  end

  class Todos < Grape::API
    resource_definition Resources::Todos
    resource :todos do
      
      define :show
      get '/:id' do
        { id: params[:id] }
      end

    end
  end

end

