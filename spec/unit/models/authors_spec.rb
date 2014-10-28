require 'spec_helper'

describe Kindle::Annotator::Models::Authors do
  let(:authors_file) do
    File.read(File.expand_path('../../../data/authors.json', __FILE__))
  end

  let(:authors_collection) do
    MultiJson.load(authors_file)
  end

  subject { described_class.new(authors_collection) }

  describe ".find_by_id" do
    it "returns the author by their ID" do
      record = subject.find_by_id('6beccc67ff905f7da0b29dece26b0485')
      expect(record).not_to be_nil
    end

    it "returns nil if the author cannot be found" do
      record = subject.find_by_id('notfound')
      expect(record).to be_nil
    end
  end

  describe ".find_by_id!" do
    it "raises an exception if no author is found" do
      expect { subject.find_by_id!('notfound') }.to raise_error(Kindle::Annotator::Models::Authors::AuthorNotFoundError)
    end
  end

  describe ".find_by_name" do
    it "returns the author by their name" do
      record = subject.find_by_name('Amazon Web Services')
      expect(record).not_to be_nil
    end

    it "returns nil if the author cannot be found" do
      record = subject.find_by_name('notfound')
      expect(record).to be_nil
    end
  end

  describe ".find_by_name!" do
    it "raises an exception if no author is found" do
      expect { subject.find_by_name!('no name') }.to raise_error(Kindle::Annotator::Models::Authors::AuthorNotFoundError)
    end
  end

  context "with no records" do
    let(:authors_collection) { [] }

    it "returns 0 for the #count" do
      expect(subject.count).to eq(0)
    end

    it "returns false for #any?" do
      expect(subject.any?).to be_falsey
    end
  end

  context "with a single record" do
    let(:authors_collection) do
      [MultiJson.load(authors_file).first]
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
