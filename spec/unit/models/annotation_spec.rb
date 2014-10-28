require 'spec_helper'

describe Kindle::Annotator::Models::Annotation do
  let(:annotations_file) do
    File.read(File.expand_path('../../../data/annotations.json', __FILE__))
  end

  let(:record) do
    MultiJson.load(annotations_file).first
  end

  subject { described_class.new(record) }

  context "with valid attributes" do
    describe "#id" do
      it "returns the provided #id" do
        expect(subject.id).to eq('vbfgh')
      end

      it "builds a checksum of the content as the #id if nil" do
        record['content'] = 'Here is the content'
        record['id'] = nil

        expect(subject.id).to eq('22d09f693ca74f8d9b2470e6524ccd1a')
      end

      it "builds a checksum of the content as the #id if no key" do
        record['content'] = 'Here is the content'
        record.delete('id')

        expect(subject.id).to eq('22d09f693ca74f8d9b2470e6524ccd1a')
      end
    end

    describe "#note_ids" do
      it "returns an empty collection if key not found" do
        record.delete('note_ids')

        expect(subject.note_ids).to eq([])
      end
    end

    context "with associated #note_ids" do
      before(:each) do
        record['note_ids'] = ['1', '2']
      end

      it "returns a collection of ids" do
        expect(subject.note_ids).to_not be_empty
      end

      it "returns true for #note_ids?" do
        expect(subject.note_ids?).to be_truthy
      end
    end

    context "without associated #note_ids" do
      it "returns an empty collection" do
        expect(subject.note_ids).to be_empty
      end

      it "returns false for #note_ids?" do
        expect(subject.note_ids?).to be_falsey
      end
    end

    it "returns the associated #book_id" do
      expect(subject.book_id).to eq('accdd')
    end

    it "returns the #location" do
      expect(subject.location).to eq(50)
    end

    it "returns the #content" do
      content = "Here is an annotation."
      expect(subject.content).to eq(content)
    end
  end
end
