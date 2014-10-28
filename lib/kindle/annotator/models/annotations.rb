require File.expand_path('../../models/annotation', __FILE__)

module Kindle
  module Annotator
    module Models
      class Annotations
        AnnotationNotFoundError = Class.new(StandardError)

        include Enumerable

        def initialize(collection)
          @collection = Array(collection)
        end

        def each(&block)
          annotations_collection.each(&block)
        end

        def find_by_id(id)
          self.select { |record| record.id == id.to_s }.first
        end

        def find_by_id!(id)
          record = self.find_by_id(id)
          raise AnnotationNotFoundError.new('Annotation Not Found') unless record
          record
        end

        def find_all_by_book_id(book_id)
          self.select { |record| record.book_id == book_id.to_s }
        end

        private
        def annotations_collection
          @collection.map { |record| Annotation.new(record) }
        end
      end
    end
  end
end
