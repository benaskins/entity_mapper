require 'entity_mapper/repository/query_methods'

module EntityMapper
  module Repository

    def self.included(klass)
      klass.class_eval do
        include Singleton
        extend SingletonDelegate

        class_attribute :entity_class, :model_class

        include QueryMethods
      end
    end


    module SingletonDelegate
      extend Forwardable
      def_delegators :instance, :save, :find
    end

  end
end
