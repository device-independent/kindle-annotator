require 'spec_helper'

describe Kindle::Annotator::Models::Annotations do
  let(:annotations_file) do
    File.read(File.expand_path('../../../data/annotations.json', __FILE__))
  end

  let(:annotations_collection) do
    MultiJson.load(annotations_file)
  end

  subject { described_class.new(annotations_collection) }

  describe ".find_all_by_book_id" do
    it "returns 2 for the annotations by specified book_id" do
      records = subject.find_all_by_book_id('accdd')
      expect(records.count).to eq(2)
    end

    it "returns 0 for annotations when no specified book_id is found" do
      records = subject.find_all_by_book_id('notfound')
      expect(records.count).to eq(0)
    end
  end

  describe ".find_by_id" do
    it "returns the annotation by it's ID" do
      record = subject.find_by_id('vbfgh')
      expect(record).not_to be_nil
    end

    it "returns nil if the annotation cannot be found" do
      record = subject.find_by_id('notfound')
      expect(record).to be_nil
    end
  end

  describe ".find_by_id!" do
    it "raises an exception if no annotation is found" do
      expect { subject.find_by_id!('notfound') }.to raise_error(Kindle::Annotator::Models::Annotations::AnnotationNotFoundError)
    end
  end

  context "with no records" do
    let(:annotations_collection) { [] }

    it "returns 0 for the #count" do
      expect(subject.count).to eq(0)
    end

    it "returns false for #any?" do
      expect(subject.any?).to be_falsey
    end
  end

  context "with a single record" do
    let(:annotations_collection) do
      [MultiJson.load(annotations_file).first]
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
