require File.expand_path('../../models/author', __FILE__)

module Kindle
  module Annotator
    module Models
      class Authors
        AuthorNotFoundError = Class.new(StandardError)

        include Enumerable

        def initialize(collection)
          @collection = Array(collection)
        end

        def find_by_id(id)
          self.select { |record| record.id == id }.first
        end

        def find_by_id!(id)
          record = self.find_by_id(id)
          raise AuthorNotFoundError.new('Author Not Found') unless record
          record
        end

        def find_by_name(name)
          self.select { |record| record.name == name.to_s }.first
        end

        def find_by_name!(name)
          record = self.find_by_name(name)
          raise AuthorNotFoundError.new('Author Not Found') unless record
          record
        end

        def each(&block)
          authors_collection.each(&block)
        end

        private
        def authors_collection
          @collection.map { |record| Author.new(record) }
        end
      end
    end
  end
end
