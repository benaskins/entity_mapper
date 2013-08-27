module EntityMapper
  module Repository
    module QueryMethods

      def save(entity)
        entity.tap do |e|
          data_store.transaction do
            run_hook :before_save, e
            e.persisted? ? update(e) : create(e)
            run_hook :after_save, e
          end
        end
      end

      def update(entity)
        entity.tap do |e|
          data_store.transaction do
            run_hook :before_update
            data_store.update e.id, map_entity_to_model(e)
            run_hook :after_update
          end
        end
      end

      def create(entity)
        entity.tap do |e|
          data_store.transaction do
            run_hook :before_create
            e.id = data_store.create(map_model_to_entity(e)).id
            run_hook :after_create
          end
        end
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
