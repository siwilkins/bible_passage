require_relative '../spec_helper'

describe BiblePassage::BookKeyTranslator do

  let(:translator) {BiblePassage::BookKeyTranslator.new }

  def self.it_translates_to_key(from, to, desc = nil)
    desc ||= "translates #{from} to #{to}"
    it desc do
      expect(translator.keyify(from)).to eq(to)
    end
  end

  it_translates_to_key("genesis", :gen)
  it_translates_to_key("ge", :gen)
  it_translates_to_key("genesis", :gen)
  it_translates_to_key("gen", :gen)
  it_translates_to_key("gene", :gen)
  it_translates_to_key("genes", :gen)
  it_translates_to_key("gn", :gen)

  it_translates_to_key("exodus", :exod)
  it_translates_to_key("exod", :exod)
  it_translates_to_key("exo", :exod)
  it_translates_to_key("ex", :exod)

  it_translates_to_key("leviticus", :lev)
  it_translates_to_key("levit", :lev)
  it_translates_to_key("lev", :lev)
  it_translates_to_key("le", :lev)

  it_translates_to_key("numbers", :num)
  it_translates_to_key("numb", :num)
  it_translates_to_key("num", :num)
  it_translates_to_key("nu", :num)
  it_translates_to_key("nm", :num)

  it_translates_to_key("deuteronomy", :deut)
  it_translates_to_key("deuter", :deut)
  it_translates_to_key("deut", :deut)
  it_translates_to_key("deu", :deut)
  it_translates_to_key("de", :deut)
  it_translates_to_key("dt", :deut)
  
  it_translates_to_key("joshua", :josh)
  it_translates_to_key("josh", :josh)
  it_translates_to_key("jos", :josh)

  it_translates_to_key("judges", :judg)
  it_translates_to_key("judg", :judg)
  it_translates_to_key("jdg", :judg)
  it_translates_to_key("jd", :judg)

  it_translates_to_key("ruth", :ruth)

  it_translates_to_key("1 samuel", '1sam'.to_sym)
  it_translates_to_key("1 sam", '1sam'.to_sym)
  it_translates_to_key("1 sa", '1sam'.to_sym)

  it_translates_to_key("2 samuel", '2sam'.to_sym)
  it_translates_to_key("2 sam", '2sam'.to_sym)
  it_translates_to_key("2 sa", '2sam'.to_sym)

  it_translates_to_key("1 kings", '1kgs'.to_sym)
  it_translates_to_key("1 king", '1kgs'.to_sym)
  it_translates_to_key("1 ki", '1kgs'.to_sym)
  it_translates_to_key("1 kngs", '1kgs'.to_sym)
  it_translates_to_key("1 kgs", '1kgs'.to_sym)

  it_translates_to_key("2 kings", '2kgs'.to_sym)
  it_translates_to_key("2 king", '2kgs'.to_sym)
  it_translates_to_key("2 ki", '2kgs'.to_sym)
  it_translates_to_key("2 kngs", '2kgs'.to_sym)
  it_translates_to_key("2 kgs", '2kgs'.to_sym)

  it_translates_to_key("1 chronicles", '1chr'.to_sym)
  it_translates_to_key("1 chron", '1chr'.to_sym)
  it_translates_to_key("1 chro", '1chr'.to_sym)
  it_translates_to_key("1 chr", '1chr'.to_sym)
  it_translates_to_key("1 ch", '1chr'.to_sym)

  it_translates_to_key("2 chronicles", '2chr'.to_sym)
  it_translates_to_key("2 chron", '2chr'.to_sym)
  it_translates_to_key("2 chro", '2chr'.to_sym)
  it_translates_to_key("2 chr", '2chr'.to_sym)
  it_translates_to_key("2 ch", '2chr'.to_sym)

  it_translates_to_key("ezra", :ezra)
  it_translates_to_key("ezr", :ezra)

  it_translates_to_key("nehemiah", :neh)
  it_translates_to_key("nehem", :neh)
  it_translates_to_key("neh", :neh)
  it_translates_to_key("ne", :neh)
  
  it_translates_to_key("esther", :esth)
  it_translates_to_key("esth", :esth)
  it_translates_to_key("est", :esth)
  it_translates_to_key("es", :esth)

  it_translates_to_key("job", :job)
  it_translates_to_key("jo", :job)

  it_translates_to_key("psalms", :ps)
  it_translates_to_key("psalm", :ps)
  it_translates_to_key("psal", :ps)
  it_translates_to_key("psa", :ps)
  it_translates_to_key("ps", :ps)

  it_translates_to_key("proverbs", :prov)
  it_translates_to_key("prov", :prov)
  it_translates_to_key("pro", :prov)
  it_translates_to_key("pr", :prov)

  it_translates_to_key("ecclesiastes", :eccl)
  it_translates_to_key("eccles", :eccl)
  it_translates_to_key("eccl", :eccl)
  it_translates_to_key("ecc", :eccl)
  it_translates_to_key("ec", :eccl)

  it_translates_to_key("song of solomon", :song)
  it_translates_to_key("song of songs", :song)
  it_translates_to_key("song of sol", :song)
  it_translates_to_key("ss", :song)
  it_translates_to_key("ssong", :song)
  it_translates_to_key("so", :song)

  it_translates_to_key("isaiah", :isa)
  it_translates_to_key("isa", :isa)
  it_translates_to_key("is", :isa)

  it_translates_to_key("jeremiah", :jer)
  it_translates_to_key("jerem", :jer)
  it_translates_to_key("jere", :jer)
  it_translates_to_key("jer", :jer)
  it_translates_to_key("je", :jer)

  it_translates_to_key("lamentations", :lam)
  it_translates_to_key("lament", :lam)
  it_translates_to_key("lamen", :lam)
  it_translates_to_key("lam", :lam)
  it_translates_to_key("la", :lam)

  it_translates_to_key("ezekiel", :ezek)
  it_translates_to_key("ezek", :ezek)
  it_translates_to_key("eze", :ezek)

  it_translates_to_key("daniel", :dan)
  it_translates_to_key("dan", :dan)
  it_translates_to_key("da", :dan)

  it_translates_to_key("hosea", :hos)
  it_translates_to_key("hos", :hos)
  it_translates_to_key("ho", :hos)

  it_translates_to_key("joel", :joel)
  it_translates_to_key("joe", :joel)

  it_translates_to_key("amos", :amos)
  it_translates_to_key("am", :amos)

  it_translates_to_key("obadiah", :obad)
  it_translates_to_key("obad", :obad)
  it_translates_to_key("oba", :obad)
  it_translates_to_key("ob", :obad)

  it_translates_to_key("jonah", :jonah)
  it_translates_to_key("jona", :jonah)
  it_translates_to_key("jon", :jonah)

  it_translates_to_key("micah", :mic)
  it_translates_to_key("mic", :mic)
  it_translates_to_key("mi", :mic)

  it_translates_to_key("nahum", :nah)
  it_translates_to_key("nah", :nah)
  it_translates_to_key("na", :nah)

  it_translates_to_key("habakkuk", :hab)
  it_translates_to_key("habak", :hab)
  it_translates_to_key("hab", :hab)

  it_translates_to_key("zephaniah", :zeph)
  it_translates_to_key("zeph", :zeph)
  it_translates_to_key("zep", :zeph)

  it_translates_to_key("haggai", :hag)
  it_translates_to_key("hagg", :hag)
  it_translates_to_key("hag", :hag)

  it_translates_to_key("zechariah", :zech)
  it_translates_to_key("zech", :zech)
  it_translates_to_key("zec", :zech)

  it_translates_to_key("malachi", :mal)
  it_translates_to_key("malach", :mal)
  it_translates_to_key("malac", :mal)
  it_translates_to_key("mal", :mal)

  it_translates_to_key("matthew", :matt)
  it_translates_to_key("matth", :matt)
  it_translates_to_key("matt", :matt)
  it_translates_to_key("mat", :matt)
  it_translates_to_key("mt", :matt)

  it_translates_to_key("mark", :mark)
  it_translates_to_key("mar", :mark)
  it_translates_to_key("mrk", :mark)
  it_translates_to_key("mr", :mark)

  it_translates_to_key("luke", :luke)
  it_translates_to_key("luk", :luke)
  it_translates_to_key("lu", :luke)
  it_translates_to_key("lke", :luke)
  it_translates_to_key("lk", :luke)

  it_translates_to_key("john", :john)
  it_translates_to_key("joh", :john)
  it_translates_to_key("jhn", :john)
  it_translates_to_key("jn", :john)

  it_translates_to_key("acts", :acts)
  it_translates_to_key("act", :acts)
  it_translates_to_key("ac", :acts)

  it_translates_to_key("romans", :rom)
  it_translates_to_key("roman", :rom)
  it_translates_to_key("rom", :rom)
  it_translates_to_key("ro", :rom)

  it_translates_to_key("1 corinthians", '1cor'.to_sym)
  it_translates_to_key("1 corinth", '1cor'.to_sym)
  it_translates_to_key("1 corin", '1cor'.to_sym)
  it_translates_to_key("1 cor", '1cor'.to_sym)
  it_translates_to_key("1 co", '1cor'.to_sym)

  it_translates_to_key("2 corinthians", '2cor'.to_sym)
  it_translates_to_key("2 corinth", '2cor'.to_sym)
  it_translates_to_key("2 corin", '2cor'.to_sym)
  it_translates_to_key("2 cor", '2cor'.to_sym)
  it_translates_to_key("2 co", '2cor'.to_sym)

  it_translates_to_key("galatians", :gal)
  it_translates_to_key("galat", :gal)
  it_translates_to_key("gal", :gal)
  it_translates_to_key("ga", :gal)

  it_translates_to_key("ephesians", :eph)
  it_translates_to_key("ephes", :eph)
  it_translates_to_key("eph", :eph)
  it_translates_to_key("ep", :eph)

  it_translates_to_key("philippians", :phil)
  it_translates_to_key("philipp", :phil)
  it_translates_to_key("philip", :phil)
  it_translates_to_key("phili", :phil)
  it_translates_to_key("phil", :phil)
  it_translates_to_key("phi", :phil)
  it_translates_to_key("php", :phil)
  it_translates_to_key("ph", :phil)

  it_translates_to_key("colossians", :col)
  it_translates_to_key("coloss", :col)
  it_translates_to_key("colos", :col)
  it_translates_to_key("colo", :col)
  it_translates_to_key("col", :col)
  it_translates_to_key("co", :col)

  it_translates_to_key("1 thessalonians", '1thess'.to_sym)
  it_translates_to_key("1 thess", '1thess'.to_sym)
  it_translates_to_key("1 thes", '1thess'.to_sym)
  it_translates_to_key("1 the", '1thess'.to_sym)
  it_translates_to_key("1 th", '1thess'.to_sym)

  it_translates_to_key("2 thessalonians", '2thess'.to_sym)
  it_translates_to_key("2 thess", '2thess'.to_sym)
  it_translates_to_key("2 thes", '2thess'.to_sym)
  it_translates_to_key("2 the", '2thess'.to_sym)
  it_translates_to_key("2 th", '2thess'.to_sym)

  it_translates_to_key("1 timothy", '1tim'.to_sym)
  it_translates_to_key("1 tim", '1tim'.to_sym)
  it_translates_to_key("1 ti", '1tim'.to_sym)

  it_translates_to_key("2 timothy", '2tim'.to_sym)
  it_translates_to_key("2 tim", '2tim'.to_sym)
  it_translates_to_key("2 ti", '2tim'.to_sym)

  it_translates_to_key("titus", :titus)
  it_translates_to_key("titu", :titus)
  it_translates_to_key("tit", :titus)

  it_translates_to_key("philemon", :phlm)
  it_translates_to_key("philem", :phlm)
  it_translates_to_key("phile", :phlm)
  it_translates_to_key("phlm", :phlm)
  it_translates_to_key("phm", :phlm)
  it_translates_to_key("phlmn", :phlm)
  it_translates_to_key("phmn", :phlm)

  it_translates_to_key("hebrews", :heb)
  it_translates_to_key("hebr", :heb)
  it_translates_to_key("heb", :heb)
  it_translates_to_key("he", :heb)

  it_translates_to_key("james", :jas)
  it_translates_to_key("jas", :jas)
  it_translates_to_key("jam", :jas)

  it_translates_to_key("1 peter", '1pet'.to_sym)
  it_translates_to_key("1 pet", '1pet'.to_sym)
  it_translates_to_key("1 pe", '1pet'.to_sym)

  it_translates_to_key("2 peter", '2pet'.to_sym)
  it_translates_to_key("2 pet", '2pet'.to_sym)
  it_translates_to_key("2 pe", '2pet'.to_sym)

  it_translates_to_key("1 john", '1john'.to_sym)
  it_translates_to_key("1 joh", '1john'.to_sym)
  it_translates_to_key("1 jo", '1john'.to_sym)
  it_translates_to_key("1 jn", '1john'.to_sym)
  
  it_translates_to_key("2 john", '2john'.to_sym)
  it_translates_to_key("2 joh", '2john'.to_sym)
  it_translates_to_key("2 jo", '2john'.to_sym)
  it_translates_to_key("2 jn", '2john'.to_sym)

  it_translates_to_key("3 john", '3john'.to_sym)
  it_translates_to_key("3 joh", '3john'.to_sym)
  it_translates_to_key("3 jo", '3john'.to_sym)
  it_translates_to_key("3 jn", '3john'.to_sym)

  it_translates_to_key("jude", :jude)

  it_translates_to_key("revelation", :rev)
  it_translates_to_key("revel", :rev)
  it_translates_to_key("rev", :rev)
  it_translates_to_key("re", :rev)

  it_translates_to_key("  titus  ", :titus, "handles surrounding whitespace")
  it_translates_to_key("song   of 
                     solomon", :song, "handles extra spaces")

  it_translates_to_key("1 Corinthians", '1cor'.to_sym, "handles capitals") 

  it "errors if description is not found" do
    expect { translator.keyify("nonsense") }.to raise_error(
      BiblePassage::InvalidReferenceError, "nonsense is not a valid book")
  end

  it "errors if spaces are inserted in words" do
    expect { translator.keyify("jo hn") }.to raise_error(
      BiblePassage::InvalidReferenceError, "jo hn is not a valid book")
  end
end
