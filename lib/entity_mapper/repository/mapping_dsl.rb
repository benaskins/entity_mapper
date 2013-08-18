require 'entity_mapper/repository/attribute_mapping'

module EntityMapper
  module Repository
    module MappingDSL

      def map(attribute_name, options={})
        attribute_mappings << AttributeMapping.new(attribute_name, options)
      end

    end
  end
end

