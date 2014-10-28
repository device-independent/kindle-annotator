module Kindle
  module Annotator
    module Models
      class Annotations
        include Enumerable

        def initialize(collection)
          @collection = Array(collection)
        end
      end
    end
  end
end
