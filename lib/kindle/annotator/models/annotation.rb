module Kindle
  module Annotator
    module Models
      class Annotation
        include Comparable

        def initialize(attributes={})
          @attributes = attributes
        end

        def <=>(other)
          self.book_id <=> other.book_id
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

        def notes
          return @notes if @notes

          associated_notes = []

          if @attributes.has_key?('notes')
            notes_collection = @attributes['notes']
            associated_notes = Notes.new(notes_collection)
          elsif self.note_ids?
            associated_notes = []
          end

          @notes = associated_notes
          @notes
        end
      end
    end
  end
end
