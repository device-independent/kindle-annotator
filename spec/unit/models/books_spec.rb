require 'spec_helper'

describe Kindle::Annotator::Models::Books do
  let(:books_file) do
    File.read(File.expand_path('../../../../data/books.json', __FILE__))
  end

  let(:books) do
    MultiJson.load(books_file)
  end

  subject { described_class.new(books) }

  describe ".find_by_id" do
    it "returns the book record by it's ID" do
      record = subject.find_by_id('B007S33NT2')
      expect(record).not_to be_nil
    end

    it "returns nil if book cannot be found" do
      record = subject.find_by_id('notfound')
      expect(record).to be_nil
    end

    it "is aliased as #find_by_asin" do
      expect(subject).to respond_to(:find_by_asin)
    end
  end

  describe ".find_by_id!" do
    it "raises an exception if no book is found" do
      expect { subject.find_by_id!('notfound') }.to raise_error(Kindle::Annotator::Models::Books::BookNotFoundError)
    end

    it "is aliased as #find_by_asin!" do
      expect(subject).to respond_to(:find_by_asin!)
    end
  end

  context "with no records" do
    let(:books) { [] }

    it "returns 0 for the #count" do
      expect(subject.count).to eq(0)
    end

    it "returns false for #any?" do
      expect(subject.any?).to be_falsey
    end
  end

  context "with a single record" do
    let(:books) do
      [MultiJson.load(books_file).first]
    end

    it "returns 1 for the #count" do
      expect(subject.count).to eq(1)
    end

    it "returns true for #any?" do
      expect(subject.any?).to be_truthy
    end
  end

  context "with 2 records" do
    it "returns 2 for the #count" do
      expect(subject.count).to eq(2)
    end

    it "returns true for #any?" do
      expect(subject.any?).to be_truthy
    end
  end
end
