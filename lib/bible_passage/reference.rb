module BiblePassage

  class Reference

    class << self

      def parse(passage, options = {})
        translator = options.delete(:translator) || BookKeyTranslator.new
        data_store = options[:data_store] ||= BookDataStore.new
        match = passage.match(/^\s*(\d?\s*[A-Za-z\s]+)\s*(\d+)?:?(\d+)?-?(\d+)?:?(\d+)?/)
        book_key = translator.keyify(match[1])
        if data_store.number_of_chapters(book_key) == 1
          process_single_chapter_match(book_key, match, options)
        else
          process_multi_chapter_match(book_key, match, options)
        end
      end


      private
      def process_multi_chapter_match(book_key, match, options)
        if match[2]
          from_chapter = match[2].to_i 
          # has from verse
          if match[3]
            from_verse = match[3].to_i
            if match[5]
              to_chapter = match[4].to_i
              to_verse = match[5].to_i
            else
              to_verse = match[4].to_i if match[4]
            end
          else
            from_verse = match[3].to_i if match[3]
            to_chapter = match[4].to_i if match[4]
          end
        end
        new(book_key, from_chapter, from_verse, to_chapter, to_verse, options)
      end

      def process_single_chapter_match(book_key, match, options)
        if match[2]
          from_verse = match[2].to_i
          to_verse = match[4].to_i if match[4]
        end
        if match[0] =~ /:/
          book_name = options[:data_store].book_name(book_key)
          msg = "#{book_name} doesn't have any chapters"
          raise InvalidReferenceError.new(msg)
        end
        new(book_key, nil, from_verse, nil, to_verse, options)
      end

    end

    attr_reader :book_key, :book

    def initialize(book_key, from_chapter = nil, from_verse = nil, 
                   to_chapter = nil, to_verse = nil, options = {})
      @data_store = options[:data_store] || BookDataStore.new
      self.book_key = book_key
      self.from_chapter = int_param(from_chapter)
      self.from_verse = int_param(from_verse)
      self.to_chapter = calculate_to_chapter(to_chapter)
      self.to_verse = calculate_to_verse(to_verse)
    end

    def book_key=(key)
      @book = @data_store.book_name(key)
      @book_key = key
    end

    def from_chapter
      @from_chapter || 1
    end

    def from_chapter=(val)
      if val
        raise InvalidReferenceError.new(
          "#{book} doesn't have a chapter #{val}") if val < 1 || 
          val > @data_store.number_of_chapters(book_key)
        @from_chapter = val
      end
    end

    def from_verse
      @from_verse || 1
    end

    def from_verse=(val)
      if val
        raise InvalidReferenceError.new(
          "#{book} #{from_chapter} doesn't have a verse #{val}") if val < 1 ||
          val > @data_store.number_of_verses(book_key, from_chapter)
        @from_verse = val
      end
    end

    def to_chapter
      @to_chapter || from_chapter
    end

    def to_chapter=(val)
      if val
        raise InvalidReferenceError.new(
          "to_chapter cannot be before from_chapter") if val < from_chapter
        raise InvalidReferenceError.new(
          "#{book} doesn't have a chapter #{val}") if val > 
          @data_store.number_of_chapters(book_key)
        @to_chapter = val
      end
    end

    def to_verse
      @to_verse || from_verse
    end

    def to_verse=(val)
      if val
        raise InvalidReferenceError.new(
          "to_verse cannot be before from_verse") if val < from_verse && 
          single_chapter_passage?
        raise InvalidReferenceError.new(
          "#{book} #{to_chapter} doesn't have a verse #{val}") if val > 
          @data_store.number_of_verses(book_key, to_chapter)
        @to_verse = val
      end
    end

    def to_s
      if single_chapter_book?
        "#{book}#{from_verse_part}#{to_verse_part}"
      else
        "#{book}#{from_part}#{to_part}"
      end
    end

    def whole_chapters?
      from_verse == 1 && to_verse_last_in_chapter?
    end

    def whole_book?
      from_chapter == 1 && from_verse == 1 && 
        to_chapter == @data_store.number_of_chapters(book_key) &&
        to_verse == @data_store.number_of_verses(book_key, to_chapter)
    end

    def whole_chapter?
      whole_chapters? && from_chapter == to_chapter
    end

    private
    def from_part
      out = ''
      unless whole_book?
        out << ' '
        out << from_chapter.to_s
        out << from_verse_part
      end
      out
    end

    def from_verse_part
      if whole_chapters?
        ''
      else
        out = single_chapter_book? ? ' ' : ':'
        "#{out}#{from_verse.to_s}"
      end
    end

    def to_part
      out = ''
      unless whole_book? || single_verse_passage? || whole_chapter?
        out << '-'
        unless single_chapter_passage?
          out << to_chapter_part 
        end
        out << to_verse_part
      end
      out
    end

    def to_chapter_part
      if single_chapter_passage?
        ''
      else
        to_chapter.to_s
      end
    end

    def to_verse_part
      if single_verse_passage? || whole_chapters?
        ''
      else
        out = ''
        out << '-' if single_chapter_book?
        out << ':' unless single_chapter_passage?
        out << to_verse.to_s
        out
      end
    end


    def int_param(param)
      param ? param.to_i : nil
    end

    def single_chapter_passage?
      from_chapter == to_chapter
    end

    def single_verse_passage?
      single_chapter_passage? && from_verse == to_verse
    end

    def single_chapter_book?
      @data_store.number_of_chapters(book_key) == 1
    end
    
    def to_verse_last_in_chapter?
      to_verse == @data_store.number_of_verses(book_key, to_chapter)
    end

    def calculate_to_chapter(supplied_to_chapter)
      int_param(supplied_to_chapter) || begin
        if @from_chapter
          @from_chapter
        else
          @data_store.number_of_chapters(book_key)
        end
      end
    end

    def calculate_to_verse(supplied_to_verse)
      int_param(supplied_to_verse) || 
        @from_verse ||
          @data_store.number_of_verses(book_key, self.to_chapter)
    end

  end

end
