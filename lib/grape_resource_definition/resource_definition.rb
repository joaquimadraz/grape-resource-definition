module Grape
  module ResourceDefinition

    module ClassMethods

      def resource_define(name, &params_block)
        definitions = \
          Grape::ResourceDefinition.defined_resources["#{self}"]

        definitions[name] = params_block
      end

      def define(name)
        definitions = \
          Grape::ResourceDefinition.defined_resources["#{self::RESOURCE_DEFINITION}"]

        if definitions.nil?
          raise NoResourceDefinition, "No resource definition for #{self}"
        end

        if definitions[name].nil?
          raise NoResourceDefined, "':#{name}' is not defined for #{self}"
        end

        self.instance_eval &definitions[name]
      end

    end

    def self.defined_resources
      @defined_resources
    end

    def self.included(other)
      @defined_resources ||= {}
      @defined_resources["#{other}"] = {}

      other.include ClassMethods
      other.extend  ClassMethods
    end

  end
end

module Grape
  class API

    def self.resource_definition(resource_definition_module)
      begin
        self.const_get('RESOURCE_DEFINITION')
      rescue NameError => e
        self.const_set('RESOURCE_DEFINITION', resource_definition_module)
      end

      self.class_eval do
        extend resource_definition_module
      end
    end

  end
end
