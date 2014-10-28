require File.expand_path('../../models/note', __FILE__)

module Kindle
  module Annotator
    module Models
      class Notes
        NoteNotFoundError = Class.new(StandardError)

        include Enumerable

        def initialize(collection)
          @collection = Array(collection)
        end

        def each(&block)
          notes_collection.each(&block)
        end

        def find_all_by_annotation_id(annotation_id)
          self.select { |record| record.annotation_id == annotation_id.to_s }
        end

        def find_by_id(id)
          self.select { |record| record.id == id.to_s }.first
        end

        def find_by_id!(id)
          record = self.find_by_id(id)
          raise NoteNotFoundError.new('Note Not Found') unless record
          record
        end

        private
        def notes_collection
          @collection.map { |record| Note.new(record) }
        end
      end
    end
  end
end
