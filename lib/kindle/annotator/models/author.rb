require 'digest/md5'

module Kindle
  module Annotator
    module Models
      class Author
        include Comparable

        def initialize(attributes={})
          @attributes = attributes
        end

        def <=>(other)
          self.name <=> other.name
        end

        def id
          return @id if @id

          internal_id = @attributes['id']

          @id = if internal_id.nil?
            Digest::MD5.hexdigest(self.name)
          else
            internal_id
          end

          @id
        end

        def name
          @attributes.fetch('name')
        end

        def book_ids
          @attributes.fetch('book_ids', [])
        end

        def book_ids?
          self.book_ids.any?
        end

        def books
          return @books if @books

          associated_books = []

          if @attributes.has_key?('books')
            books_collection = @attributes['books']
            associated_books = Books.new(books_collection)
          elsif self.book_ids?
            associated_books = []
          end

          @books = associated_books
          @books
        end

        def books?
          self.books.any?
        end
      end
    end
  end
end
