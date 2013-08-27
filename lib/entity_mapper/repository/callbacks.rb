require 'hooks'

module EntityMapper
  module Repository
    module Callbacks

      def self.included(klass)
        klass.class_eval do
          include Hooks

          define_hooks :before_save, :after_save, :before_update, :after_update, :before_create, :after_create
        end
      end

    end
  end
end
