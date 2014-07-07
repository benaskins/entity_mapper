require 'entity_mapper/repository/query_methods'
require 'entity_mapper/repository/callbacks'
require 'entity_mapper/repository/mapping_dsl'

module EntityMapper
  module Repository

    def self.included(klass)
      klass.class_eval do
        include Singleton
        extend SingletonDelegate

        class_attribute :attribute_mappings, :entity_class

        self.attribute_mappings = []

        include QueryMethods
        include Callbacks
        extend MappingDSL
      end
    end


    module SingletonDelegate
      extend Forwardable
      def_delegators :instance, :save, :find, :map_model_to_entity
    end

  end
end
