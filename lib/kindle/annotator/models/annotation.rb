module Kindle
  module Annotator
    module Models
      class Annotation
        include Comparable

        def initialize(attributes={})
          @attributes = attributes
        end

        def id
          return @id if @id

          internal_id = @attributes['id']

          @id = if internal_id.nil?
            Digest::MD5.hexdigest(self.content)
          else
            internal_id
          end

          @id
        end

        def book_id
          @attributes.fetch('book_id')
        end

        def book
          # TODO: Lookup from the datastore
        end

        def location
          @attributes.fetch('location').to_i
        end

        def content
          @attributes.fetch('content')
        end

        def note_ids
          @attributes.fetch('note_ids', [])
        end

        def note_ids?
          self.note_ids.any?
        end
      end
    end
  end
end
