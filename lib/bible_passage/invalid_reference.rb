class BiblePassage::InvalidReference < BiblePassage::Reference

  attr_reader :error

  def initialize(message)
    @error = message
  end

  def valid?
    false
  end

end
