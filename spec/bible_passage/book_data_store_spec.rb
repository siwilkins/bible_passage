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
        BiblePassage::InvalidReferenceError, "ex is not a valid book key")
    end

  end

  context "number_of_chapters" do

    def self.it_gets_number_of_chapters(book_key, n)
      it "returns #{n} for :#{book_key}" do
        expect(store.number_of_chapters(book_key)).to eq(n)
      end
    end

    it_gets_number_of_chapters(:gen, 50)
    it_gets_number_of_chapters(:exod, 40)
    it_gets_number_of_chapters(:lev, 27)
    it_gets_number_of_chapters(:num, 36)
    it_gets_number_of_chapters(:deut, 34)
    it_gets_number_of_chapters(:josh, 24)
    it_gets_number_of_chapters(:judg, 21)
    it_gets_number_of_chapters(:ruth, 4)
    it_gets_number_of_chapters('1sam'.to_sym, 31)
    it_gets_number_of_chapters('2sam'.to_sym, 24)
    it_gets_number_of_chapters('1kings'.to_sym, 22)
    it_gets_number_of_chapters('2kings'.to_sym, 25)
    it_gets_number_of_chapters('1chr'.to_sym, 29)
    it_gets_number_of_chapters('2chr'.to_sym, 36)
    it_gets_number_of_chapters(:ezra, 10)
    it_gets_number_of_chapters(:neh, 13)
    it_gets_number_of_chapters(:esth, 10)
    it_gets_number_of_chapters(:job, 42)
    it_gets_number_of_chapters(:ps, 150)
    it_gets_number_of_chapters(:prov, 31)
    it_gets_number_of_chapters(:eccl, 12)
    it_gets_number_of_chapters(:song, 8)
    it_gets_number_of_chapters(:isa, 66)
    it_gets_number_of_chapters(:jer, 52)
    it_gets_number_of_chapters(:lam, 5)
    it_gets_number_of_chapters(:ezek, 48)
    it_gets_number_of_chapters(:dan, 12)
    it_gets_number_of_chapters(:hos, 14)
    it_gets_number_of_chapters(:joel, 3)
    it_gets_number_of_chapters(:amos, 9)
    it_gets_number_of_chapters(:obad, 1)
    it_gets_number_of_chapters(:jonah, 4)
    it_gets_number_of_chapters(:mic, 7)
    it_gets_number_of_chapters(:nah, 3)
    it_gets_number_of_chapters(:hab, 3)
    it_gets_number_of_chapters(:zeph, 3)
    it_gets_number_of_chapters(:hag, 2)
    it_gets_number_of_chapters(:zech, 14)
    it_gets_number_of_chapters(:mal, 4)
    it_gets_number_of_chapters(:matt, 28)
    it_gets_number_of_chapters(:mark, 16)
    it_gets_number_of_chapters(:luke, 24)
    it_gets_number_of_chapters(:john, 21)
    it_gets_number_of_chapters(:acts, 28)
    it_gets_number_of_chapters(:rom, 16)
    it_gets_number_of_chapters('1cor'.to_sym, 16)
    it_gets_number_of_chapters('2cor'.to_sym, 13)
    it_gets_number_of_chapters(:gal, 6)
    it_gets_number_of_chapters(:eph, 6)
    it_gets_number_of_chapters(:phil, 4)
    it_gets_number_of_chapters(:col, 4)
    it_gets_number_of_chapters('1thess'.to_sym, 5)
    it_gets_number_of_chapters('2thess'.to_sym, 3)
    it_gets_number_of_chapters('1tim'.to_sym, 6)
    it_gets_number_of_chapters('2tim'.to_sym, 4)
    it_gets_number_of_chapters(:titus, 3)
    it_gets_number_of_chapters(:phlm, 1)
    it_gets_number_of_chapters(:heb, 13)
    it_gets_number_of_chapters(:jas, 5)
    it_gets_number_of_chapters('1pet'.to_sym, 5)
    it_gets_number_of_chapters('2pet'.to_sym, 3)
    it_gets_number_of_chapters('1john'.to_sym, 5)
    it_gets_number_of_chapters('2john'.to_sym, 1)
    it_gets_number_of_chapters('3john'.to_sym, 1)
    it_gets_number_of_chapters(:jude, 1)
    it_gets_number_of_chapters(:rev, 22)

  end

  context "number_of_verses" do

    def self.it_gets_number_of_verses(book_key, chapter, n)
      it "returns #{n} for :#{book_key} #{chapter}" do
        expect(store.number_of_verses(book_key, chapter)).to eq(n)
      end
    end

    it_gets_number_of_verses(:gen, 1, 31)
    it_gets_number_of_verses(:gen, 2, 25)
    it "returns 25 for Genesis 2" do
      expect(store.number_of_verses(:gen, 2)).to eq(25)
    end

    # The following are regression tests for particular chapters which have
    # known errors in earlier versions

    # Use non-Hebrew numbering of Nehemiah 9/10
    it_gets_number_of_verses(:neh, 9, 38)
    it_gets_number_of_verses(:neh, 10, 39)

    it_gets_number_of_verses(:neh, 7, 73)
    it_gets_number_of_verses(:neh, 4, 23)
    it_gets_number_of_verses(:neh, 3, 32)

    it_gets_number_of_verses(:eccl, 5, 20)
    it_gets_number_of_verses(:eccl, 4, 16)

    it_gets_number_of_verses('2chr'.to_sym, 35, 27)
  end

end
