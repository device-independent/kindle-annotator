module Kindle
  module Annotator
    module Models
      class Note
        include Comparable

        def initialize(attributes={})
          @attributes = attributes
        end

        def id
          @attributes.fetch('id')
        end

        def annotation_id
          @attributes.fetch('annotation_id')
        end
      end
    end
  end
end
