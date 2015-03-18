module Grape
  module ResourceDefinition

    module ClassMethods

      def definitions
        model_name = Grape::ResourceDefinition.get_class_name(self)
        Grape::ResourceDefinition.defined_resources[model_name]
      end

      def resource_define(name, &params_block)
        definitions[name] = params_block
      end

      def define(name)
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
      model_name = get_class_name(other)

      @defined_resources ||= {}
      @defined_resources[model_name] = {}

      other.include ClassMethods
      other.extend  ClassMethods
    end

    def self.get_class_name(klass)
      "#{klass.name}".gsub('::Resources', '').to_sym
    end

  end
end

module Grape
  class API

    def self.resource_definition(resource_definition_module)
      self.class_eval do
        extend resource_definition_module
      end
    end

  end
end
