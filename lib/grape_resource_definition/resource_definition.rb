module Grape
  module ResourceDefinition

    module ClassMethods

      def definitions
        model_name = Grape::ResourceDefinition.get_class_name(self)
        Grape::ResourceDefinition.definitions[model_name]
      end

      def resource_design(name, &params_block)     
        definitions[name] = params_block
      end

      def design(name)
        if definitions.nil?
          raise "No ResourceDefinition defined for #{self}"
        end
        
        if definitions[name].nil?
          raise "Design ':#{name}' if not defined for #{self}"
        end

        self.instance_eval &definitions[name]
      end

    end

    def self.definitions
      @definitions
    end
        
    def self.included(other)
      model_name = get_class_name(other)

      @definitions ||= {}
      @definitions[model_name] = {}

      other.include ClassMethods
      other.extend  ClassMethods
    end

    def self.get_class_name(klass)
      klass.name.split("::")[-1].to_sym  
    end

  end
end

module Grape
  class API

    def self.resource_definition(resource_design_module)
      self.class_eval do
        extend resource_design_module
      end
    end
  
  end
end