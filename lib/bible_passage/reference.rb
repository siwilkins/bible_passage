module BiblePassage

  class Reference

    attr_reader :error

    class << self

      # Parsing methods are currently very complex and long.
      # Could need some work
      
      ##
      # The main method used for parsing passage strings
      def parse(passage, options = {})
        options = {raise_errors: true}.merge(options)
        translator = options.delete(:translator) || BookKeyTranslator.new
        data_store = options[:data_store] ||= BookDataStore.new
        match = match_passage_format(passage)
        if !match
          message = "#{passage} is not a valid reference"
          if options[:raise_errors]
            raise InvalidReferenceError.new(message)
          else
            return InvalidReference.new(message)
          end
        end
        book_key = translator.keyify(match[1], options[:raise_errors]) || (return InvalidReference.new("#{match[1]} is not a valid book"))
        if data_store.number_of_chapters(book_key) == 1
          ref = process_single_chapter_match(book_key, match, options)
        else
          ref = process_multi_chapter_match(book_key, match, options)
        end
        ref.parse_child(match[6].gsub(/^,\s*/, '')) if match[6]
        ref
      end

      ##
      # Parses a child reference in a compound passage string
      def parse_child(passage, parent, options = {})
        if match_passage_format(passage)
          ref = parse(passage, options)
        else
          match = passage.match(/\s*(\d+)?:?(\d+)?\s*(-?)\s*(\d+)?:?(\d+)?\s*(,.+)?$/)
          book_key = parent.book_key
          attrs = parent.inheritable_attributes
          if attrs[:from_chapter]
            if match[2]
              attrs[:from_chapter] = match[1].to_i 
              attrs[:from_verse] = match[2].to_i
            else
              attrs[:from_verse] = match[1].to_i
            end
          else
            attrs[:from_chapter] = match[1].to_i
            if match[2]
              attrs[:from_verse] = match[2].to_i
            else
            end
          end
          if match[5]
            attrs[:to_chapter] = int_param(match[4])
            attrs[:to_verse] = int_param(match[5])
          elsif attrs[:from_verse]
            attrs[:to_verse] = int_param(match[4]) 
          else
            attrs[:to_chapter] = int_param(match[4])
          end
          ref = new(book_key, attrs[:from_chapter], attrs[:from_verse], 
              attrs[:to_chapter], attrs[:to_verse])
        end
        ref.parent = parent
        ref
      end

      private

      def match_passage_format(passage)
        passage.match(/^\s*(\d?\s*[A-Za-z\s]+)\s*(\d+)?:?(\d+)?\s*-?\s*(\d+)?:?(\d+)?\s*(,.+)?/)
      end

      def int_param(param)
        param ? param.to_i : nil
      end

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
              to_verse = int_param(match[4])
            end
          else
            from_verse = int_param(match[3])
            to_chapter = int_param(match[4])
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
          if options[:raise_errors]
            raise InvalidReferenceError.new(msg)
          else
            return InvalidReference.new(msg)
          end
        end
        new(book_key, nil, from_verse, nil, to_verse, options)
      end

    end

    attr_reader :book_key, :book, :child

    attr_writer :parent

    def initialize(book_key, from_chapter = nil, from_verse = nil, 
                   to_chapter = nil, to_verse = nil, options = {})
      @raise_errors = options.has_key?(:raise_errors) ? options[:raise_errors] : true
      @data_store = options[:data_store] || BookDataStore.new
      self.book_key = book_key
      self.from_chapter = int_param(from_chapter)
      self.from_verse = int_param(from_verse)
      self.to_chapter = calculate_to_chapter(to_chapter)
      self.to_verse = calculate_to_verse(to_verse)
    end

    def parse_child(child_passage)
      @child = self.class::parse_child(child_passage, self)
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
        if val < 1 || val > @data_store.number_of_chapters(book_key)
          @error = "#{book} doesn't have a chapter #{val}"
          raise InvalidReferenceError.new(@error) if @raise_errors
        end
        @inherit_book_key = true
        @from_chapter = val
      end
    end

    def from_verse
      @from_verse || 1
    end

    def from_verse=(val)
      if val && valid?
        if val > @data_store.number_of_verses(book_key, from_chapter) || val < 1
          @error = "#{book} #{from_chapter} doesn't have a verse #{val}"
          raise InvalidReferenceError.new(@error) if @raise_errors
        end
        @inherit_chapter = true
        @from_verse = val
      end
    end

    def to_chapter
      @to_chapter || from_chapter
    end

    def to_chapter=(val)
      if val
        if val < from_chapter
          @error = "to_chapter cannot be before from_chapter"
          raise InvalidReferenceError.new(@error) if @raise_errors
        end
        if val > @data_store.number_of_chapters(book_key)
          @error = "#{book} doesn't have a chapter #{val}"
          raise InvalidReferenceError.new(@error) if @raise_errors
        end
        @to_chapter = val
      end
    end

    def to_verse
      @to_verse || from_verse
    end

    def to_verse=(val)
      if val && valid?
        if val < from_verse && single_chapter_passage?
          @error = "to_verse cannot be before from_verse"
          raise InvalidReferenceError.new(@error) if @raise_errors
        end
        if val > @data_store.number_of_verses(book_key, to_chapter)
          @error = "#{book} #{to_chapter} doesn't have a verse #{val}"
          raise InvalidReferenceError.new(@error) if @raise_errors
        end
        @to_verse = val
      end
    end

    def to_s
      return nil if !valid?
      if @parent
        out = to_s_child
      else
        out = to_s_root
      end
      out << child.to_s if child
      out
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

    def attributes
      %w{book_key from_chapter from_verse to_chapter to_verse}.
        inject({}) do |memo, attr_key|
          memo.merge(attr_key.to_sym => send(attr_key))
      end
    end
    
    def ==(other)
      attributes == other.attributes
    end

    def inheritable_attributes
      out = {}
      out[:book_key] = book_key if @inherit_book_key
      out[:from_chapter] = to_chapter if @inherit_chapter
      out
    end

    def valid?
      @error.nil?
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

    def to_s_root
      if single_chapter_book?
        out = "#{book}#{from_verse_part}#{to_verse_part}"
      else
        out = "#{book}#{from_part}#{to_part}"
      end
    end

    def to_s_child
      out = ','
      if book_key != @parent.book_key
        out << " #{to_s_root}"
      else
        out << "#{from_part}#{to_part}"
      end
    end

  end

end
