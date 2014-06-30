require_relative '../spec_helper'

describe BiblePassage::Reference do

  def self.method_missing(mth, *args)
    if mth.to_s =~ /^it_has_(\w+)$/
      ref_str, val, msg = args
      msg << " (#{ref_str})"
      it msg do
        expect(BiblePassage::Reference.new(ref_str).send($1)).to eq(val)
      end
    else
      super
    end
  end

  context "an instance" do

    let(:translator) do
      instance_double(BiblePassage::BookKeyTranslator, keyify: :exod)
    end

    let(:data_store) do
      instance_double(BiblePassage::BookDataStore)
    end

    let(:reference) do
      BiblePassage::Reference.new("book name", 
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

      it_has_to_chapter("Exodus 2:3", 2, 'defaults to from_chapter')

      it_has_to_chapter("Exodus 2-5", 5, 'works without any verses')

      it_has_to_chapter("Exodus 2:3-4:1", 4, 'works with specified start and end verse')

      it_has_to_chapter("Exodus 2:3-4", 2, 'works when from_verse is specified')

    end

  end

end
