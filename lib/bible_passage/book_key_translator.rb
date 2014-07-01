module BiblePassage

  class BookKeyTranslator

    TRANSLATIONS = {
      ge: :gen,
      gen: :gen,
      gene: :gen,
      genes: :gen,
      genesis: :gen,
      gn: :gen,

      ex: :exod,
      exo: :exod,
      exod: :exod,
      exodus: :exod,

      le: :lev,
      lev: :lev,
      levit: :lev,
      leviticus: :lev,

      nm: :num,
      nu: :num,
      num: :num,
      numb: :num,
      numbers: :num,

      de: :deut,
      de: :deut,
      deu: :deut,
      deut: :deut,
      deuter: :deut,
      deuteronomy: :deut,
      dt: :deut,

      jos: :josh,
      josh: :josh,
      joshua: :josh,

      jd: :judg,
      jdg: :judg,
      judg: :judg,
      judges: :judg,

      ruth: :ruth,

      '1 sa'.to_sym => '1sam'.to_sym,
      '1 sam'.to_sym => '1sam'.to_sym,
      '1 samuel'.to_sym => '1sam'.to_sym,

      '2 sa'.to_sym => '2sam'.to_sym,
      '2 sam'.to_sym => '2sam'.to_sym,
      '2 samuel'.to_sym => '2sam'.to_sym,

      '1 kgs'.to_sym => '1kgs'.to_sym,
      '1 ki'.to_sym => '1kgs'.to_sym,
      '1 king'.to_sym => '1kgs'.to_sym,
      '1 kings'.to_sym => '1kgs'.to_sym,
      '1 kngs'.to_sym => '1kgs'.to_sym,

      '2 kgs'.to_sym => '2kgs'.to_sym,
      '2 ki'.to_sym => '2kgs'.to_sym,
      '2 king'.to_sym => '2kgs'.to_sym,
      '2 kings'.to_sym => '2kgs'.to_sym,
      '2 kngs'.to_sym => '2kgs'.to_sym,

      '1 ch'.to_sym => '1chr'.to_sym,
      '1 chr'.to_sym => '1chr'.to_sym,
      '1 chro'.to_sym => '1chr'.to_sym,
      '1 chron'.to_sym => '1chr'.to_sym,
      '1 chronicles'.to_sym => '1chr'.to_sym,

      '2 ch'.to_sym => '2chr'.to_sym,
      '2 chr'.to_sym => '2chr'.to_sym,
      '2 chro'.to_sym => '2chr'.to_sym,
      '2 chron'.to_sym => '2chr'.to_sym,
      '2 chronicles'.to_sym => '2chr'.to_sym,

      ezr: :ezra,
      ezra: :ezra,

      ne: :neh,
      neh: :neh,
      nehem: :neh,
      nehemiah: :neh,

      es: :esth,
      est: :esth,
      esth: :esth,
      esther: :esth,

      jo: :job,
      job: :job,

      ps: :ps,
      psa: :ps,
      psal: :ps,
      psalm: :ps,
      psalms: :ps,

      pr: :prov,
      pro: :prov,
      prov: :prov,
      proverbs: :prov,

      ec: :eccl,
      ecc: :eccl,
      eccl: :eccl,
      eccles: :eccl,
      ecclesiastes: :eccl,

      so: :song,
      'song of solomon'.to_sym => :song,
      'song of songs'.to_sym => :song,
      'song of sol'.to_sym => :song,
      ss: :song,
      ssong: :song,

      is: :isa,
      isa: :isa,
      isaiah: :isa,

      je: :jer,
      jer: :jer,
      jere: :jer,
      jerem: :jer,
      jeremiah: :jer,

      la: :lam,
      lam: :lam,
      lamen: :lam,
      lament: :lam,
      lamentations: :lam,

      eze: :ezek,
      ezek: :ezek,
      ezekiel: :ezek,

      da: :dan,
      dan: :dan,
      daniel: :dan,

      ho: :hos,
      hos: :hos,
      hosea: :hos,

      joe: :joel,
      joel: :joel,

      am: :amos,
      amos: :amos,

      ob: :obad,
      oba: :obad,
      obad: :obad,
      obadiah: :obad,

      jon: :jonah,
      jona: :jonah,
      jonah: :jonah,

      mi: :mic,
      mic: :mic,
      micah: :mic,

      na: :nah,
      nah: :nah,
      nahum: :nah,

      hab: :hab,
      habak: :hab,
      habakkuk: :hab,

      zep: :zeph,
      zeph: :zeph,
      zephaniah: :zeph,

      hag: :hag,
      hagg: :hag,
      haggai: :hag,

      zec: :zech,
      zech: :zech,
      zechariah: :zech,

      mal: :mal,
      malac: :mal,
      malach: :mal,
      malachi: :mal,

      mat: :matt,
      matt: :matt,
      matth: :matt,
      matthew: :matt,
      mt: :matt,

      mar: :mark,
      mark: :mark,
      mr: :mark,
      mrk: :mark,

      lk: :luke,
      lke: :luke,
      lu: :luke,
      luk: :luke,
      luke: :luke,

      jhn: :john,
      jn: :john,
      joh: :john,
      john: :john,

      ac: :acts,
      act: :acts,
      acts: :acts,

      ro: :rom,
      rom: :rom,
      roman: :rom,
      romans: :rom,

      '1 co'.to_sym => '1cor'.to_sym,
      '1 cor'.to_sym => '1cor'.to_sym,
      '1 corin'.to_sym => '1cor'.to_sym,
      '1 corinth'.to_sym => '1cor'.to_sym,
      '1 corinthians'.to_sym => '1cor'.to_sym,

      '2 co'.to_sym => '2cor'.to_sym,
      '2 cor'.to_sym => '2cor'.to_sym,
      '2 corin'.to_sym => '2cor'.to_sym,
      '2 corinth'.to_sym => '2cor'.to_sym,
      '2 corinthians'.to_sym => '2cor'.to_sym,

      ga: :gal,
      gal: :gal,
      galat: :gal,
      galatians: :gal,

      ep: :eph,
      eph: :eph,
      ephes: :eph,
      ephesians: :eph,

      ph: :phil,
      phi: :phil,
      phil: :phil,
      phili: :phil,
      philip: :phil,
      philipp: :phil,
      philippians: :phil,
      php: :phil,

      co: :col,
      col: :col,
      colo: :col,
      colos: :col,
      coloss: :col,
      colossians: :col,

      '1 ti'.to_sym => '1tim'.to_sym,
      '1 tim'.to_sym => '1tim'.to_sym,
      '1 timothy'.to_sym => '1tim'.to_sym,

      '1 th'.to_sym => '1thess'.to_sym,
      '1 the'.to_sym => '1thess'.to_sym,
      '1 thes'.to_sym => '1thess'.to_sym,
      '1 thess'.to_sym => '1thess'.to_sym,
      '1 thessalonians'.to_sym => '1thess'.to_sym,

      '2 th'.to_sym => '2thess'.to_sym,
      '2 the'.to_sym => '2thess'.to_sym,
      '2 thes'.to_sym => '2thess'.to_sym,
      '2 thess'.to_sym => '2thess'.to_sym,
      '2 thessalonians'.to_sym => '2thess'.to_sym,

      '2 ti'.to_sym => '2tim'.to_sym,
      '2 tim'.to_sym => '2tim'.to_sym,
      '2 timothy'.to_sym => '2tim'.to_sym,

      tit: :titus,
      titu: :titus,
      titus: :titus,

      phile: :phlm,
      philem: :phlm,
      philemon: :phlm,
      phlm: :phlm,
      phlmn: :phlm,
      phm: :phlm,
      phmn: :phlm,

      he: :heb,
      heb: :heb,
      hebr: :heb,
      hebrews: :heb,

      ja: :jas,
      jam: :jas,
      james: :jas,
      jas: :jas,

      '1 pe'.to_sym => '1pet'.to_sym,
      '1 pet'.to_sym => '1pet'.to_sym,
      '1 peter'.to_sym => '1pet'.to_sym,

      '2 pe'.to_sym => '2pet'.to_sym,
      '2 pet'.to_sym => '2pet'.to_sym,
      '2 peter'.to_sym => '2pet'.to_sym,

      '1 jn'.to_sym => '1john'.to_sym,
      '1 jo'.to_sym => '1john'.to_sym,
      '1 joh'.to_sym => '1john'.to_sym,
      '1 john'.to_sym => '1john'.to_sym,

      '2 jn'.to_sym => '2john'.to_sym,
      '2 jo'.to_sym => '2john'.to_sym,
      '2 joh'.to_sym => '2john'.to_sym,
      '2 john'.to_sym => '2john'.to_sym,

      '3 jn'.to_sym => '3john'.to_sym,
      '3 jo'.to_sym => '3john'.to_sym,
      '3 joh'.to_sym => '3john'.to_sym,
      '3 john'.to_sym => '3john'.to_sym,

      jude: :jude,

      re: :rev,
      rev: :rev,
      revel: :rev,
      revelation: :rev,
    }

    def keyify(book_name)
      TRANSLATIONS[normalize_input(book_name)] ||
        raise(InvalidReferenceError.new("#{book_name} is not a valid book"))
    end

    private
    def normalize_input(book_name)
      book_name.strip.downcase.gsub(/\s+/, ' ').to_sym
    end

  end

end
