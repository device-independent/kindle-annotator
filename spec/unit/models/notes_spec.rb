require 'spec_helper'

describe Kindle::Annotator::Models::Notes do
  let(:notes_file) do
    File.read(File.expand_path('../../../data/notes.json', __FILE__))
  end

  let(:notes_collection) do
    MultiJson.load(notes_file)
  end

  subject { described_class.new(notes_collection) }

  describe ".find_all_by_annotation_id" do
    it "returns 1 for the notes by specified annotation_id" do
      records = subject.find_all_by_annotation_id('a2NACTKU52LI4P')
      expect(records.count).to eq(1)
    end

    it "returns 0 for notes when no specified annotation_id is found" do
      records = subject.find_all_by_annotation_id('notfound')
      expect(records.count).to eq(0)
    end
  end

  describe ".find_by_id" do
    it "returns the note by their ID" do
      record = subject.find_by_id('poiu')
      expect(record).not_to be_nil
    end

    it "returns nil if the note cannot be found" do
      record = subject.find_by_id('notfound')
      expect(record).to be_nil
    end
  end

  describe ".find_by_id!" do
    it "raises an exception if no note is found" do
      expect { subject.find_by_id!('notfound') }.to raise_error(Kindle::Annotator::Models::Notes::NoteNotFoundError)
    end
  end

  context "with no records" do
    let(:notes_collection) { [] }

    it "returns 0 for the #count" do
      expect(subject.count).to eq(0)
    end

    it "returns false for #any?" do
      expect(subject.any?).to be_falsey
    end
  end

  context "with a single record" do
    let(:notes_collection) do
      [MultiJson.load(notes_file).first]
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
