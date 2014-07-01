require_relative '../spec_helper'

describe BiblePassage::Reference do

  def self.method_missing(mth, *args)
    if mth.to_s =~ /^it_has_(\w+)$/
      ref_str, val, msg = args
      msg << " (#{ref_str})"
      it msg do
        expect(BiblePassage::Reference.parse(ref_str).send($1)).to eq(val)
      end
    else
      super
    end
  end

  context "when built with .parse" do

    let(:translator) do
      instance_double(BiblePassage::BookKeyTranslator, keyify: :exod)
    end

    let(:data_store) do
      instance_double(BiblePassage::BookDataStore, number_of_verses: 50,
                      number_of_chapters: 15, book_name: 'Matthew')
    end

    let(:reference) do
      BiblePassage::Reference.parse("book name", 
        translator: translator, data_store: data_store)
    end

    context "book_key" do

      it "returns a book_key" do
        allow(translator).to receive(:keyify).with("book name").
          and_return :gen
        expect(reference.book_key).to eq(:gen)
      end

      it "returns another book_key" do
        allow(translator).to receive(:keyify).with("book name").
          and_return :ex
        expect(reference.book_key).to eq(:ex)
      end

    end

    context "book" do

      it "returns a book" do
        allow(data_store).to receive(:book_name).with(:exod).
          and_return 'Exodus'
        expect(reference.book).to eq('Exodus')
      end

    end

    context "from_chapter" do

      it_has_from_chapter("Genesis", 1, 'defaults to 1')

      it_has_from_chapter('1 Chronicles 23', 23, 
                          'works with a bare chapter number')

      it_has_from_chapter('Luke 12:3', 12, 'works when a verse supplied')

      it_has_from_chapter('Luke12:3', 12, 'works when no space used')

    end

    context "from_verse" do

      it_has_from_verse("Genesis", 1, 'defaults to 1')

      it_has_from_verse("Exodus 1:2", 2, 'works when specified')

    end

    context "to_chapter" do

      it_has_to_chapter("Exodus 12:23", 12, 'defaults to from_chapter when provided')

      it_has_to_chapter("Exodus", 40, 'defaults to last_chapter when from_chapter not provided')

      it_has_to_chapter("Exodus 12-15", 15, 'works without any verses')

      it_has_to_chapter("Exodus 2:13-4:1", 4, 'works with specified start and end verse')

      it_has_to_chapter("Exodus 2:3-20", 2, 'works when from_verse is specified')

      it_has_to_chapter("Exodus 2:13-14:5", 14, 'works when from_verse is specified')

    end

    context "to_verse" do

      it_has_to_verse("Exodus 2:3-14:25", 25, 'works when to_chapter is specified')

      it_has_to_verse("Exodus 2:3-14", 14, 'works when to_chapter is not specified')

      it_has_to_verse("Exodus 2:12", 12, 'defaults to from_verse if from_chapter is specified')

      it_has_to_verse("Exodus 2-3", 22, 'defaults to last verse of to_chapter if to_chapter is specified')

    end

  end

  context "whole_chapters?" do

    it "returns true if covers some chapters' verses" do
      expect(BiblePassage::Reference.new(:gen, 1, 1, 2, 25).whole_chapters?).
        to eq(true)
    end

    it "returns false if doesn't start at verse 1" do
      expect(BiblePassage::Reference.new(:gen, 1, 2, 2, 25).whole_chapters?).
        to eq(false)
    end

    it "returns false if doesn't end at final verse" do
      expect(BiblePassage::Reference.new(:gen, 1, 1, 2, 24).whole_chapters?).
        to eq(false)
    end

  end

  context "whole_book?" do

    it "returns true if covers a whole book" do
      expect(BiblePassage::Reference.new(:lev, 1, 1, 27, 34).whole_book?).
        to eq(true)
    end

    it "returns false if it doesn't start at first chapter" do
      expect(BiblePassage::Reference.new(:lev, 2, 1, 27, 34).whole_book?).
        to eq(false)
    end

    it "returns false if it doesn't start at first verse" do
      expect(BiblePassage::Reference.new(:lev, 1, 2, 27, 34).whole_book?).
        to eq(false)
    end

    it "returns false if it doesn't end at last verse" do
      expect(BiblePassage::Reference.new(:lev, 1, 1, 27, 33).whole_book?).
        to eq(false)
    end

    it "returns false if it doesn't end at last chapter" do
      expect(BiblePassage::Reference.new(:lev, 1, 1, 26, 46).whole_book?).
        to eq(false)
    end

  end

  context "whole_chapter?" do

    it "returns true if it covers a whole chapter" do
      expect(BiblePassage::Reference.new(:gen, 2, 1, 2, 25).whole_chapter?).
        to eq(true)
    end

    it "returns false if it covers multiple chapters" do
      expect(BiblePassage::Reference.new(:gen, 2, 1, 3, 24).whole_chapter?).
        to eq(false)
    end

  end

  context "to_s" do

    def self.it_renders_passage(book_key, from_chapter, from_verse, to_chapter,
                                to_verse, passage, msg)
      it "renders #{msg}" do
        expect(BiblePassage::Reference.new(book_key, from_chapter, from_verse,
                                to_chapter, to_verse).to_s).to eq(passage)
      end
    end

    it_renders_passage(:gen, 1, 2, 3, 4, 'Genesis 1:2-3:4', 'where all attributes differ')

    it_renders_passage(:gen, 1, 2, 1, 3, 'Genesis 1:2-3', 'where only verses differ')

    it_renders_passage(:gen, 1, nil, 2, nil, 'Genesis 1-2', 'where full chapters')

    it_renders_passage(:gen, 1, nil, nil, nil, 'Genesis 1', 'where single chapter')

    it_renders_passage(:gen, 1, 2, nil, nil, 'Genesis 1:2', 'where single verse')

    it_renders_passage(:jude, 1, 2, 1, 4, 'Jude 2-4', 'where a single chapter book')

    it_renders_passage(:jude, 1, 2, 1, 2, 'Jude 2', 'where a single verse in a single chapter book')

    it_renders_passage(:jude, nil, nil, nil, nil, 'Jude', 'where a whole single chapter book')

    it_renders_passage(:exod, nil, nil, nil, nil, 'Exodus', 'where a whole book')

  end

  context "error checking" do

    context "parse" do

      it "errors when given a non-existent book name" do
        expect { BiblePassage::Reference.parse("Genosis") }.to raise_error(
          BiblePassage::InvalidReferenceError, "Genosis is not a valid book")
      end

    end

    context "new" do

      def self.it_errors(msg, book_key, from_chapter, from_verse, to_chapter,
                         to_verse, error_msg)
        it msg do
          expect { BiblePassage::Reference.new(book_key, from_chapter, 
            from_verse, to_chapter, to_verse) }.
            to raise_error(BiblePassage::InvalidReferenceError, error_msg)
        end
      end

      it_errors "when from_chapter is less than 1", :gen, 0, nil, nil, nil,
                "Genesis doesn't have a chapter 0"

      it_errors "when from_chapter is greater than number of chapters in book",
        :gen, 51, nil, nil, nil, "Genesis doesn't have a chapter 51"

      it_errors "when from_verse is less than 1", :gen, 1, 0, nil, nil,
        "Genesis 1 doesn't have a verse 0"

      it_errors "when from_verse is greater than number of verses in chapter",
        :gen, 1, 32, nil, nil, "Genesis 1 doesn't have a verse 32"

      it_errors "when to_chapter is less than from_chapter", :gen, 2, nil, 1,
        nil, "to_chapter cannot be before from_chapter"

      it_errors "when to_chapter is greater than number of chapters is book",
        :gen, 2, nil, 51, nil, "Genesis doesn't have a chapter 51"

      it_errors "when to_verse is less than from_verse and in same chapter",
        :gen, 2, 2, 2, 1, "to_verse cannot be before from_verse"

      it "doesn't error when to_verse is less than from_verse but spans 
        chapters" do
        expect { BiblePassage::Reference.new(:gen, 2, 2, 3, 1) }.
          not_to raise_error
      end

      it_errors "when to_verse is greater than number of verses in chapter",
        :gen, 1, 1, 1, 32, "Genesis 1 doesn't have a verse 32"
    end

  end

end
