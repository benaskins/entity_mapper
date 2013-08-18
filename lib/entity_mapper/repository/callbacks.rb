require 'hooks'

module EntityMapper
  module Repository
    module Callbacks

      def self.included(klass)
        klass.class_eval do
          include Hooks

          define_hooks :before_save, :after_save
        end
      end

    end
  end
end
