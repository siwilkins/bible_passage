module BiblePassage

  class Reference

    attr_reader :book_key, :from_chapter, :from_verse, :to_chapter

    def initialize(passage, options = {})
      @translator = options[:translator] || BookKeyTranslator.new
      @data_store = options[:data_store] || BookDataStore.new
      match = passage.match(/^\s*(\d?\s*[A-Za-z\s]+)\s*(\d+)?:?(\d+)?-?(\d+)?:?(\d+)?/)
      set_book_key(match)
      @from_chapter = $2 ? $2.to_i : 1
      # has from verse
      if $3
        @from_verse = $3.to_i
        @to_chapter = $5 ? $4.to_i : @from_chapter
      else
        @from_verse = $3 ? $3.to_i : 1
        @to_chapter = $4 ? $4.to_i : @from_chapter
      end
    end

    def book
      @data_store.book_name(book_key)
    end

    private
    def set_book_key(match)
      @book_key = @translator.keyify(match[1])
    end

  end

end
