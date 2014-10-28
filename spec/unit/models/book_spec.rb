require 'spec_helper'

describe Kindle::Annotator::Models::Book do
  let(:books_file) do
    File.read(File.expand_path('../../../data/books.json', __FILE__))
  end

  let(:record) do
    MultiJson.load(books_file).first
  end

  subject { described_class.new(record) }

  context "with valid attributes" do

    it "returns the #id" do
      expect(subject.id).to eq('B007S33NT2')
    end

    it "returns the #title" do
      expect(subject.title).to eq('Amazon Virtual Private Cloud User Guide')
    end

    it "returns the #last_annotated_at" do
      last_annotated_datetime = Date.parse('May 31, 2012').to_time.utc
      expect(subject.last_annotated_at).to eq(last_annotated_datetime)
    end

    context "with associated #author_ids" do
      it "returns a collection of ids" do
        expect(subject.author_ids).to_not be_empty
      end

      it "returns true for #author_ids?" do
        expect(subject.author_ids?).to be_truthy
      end
    end

    context "without associated #author_ids" do
      before(:each) do
        record['author_ids'] = []
      end

      it "returns an empty collection" do
        expect(subject.author_ids).to be_empty
      end

      it "returns false for #author_ids?" do
        expect(subject.author_ids?).to be_falsey
      end
    end

    context "with associated #annotation_ids" do
      it "returns a collection of ids" do
        expect(subject.annotation_ids).to_not be_empty
      end

      it "returns true for #annotation_ids?" do
        expect(subject.annotation_ids?).to be_truthy
      end
    end

    context "without associated #annotation_ids" do
      before(:each) do
        record['annotation_ids'] = []
      end

      it "returns an empty collection" do
        expect(subject.annotation_ids).to be_empty
      end

      it "returns false for #annotation_ids?" do
        expect(subject.annotation_ids?).to be_falsey
      end
    end
  end
end
