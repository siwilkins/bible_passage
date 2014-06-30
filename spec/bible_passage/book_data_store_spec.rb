require_relative '../spec_helper'

describe BiblePassage::BookDataStore do

  let(:store) { BiblePassage::BookDataStore.new }

  context "book_name" do

    def self.it_gets_book_name(book_key, book_name)
      it "returns #{book_name} for :#{book_key}" do
        expect(store.book_name(book_key)).to eq(book_name)
      end
    end

    it_gets_book_name(:gen, 'Genesis')
    it_gets_book_name(:exod, 'Exodus')
    it_gets_book_name(:lev, 'Leviticus')
    it_gets_book_name(:num, 'Numbers')
    it_gets_book_name(:deut, 'Deuteronomy')
    it_gets_book_name(:josh, 'Joshua')
    it_gets_book_name(:judg, 'Judges')
    it_gets_book_name(:ruth, 'Ruth')
    it_gets_book_name('1sam'.to_sym, '1 Samuel')
    it_gets_book_name('2sam'.to_sym, '2 Samuel')
    it_gets_book_name('1kings'.to_sym, '1 Kings')
    it_gets_book_name('2kings'.to_sym, '2 Kings')
    it_gets_book_name('1chr'.to_sym, '1 Chronicles')
    it_gets_book_name('2chr'.to_sym, '2 Chronicles')
    it_gets_book_name(:ezra, 'Ezra')
    it_gets_book_name(:neh, 'Nehemiah')
    it_gets_book_name(:esth, 'Esther')
    it_gets_book_name(:job, 'Job')
    it_gets_book_name(:ps, 'Psalms')
    it_gets_book_name(:prov, 'Proverbs')
    it_gets_book_name(:eccl, 'Ecclesiastes')
    it_gets_book_name(:song, 'Song of Songs')
    it_gets_book_name(:isa, 'Isaiah')
    it_gets_book_name(:jer, 'Jeremiah')
    it_gets_book_name(:lam, 'Lamentations')
    it_gets_book_name(:ezek, 'Ezekiel')
    it_gets_book_name(:dan, 'Daniel')
    it_gets_book_name(:hos, 'Hosea')
    it_gets_book_name(:joel, 'Joel')
    it_gets_book_name(:amos, 'Amos')
    it_gets_book_name(:obad, 'Obadiah')
    it_gets_book_name(:jonah, 'Jonah')
    it_gets_book_name(:mic, 'Micah')
    it_gets_book_name(:nah, 'Nahum')
    it_gets_book_name(:hab, 'Habakkuk')
    it_gets_book_name(:zeph, 'Zephaniah')
    it_gets_book_name(:hag, 'Haggai')
    it_gets_book_name(:zech, 'Zechariah')
    it_gets_book_name(:mal, 'Malachi')
    it_gets_book_name(:matt, 'Matthew')
    it_gets_book_name(:mark, 'Mark')
    it_gets_book_name(:luke, 'Luke')
    it_gets_book_name(:john, 'John')
    it_gets_book_name(:acts, 'Acts')
    it_gets_book_name(:rom, 'Romans')
    it_gets_book_name('1cor'.to_sym, '1 Corinthians')
    it_gets_book_name('2cor'.to_sym, '2 Corinthians')
    it_gets_book_name(:gal, 'Galatians')
    it_gets_book_name(:eph, 'Ephesians')
    it_gets_book_name(:phil, 'Philippians')
    it_gets_book_name(:col, 'Colossians')
    it_gets_book_name('1thess'.to_sym, '1 Thessalonians')
    it_gets_book_name('2thess'.to_sym, '2 Thessalonians')
    it_gets_book_name('1tim'.to_sym, '1 Timothy')
    it_gets_book_name('2tim'.to_sym, '2 Timothy')
    it_gets_book_name(:titus, 'Titus')
    it_gets_book_name(:phlm, 'Philemon')
    it_gets_book_name(:heb, 'Hebrews')
    it_gets_book_name(:jas, 'James')
    it_gets_book_name('1pet'.to_sym, '1 Peter')
    it_gets_book_name('2pet'.to_sym, '2 Peter')
    it_gets_book_name('1john'.to_sym, '1 John')
    it_gets_book_name('2john'.to_sym, '2 John')
    it_gets_book_name('3john'.to_sym, '3 John')
    it_gets_book_name(:jude, 'Jude')
    it_gets_book_name(:rev, 'Revelation')

    it "errors if key is not found" do
      expect { store.book_name(:ex) }.to raise_error(
        BiblePassage::InvalidBookError, "ex is not a valid book key")
    end

  end

end
