module Kindle
  module Annotator
    module Models
      class Book
        include Comparable

        def initialize(attributes={})
          @attributes = attributes
        end

        def id
          @attributes.fetch('id')
        end
      end
    end
  end
end
