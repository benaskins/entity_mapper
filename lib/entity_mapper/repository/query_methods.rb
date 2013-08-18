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
        model_class.update entity.id, map_entity_to_model(entity)
      end

      def create(entity)
        entity.id = model_class.create(map_model_to_entity(entity)).id
      end

      def find(id)
        entity_class.new(map_model_to_entity model_class.find(id))
      end
    end
  end
end
