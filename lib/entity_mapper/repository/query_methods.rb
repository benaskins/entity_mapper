module EntityMapper
  module Repository
    module QueryMethods

      def save(entity)
        entity.tap do |e| 
          run_hook :before_save, e
          e.persisted? ? update(e) : create(e)
          run_hook :after_save, e
        end
      end

      def update(entity)
        data_store.update entity.id, map_entity_to_model(entity)
      end

      def create(entity)
        entity.id = data_store.create(map_model_to_entity(entity)).id
      end

      def find(id)
        entity_class.new(map_model_to_entity data_store.find(id))
      end

      protected
      def data_store
        self.class::DataStore
      end

      def map_entity_to_model(entity)
        attribute_mappings.inject({}) do |map, attribute_mapping|
          map[attribute_mapping.name] = entity.send(attribute_mapping.target)
          map
        end
      end

      def map_model_to_entity(model)
        attribute_mappings.inject({:id => model.id}) do |map, attribute_mapping|
          map[attribute_mapping.target] = model.send(attribute_mapping.name)
          map
        end
      end
    end
  end
end
