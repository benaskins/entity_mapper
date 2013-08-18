module EntityMapper
  module Repository
    class AttributeMapping

      attr_reader :name, :target

      def initialize(name, options)
        @name = name
        @target = options[:to] || @name
      end

    end
  end
end
