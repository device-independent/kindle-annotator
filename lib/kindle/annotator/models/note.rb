module Kindle
  module Annotator
    module Models
      class Note
        include Comparable

        def initialize(attributes={})
          @attributes = attributes
        end

        def <=>(other)
          self.end_location <=> other.end_location
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

        def annotation_id
          @attributes.fetch('annotation_id')
        end

        def annotation
          # TODO: Lookup from the datastore
        end

        def content
          @attributes.fetch('content')
        end

        def end_location
          @attributes.fetch('end_location').to_i
        end
      end
    end
  end
end
