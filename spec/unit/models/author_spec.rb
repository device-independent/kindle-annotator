require 'spec_helper'

describe Kindle::Annotator::Models::Author do
  let(:authors_file) do
    File.read(File.expand_path('../../../data/authors.json', __FILE__))
  end

  let(:record) do
    MultiJson.load(authors_file).first
  end

  subject { described_class.new(record) }

  context "with valid attributes" do
    describe "#id" do
      it "returns the provided #id" do
        expect(subject.id).to eq('6beccc67ff905f7da0b29dece26b0485')
      end

      it "builds a checksum of the name as the #id if nil" do
        record['name'] = 'Lester Tester'
        record['id'] = nil
        expect(subject.id).to eq('716b7d0048b5f255913af5ec978d0545')
      end

      it "builds a checksum of the name as the #id if no key" do
        record['name'] = 'Lester Tester'
        record.delete('id')

        expect(subject.id).to eq('716b7d0048b5f255913af5ec978d0545')
      end
    end

    it "returns the #name" do
      expect(subject.name).to eq('Amazon Web Services')
    end

    describe "#book_ids" do
      it "returns an empty collection if key not found" do
        record.delete('book_ids')

        expect(subject.book_ids).to eq([])
      end
    end

    context "with associated #book_ids" do
      it "returns a collection of ids" do
        expect(subject.book_ids).to_not be_empty
      end

      it "returns true for #book_ids?" do
        expect(subject.book_ids?).to be_truthy
      end
    end

    context "without associated #book_ids" do
      before(:each) do
        record['book_ids'] = []
      end

      it "returns an empty collection" do
        expect(subject.book_ids).to be_empty
      end

      it "returns false for #book_ids?" do
        expect(subject.book_ids?).to be_falsey
      end
    end
  end
end
