require File.expand_path('../annotations', __FILE__)
require File.expand_path('../authors', __FILE__)

module Kindle
  module Annotator
    module Models
      class Book
        include Comparable

        def initialize(attributes={})
          @attributes = attributes
        end

        def <=>(other)
          self.last_annotated_at <=> other.last_annotated_at
        end

        def id
          @attributes.fetch('id')
        end

        def title
          @attributes.fetch('title')
        end

        def author_ids
          @attributes.fetch('author_ids', [])
        end

        def author_ids?
          self.author_ids.any?
        end

        def authors
          # If we have an explicit `authors` key, then use it.
          # If we don't have an `authors` key, but have `author_ids`, then load them.
          # If we don't have anything, then return an instance of empty Authors collection
        end

        def annotation_ids
          @attributes.fetch('annotation_ids', [])
        end

        def annotation_ids?
          self.annotation_ids.any?
        end

        def annotations
          # If we have an explicit `annotations` key, then use it.
          # If we don't have an `annotations` key, but have `annotation_ids`, then load them.
          # If we don't have anything, then return an instance of empty Authors collection
        end

        def last_annotated_at
          begin
            Date.parse(last_annotated_at_timestamp).to_time.utc
          rescue
            nil
          end
        end

        private
        def last_annotated_at_timestamp
          @attributes.fetch('last_annotated_at')
        end
      end
    end
  end
end
