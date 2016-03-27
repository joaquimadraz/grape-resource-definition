require 'spec_helper'

describe Grape::ResourceDefinition do

  module Resources
    module Todos
      include Grape::ResourceDefinition

      resource_define :index do
        desc 'Get all todos',
          http_codes: [
            [200, 'Ok']
          ]
      end

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

  context 'correct defined resource and link with resource_definition' do

    subject do
      class Todos < Grape::API
        resource_definition Resources::Todos

        define :show
        get('/todos/:id') {}
      end

      Todos.new
    end

    let(:defined_resources) do
      Grape::ResourceDefinition.defined_resources
    end

    it 'should have Resources::Todos resource with :show and :index definition' do
      expect(defined_resources).to \
        have_key('Resources::Todos')

      expect(defined_resources['Resources::Todos']).to \
        have_key(:index)

      expect(defined_resources['Resources::Todos']).to \
        have_key(:show)
    end

  end

  context 'correct defined resource but no link with resource_definition' do

    it 'should raise NoMethodError for define :index' do

      expect do
        class Todos < Grape::API
          define :index
          get('/todos/:id') {}
        end
      end.to \
        raise_error(NoMethodError, /undefined method `define'/)

    end

  end

  context 'resource not defined but has link to resource_definition' do

    it 'should raise NoResourceDefined error for define :update' do

      expect do
        class Todos < Grape::API
          resource_definition Resources::Todos

          define :update
          put('/todos/:id') {}
        end
      end.to \
        raise_error(NoResourceDefined, /':update' is not defined for Todos/)

    end

  end

end

