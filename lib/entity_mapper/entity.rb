require 'virtus'

module EntityMapper
  module Entity
    def self.included(klass)
      klass.class_eval do
        include ActiveModel::Model
        include Virtus.model
        include Virtus::Equalizer.new(inspect)

        attribute :id, Integer

        def persisted?
          !id.blank?
        end
      end
    end
  end
end
