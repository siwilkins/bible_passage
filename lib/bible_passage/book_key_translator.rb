module BiblePassage

  class BookKeyTranslator

    TRANSLATIONS = {
      gen: [:ge, :gen, :gene, :genes, :genesis, :gn],
      exod: [:ex, :exo, :exod, :exodus],
      lev: [:le, :lev, :levit, :leviticus],
      num: [:nm, :nu, :num, :numb, :numbers],
      deut: [:de, :deu, :deut, :deuter, :deuteronomy, :dt],
      josh: [:jos, :josh, :joshua],
      judg: [:jd, :jdg, :judg, :judges],
      ruth: [:ruth],
      :"1sam" => [:"1 sa", :"1 sam", :"1 samuel"],
      :"2sam" => [:"2 sa", :"2 sam", :"2 samuel"],
      :"1kings" => [:"1 kgs", :"1 ki", :"1 king", :"1 kings", :"1 kngs"],
      :"2kings" => [:"2 kgs", :"2 ki", :"2 king", :"2 kings", :"2 kngs"],
      :"1chr" => [:"1 ch", :"1 chr", :"1 chro", :"1 chron", :"1 chronicles"],
      :"2chr" => [:"2 ch", :"2 chr", :"2 chro", :"2 chron", :"2 chronicles"],
      ezra: [:ezr, :ezra],
      neh: [:ne, :neh, :nehem, :nehemiah],
      esth: [:es, :est, :esth, :esther],
      job: [:jo, :job],
      ps: [:ps, :psa, :psal, :psalm, :psalms],
      prov: [:pr, :pro, :prov, :proverbs],
      eccl: [:ec, :ecc, :eccl, :eccles, :ecclesiastes],
      song: [:so, :"song of solomon", :"song of songs", :"song of sol", :ss, :ssong],
      isa: [:is, :isa, :isaiah],
      jer: [:je, :jer, :jere, :jerem, :jeremiah],
      lam: [:la, :lam, :lamen, :lament, :lamentations],
      ezek: [:eze, :ezek, :ezekiel],
      dan: [:da, :dan, :daniel],
      hos: [:ho, :hos, :hosea],
      joel: [:joe, :joel],
      amos: [:am, :amos],
      obad: [:ob, :oba, :obad, :obadiah],
      jonah: [:jon, :jona, :jonah],
      mic: [:mi, :mic, :micah],
      nah: [:na, :nah, :nahum],
      hab: [:hab, :habak, :habakkuk],
      zeph: [:zep, :zeph, :zephaniah],
      hag: [:hag, :hagg, :haggai],
      zech: [:zec, :zech, :zechariah],
      mal: [:mal, :malac, :malach, :malachi],
      matt: [:mat, :matt, :matth, :matthew, :mt],
      mark: [:mar, :mark, :mr, :mrk],
      luke: [:lk, :lke, :lu, :luk, :luke],
      john: [:jhn, :jn, :joh, :john],
      acts: [:ac, :act, :acts],
      rom: [:ro, :rom, :roman, :romans],
      :"1cor" => [:"1 co", :"1 cor", :"1 corin", :"1 corinth", :"1 corinthians"],
      :"2cor" => [:"2 co", :"2 cor", :"2 corin", :"2 corinth", :"2 corinthians"],
      gal: [:ga, :gal, :galat, :galatians],
      eph: [:ep, :eph, :ephes, :ephesians],
      phil: [:ph, :phi, :phil, :phili, :philip, :philipp, :philippians, :php],
      col: [:co, :col, :colo, :colos, :coloss, :colossians],
      :"1tim" => [:"1 ti", :"1 tim", :"1 timothy"],
      :"2tim" => [:"2 ti", :"2 tim", :"2 timothy"],
      :"1thess" => [:"1 th", :"1 the", :"1 thes", :"1 thess", :"1 thessalonians"],
      :"2thess" => [:"2 th", :"2 the", :"2 thes", :"2 thess", :"2 thessalonians"],
      titus: [:tit, :titu, :titus],
      phlm: [:phile, :philem, :philemon, :phlm, :phlmn, :phm, :phmn],
      heb: [:he, :heb, :hebr, :hebrews],
      jas: [:ja, :jam, :james, :jas],
      :"1pet" => [:"1 pe", :"1 pet", :"1 peter"],
      :"2pet" => [:"2 pe", :"2 pet", :"2 peter"],
      :"1john" => [:"1 jn", :"1 jo", :"1 joh", :"1 john"],
      :"2john" => [:"2 jn", :"2 jo", :"2 joh", :"2 john"],
      :"3john" => [:"3 jn", :"3 jo", :"3 joh", :"3 john"],
      jude: [:jude],
      rev: [:re, :rev, :revel, :revelation]
    }

    def keyify(book_name, raise_errors = true)
      translation = BookKeyTranslator.translations[normalize_input(book_name)]
      if translation
        return translation
      elsif raise_errors
        raise(InvalidReferenceError.new("#{book_name} is not a valid book"))
      end
    end

    private
    def normalize_input(book_name)
      book_name.strip.downcase.gsub(/\s+/, ' ').to_sym
    end

    def self.translations
      @@translations ||= Hash[
        TRANSLATIONS.flat_map do |book, abbrevs|
          abbrevs.map do |abbrev|
            [abbrev, book]
          end
        end
      ]
    end
  end
end
