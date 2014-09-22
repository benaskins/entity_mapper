module EntityMapper
  module Repository
    module QueryMethods

      def save(entity)
        perform(:save, entity) do |entity|
          entity.persisted? ? update(entity) : create(entity)
        end
      end

      def update(entity)
        perform(:update, entity) do |entity|
          data_store.update entity.id, map_entity_to_model(entity)
        end
      end

      def create(entity)
        perform(:create, entity) do |entity|
          entity.id = data_store.create(map_model_to_entity(entity)).id
        end
      end

      def find(id)
        entity_class.new(map_model_to_entity data_store.find(id)).tap do |e|
          run_hook "after_find", e
        end
      end

      def delete(entity)
        perform(:create, entity) do |entity|
          data_store.delete(entity.id)
        end
      end

      protected
      def data_store
        self.class::DataStore
      end

      def perform(query_method, entity)
        return entity unless entity.valid?
        entity.tap do |e|
          data_store.transaction do
            run_hook "before_#{query_method}", e
            yield e
            run_hook "after_#{query_method}", e
          end
        end
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
