require_relative '../spec_helper'

describe BiblePassage::Reference do

  def self.method_missing(mth, *args)
    if mth.to_s =~ /^it_has_(\w+)$/
      ref_str, val, msg = args
      msg << " (#{ref_str})"
      it msg do
        expect(BiblePassage::Reference.parse(ref_str).send($1)).to eq(val)
      end
    elsif mth.to_s =~ /^child_has_(\w+)$/
      ref_str, val, msg = args
      msg << " (#{ref_str})"
      it msg do
        expect(BiblePassage::Reference.parse(ref_str).child.send($1)).
          to eq(val)
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
        allow(translator).to receive(:keyify).with("book name", true).
          and_return :gen
        expect(reference.book_key).to eq(:gen)
      end

      it "returns another book_key" do
        allow(translator).to receive(:keyify).with("book name", true).
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

      it_has_from_chapter('Jude 2', 1, 'works for single chapter book')

      it_has_from_chapter('Revelation 8:6 - 11:19', 8, 'works with spaces around hyphen')

    end

    context "from_verse" do

      it_has_from_verse("Genesis", 1, 'defaults to 1')

      it_has_from_verse("Exodus 1:2", 2, 'works when specified')

      it_has_from_verse('Jude 2', 2, 'works for single chapter book')

    end

    context "to_chapter" do

      it_has_to_chapter("Exodus 12:23", 12, 'defaults to from_chapter when provided')

      it_has_to_chapter("Exodus", 40, 'defaults to last_chapter when from_chapter not provided')

      it_has_to_chapter("Exodus 12-15", 15, 'works without any verses')

      it_has_to_chapter("Exodus 2:13-4:1", 4, 'works with specified start and end verse')

      it_has_to_chapter("Exodus 2:3-20", 2, 'works when from_verse is specified')

      it_has_to_chapter("Exodus 2:13-14:5", 14, 'works when from_verse is specified')

      it_has_to_chapter("Jude 2-3", 1, 'works for a single chapter book')

    end

    context "to_verse" do

      it_has_to_verse("Exodus 2:3-14:25", 25, 'works when to_chapter is specified')

      it_has_to_verse("Exodus 2:3-14", 14, 'works when to_chapter is not specified')

      it_has_to_verse("Exodus 2:12", 12, 'defaults to from_verse if from_chapter is specified')

      it_has_to_verse("Exodus 2-3", 22, 'defaults to last verse of to_chapter if to_chapter is specified')

      it_has_to_verse('Jude 2-3', 3, 'works for a single chapter book')

    end

    context "compound" do

      context "full passage reference child" do

        let(:ref) { BiblePassage::Reference }

        it "behaves like a normal reference" do
          expect(ref.parse("gen 1:2-3, ex 4:5-6:7").child).to eq(ref.parse("ex 4:5-6:7"))
        end

      end

      context "from_chapter" do

        child_has_from_chapter("Exodus 1:2-3:4,5", 3, "defaults to parent's to_chapter if supplied")

        child_has_from_chapter("Exodus 1:2-3:4,5:6", 5, "uses supplied if chapter and verse given")

        child_has_from_chapter("Exodus 1, 3", 3, 'uses supplied if chapter given')

        child_has_from_chapter("Jude 1, 2", 1, 'sets to 1 if single-chapter book')

      end

      context "from_verse" do

        child_has_from_verse("Exodus 1:2-3:4, 5", 5, "uses supplied from_verse")

        child_has_from_verse("Exodus 1:2-3:4, 5:6", 6, "uses supplied if chapter and verse given")

        child_has_from_verse("Exodus 1, 2:3", 3, "uses supplied if parent doesn't have one")

        child_has_from_verse("Jude 1, 2", 2, "uses supplied for single-chapter book")

      end

      context "to_chapter" do

        child_has_to_chapter("Exodus 1, 3-4", 4, "uses supplied if given")

        child_has_to_chapter("Exodus 1, 3:4-5", 3, "doesn't use if not supplied")

        child_has_to_chapter("Exodus 1, 3:4-5:6", 5, "uses if to_verse also supplied")

        child_has_to_chapter("ex 1:2-3:4, 5:6-7:8 ", 7, "uses if all supplied")
      end

      context "to_verse" do

        child_has_to_verse("Exodus 1, 2-3:4", 4, "uses supplied if chapter and verse given")

        child_has_to_verse("Exodus 1, 2:3-4", 4, "uses supplied if just verse given")

        child_has_to_verse("Exodus 1, 2:3", 3, "doesn't use if to-part not supplied")

        child_has_to_verse("Exodus 1, 2-3", 22, "uses end verse if just to_chapter supplied")

      end

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

    def self.it_renders_reference(book_key, from_chapter, from_verse, to_chapter,
                                to_verse, passage, msg)
      it "renders #{msg}" do
        expect(BiblePassage::Reference.new(book_key, from_chapter, from_verse,
                                to_chapter, to_verse).to_s).to eq(passage)
      end
    end

    def self.it_renders_passage(passage, expected)
      it "renders #{passage} as #{expected}" do
        expect(BiblePassage::Reference.parse(passage).to_s).to eq expected
      end
    end

    it_renders_reference(:gen, 1, 2, 3, 4, 'Genesis 1:2-3:4', 'where all attributes differ')

    it_renders_reference(:gen, 1, 2, 1, 3, 'Genesis 1:2-3', 'where only verses differ')

    it_renders_reference(:gen, 1, nil, 2, nil, 'Genesis 1-2', 'where full chapters')

    it_renders_reference(:gen, 1, nil, nil, nil, 'Genesis 1', 'where single chapter')

    it_renders_reference(:gen, 1, 2, nil, nil, 'Genesis 1:2', 'where single verse')

    it_renders_reference(:jude, 1, 2, 1, 4, 'Jude 2-4', 'where a single chapter book')

    it_renders_reference(:jude, 1, 2, 1, 2, 'Jude 2', 'where a single verse in a single chapter book')

    it_renders_reference(:jude, nil, nil, nil, nil, 'Jude', 'where a whole single chapter book')

    it_renders_reference(:exod, nil, nil, nil, nil, 'Exodus', 'where a whole book')

    it_renders_passage("gn 1:2-3:4, ex 5:6-7:8", "Genesis 1:2-3:4, Exodus 5:6-7:8")

    it_renders_passage("ex 1:2-3:4, 5:6-7:8", 'Exodus 1:2-3:4, 5:6-7:8')

    it_renders_passage("ex 1-2, 3-4", "Exodus 1-2, 3-4")

    it_renders_passage("Ephesians 4:20-32, 5:18-19", "Ephesians 4:20-32, 5:18-19")

  end

  context "error checking" do

    context "parse" do

      it "errors when given a non-existent book name" do
        expect { BiblePassage::Reference.parse("Genosis") }.to raise_error(
          BiblePassage::InvalidReferenceError, "Genosis is not a valid book")
      end

      it "returns an invalid reference when non-existent book and false are passed in for raise_errors" do
        expect(BiblePassage::Reference.parse("Genosis", raise_errors: false).valid?).to eq(false)
      end

      it "returns valid? false when non-existent book and raise_errors:false are passed in" do
        expect(BiblePassage::Reference.parse("Genosis", raise_errors: false).valid?).to eq(false)
      end

    end

    context "new" do

      def self.it_errors(msg, book_key, from_chapter, from_verse, to_chapter,
                         to_verse, error_msg)
        it "errors #{msg}" do
          expect { BiblePassage::Reference.new(book_key, from_chapter, 
            from_verse, to_chapter, to_verse) }.
            to raise_error(BiblePassage::InvalidReferenceError, error_msg)
        end
      end

      def self.it_returns_invalid_reference(msg, book_key, from_chapter, from_verse, to_chapter, to_verse, error_msg)
        it "returns an invalid reference #{msg}" do
          ref = BiblePassage::Reference.new(book_key, from_chapter, from_verse, to_chapter, to_verse, raise_errors: false)
          expect(ref.valid?).to eq(false)
          expect(ref.error).to eq(error_msg)
        end
      end

      it_errors "when from_chapter is less than 1", :gen, 0, nil, nil, nil,
                "Genesis doesn't have a chapter 0"
      
      it_returns_invalid_reference "when from_chapter is less than 1", :gen, 0, 1, 1, 1, "Genesis doesn't have a chapter 0"

      it_errors "when from_chapter is greater than number of chapters in book",
        :gen, 51, nil, nil, nil, "Genesis doesn't have a chapter 51"

      it_returns_invalid_reference  "when from_chapter is greater than number of chapters in book",
        :gen, 51, 1, 51, 1, "Genesis doesn't have a chapter 51"

      it_errors "when from_verse is less than 1", :gen, 1, 0, nil, nil,
        "Genesis 1 doesn't have a verse 0"

      it_returns_invalid_reference "when from_verse is less than 1", :gen, 1, 0, 1, 1,
        "Genesis 1 doesn't have a verse 0"

      it_errors "when from_verse is greater than number of verses in chapter",
        :gen, 1, 32, nil, nil, "Genesis 1 doesn't have a verse 32"

      it_returns_invalid_reference "when from_verse is greater than number of verses in chapter",
        :gen, 1, 32, 1, 32, "Genesis 1 doesn't have a verse 32"

      it_errors "when to_chapter is less than from_chapter", :gen, 2, nil, 1,
        nil, "to_chapter cannot be before from_chapter"

      it_returns_invalid_reference "when to_chapter is less than from_chapter", :gen, 2, 1, 1,
        1, "to_chapter cannot be before from_chapter"

      it_errors "when to_chapter is greater than number of chapters is book",
        :gen, 2, nil, 51, nil, "Genesis doesn't have a chapter 51"

      it_returns_invalid_reference "when to_chapter is greater than number of chapters is book",
        :gen, 2, 1, 51, 1, "Genesis doesn't have a chapter 51"

      it_errors "when to_verse is less than from_verse and in same chapter",
        :gen, 2, 2, 2, 1, "to_verse cannot be before from_verse"

      it_returns_invalid_reference "when to_verse is less than from_verse and in same chapter",
        :gen, 2, 2, 2, 1, "to_verse cannot be before from_verse"

      it "doesn't error when to_verse is less than from_verse but spans 
        chapters" do
        expect { BiblePassage::Reference.new(:gen, 2, 2, 3, 1) }.
          not_to raise_error
      end

      it_errors "when to_verse is greater than number of verses in chapter",
        :gen, 1, 1, 1, 32, "Genesis 1 doesn't have a verse 32"

      it_returns_invalid_reference "when to_verse is greater than number of verses in chapter",
        :gen, 1, 1, 1, 32, "Genesis 1 doesn't have a verse 32"

      it "errors when a chapter is supplied to .parse for a single-chapter
        book" do
        expect { BiblePassage::Reference.parse("Jude 2:3-4") }.to raise_error(
          BiblePassage::InvalidReferenceError, 
          "Jude doesn't have any chapters")
      end

      it "returns an invalid reference when a chapter and parse_errors: false are supplied to .parse for a single-chapter book" do
        expect(BiblePassage::Reference.parse("Jude 2:3-4", raise_errors: false).valid?).to eq(false)
      end

      it "errors when no book is supplied to parse" do
        expect { BiblePassage::Reference.parse('2') }.to raise_error(
          BiblePassage::InvalidReferenceError, "2 is not a valid reference")
      end

      it "returns an invalid reference when no book and raise_errors: false is supplied to parse" do
        expect(BiblePassage::Reference.parse('2', raise_errors: false).valid?).to eq(false)
      end

      it "returns true for valid? when it is valid" do
        expect(BiblePassage::Reference.new(:gen, 1, 1).valid?).to eq(true)
      end

      it "returns nil for to_s when it is invalid" do
        expect(BiblePassage::Reference.parse('2', raise_errors: false).to_s).to eq(nil)
      end
    end

  end

  context "inheritable attributes" do

    let(:ref) { BiblePassage::Reference }

    it "is empty if just book supplied" do
      expect(ref.new(:gen).inheritable_attributes).to eq({})
    end

    it "returns book_key if chapters specified" do
      expect(ref.new(:gen, 1).inheritable_attributes).to eq(book_key: :gen)
    end

    it "returns to_chapter as from_chapter if verses specified" do
      expect(ref.new(:gen, 1, 2, 3, 4).inheritable_attributes).
        to eq(book_key: :gen, from_chapter: 3)
    end

  end
end
