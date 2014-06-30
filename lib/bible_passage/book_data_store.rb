module BiblePassage

  class BookDataStore

    BOOK_DATA = {
      gen: 'Genesis',
      exod: 'Exodus',
      lev: 'Leviticus',
      num: 'Numbers',
      deut: 'Deuteronomy',
      josh: 'Joshua',
      judg: 'Judges',
      ruth: 'Ruth',
      '1sam'.to_sym => '1 Samuel',
      '2sam'.to_sym => '2 Samuel',
      '1kings'.to_sym => '1 Kings',
      '2kings'.to_sym => '2 Kings',
      '1chr'.to_sym => '1 Chronicles',
      '2chr'.to_sym => '2 Chronicles',
      ezra: 'Ezra',
      neh: 'Nehemiah',
      esth: 'Esther',
      job: 'Job',
      ps: 'Psalms',
      prov: 'Proverbs',
      eccl: 'Ecclesiastes',
      song: 'Song of Songs',
      isa: 'Isaiah',
      jer: 'Jeremiah',
      lam: 'Lamentations',
      ezek: 'Ezekiel',
      dan: 'Daniel',
      hos: 'Hosea',
      joel: 'Joel',
      amos: 'Amos',
      obad: 'Obadiah',
      jonah: 'Jonah',
      mic: 'Micah',
      nah: 'Nahum',
      hab: 'Habakkuk',
      zeph: 'Zephaniah',
      hag: 'Haggai',
      zech: 'Zechariah',
      mal: 'Malachi',
      matt: 'Matthew',
      mark: 'Mark',
      luke: 'Luke',
      john: 'John',
      acts: 'Acts',
      rom: 'Romans',
      '1cor'.to_sym => '1 Corinthians',
      '2cor'.to_sym => '2 Corinthians',
      gal: 'Galatians',
      eph: 'Ephesians',
      phil: 'Philippians',
      col: 'Colossians',
      '1thess'.to_sym => '1 Thessalonians',
      '2thess'.to_sym => '2 Thessalonians',
      '1tim'.to_sym => '1 Timothy',
      '2tim'.to_sym => '2 Timothy',
      titus: 'Titus',
      phlm: 'Philemon',
      heb: 'Hebrews',
      jas: 'James',
      '1pet'.to_sym => '1 Peter',
      '2pet'.to_sym => '2 Peter',
      '1john'.to_sym => '1 John',
      '2john'.to_sym => '2 John',
      '3john'.to_sym => '3 John',
      jude: 'Jude',
      rev: 'Revelation'
    } 

    def book_name(key)
      BOOK_DATA[key] || 
        raise(InvalidBookError.new("#{key} is not a valid book key"))
    end

  end

end
