require File.expand_path('../../models/book', __FILE__)

module Kindle
  module Annotator
    module Models
      class Books
        BookNotFoundError = Class.new(StandardError)

        include Enumerable

        def initialize(collection)
          @collection = Array(collection)
        end

        def each(&block)
          books_collection.each(&block)
        end

        def find_by_id(id)
          self.select { |record| record.id == id }.first
        end
        alias :find_by_asin :find_by_id

        def find_by_id!(id)
          record = self.find_by_id(id)
          raise BookNotFoundError.new('Book Not Found') unless record
          record
        end
        alias :find_by_asin! :find_by_id!

        private
        def books_collection
          @collection.map { |record| Book.new(record) }
        end
      end
    end
  end
end
