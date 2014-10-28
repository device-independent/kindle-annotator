require 'spec_helper'

describe Kindle::Annotator::Models::Note do
  let(:notes_file) do
    File.read(File.expand_path('../../../data/notes.json', __FILE__))
  end

  let(:record) do
    MultiJson.load(notes_file).first
  end

  subject { described_class.new(record) }

  context "with valid attributes" do
    describe "#id" do
      it "returns the provided #id" do
        expect(subject.id).to eq('poiu')
      end

      it "builds a checksum of the content as the #id if nil" do
        record['content'] = 'I am a note'
        record['id'] = nil

        expect(subject.id).to eq('6307b3fd2428fb444452c93879890981')
      end

      it "builds a checksum of the content as the #id if no key" do
        record['content'] = 'I am a note'
        record.delete('id')

        expect(subject.id).to eq('6307b3fd2428fb444452c93879890981')
      end
    end

    it "returns the associated #annotation_id" do
      expect(subject.annotation_id).to eq('a2NACTKU52LI4P')
    end

    it "returns the #end_location" do
      expect(subject.end_location).to eq(49277)
    end

    it "returns the #content" do
      content = "First internal note"
      expect(subject.content).to eq(content)
    end
  end
end
