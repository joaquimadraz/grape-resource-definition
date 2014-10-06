module Grape
  module ResourceDefinition

    module ClassMethods

      def _designs
        model_name = Grape::ResourceDefinition.get_class_name(self)
        Grape::ResourceDefinition._designs[model_name]
      end

      def resource_design(name, &params_block)     
        _designs[name] = params_block
      end

      def design(name)
        if _designs.nil?
          raise "No ResourceDefinition defined for #{self}"
        end
        
        if _designs[name].nil?
          raise "Design ':#{name}' if not defined for #{self}"
        end

        self.instance_eval &_designs[name]
      end

    end

    def self._designs
      @_designs
    end
        
    def self.included(other)
      model_name = get_class_name(other)

      @_designs ||= {}
      @_designs[model_name] = {}

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