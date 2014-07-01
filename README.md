bible-passage
=============

A simple library for parsing and rendering bible passages.


# Usage

The most common usage of bible-passage will be to parse a reference string, which will return a new <code>BiblePassage::Reference</code> object

    ref = BiblePassage::Reference.parse "gen 1:2-3"
  
This <code>BiblePassage::Reference</code> object can be output as a string

	> ref.to_s
	=> "Genesis 1:2-3"
	
bible-passage can handle common book name abbreviations, and will also simplify references where appropriate, eg.

	> BiblePassage::Reference.parse("Genesis 1:1-50:26").to_s
    => "Genesis"
    
It will check the validity of references and throw a <code>BiblePassage::InvalidReferenceError</code> if a reference is not valid

	> BiblePassage::Reference.parse("mt 3-1")
	BiblePassage::InvalidReferenceError: to_chapter cannot be before from_chapter
	
	> BiblePassage::Reference.parse("Exudos")
	BiblePassage::InvalidReferenceError: Exudos is not a valid book
	
	> BiblePassage::Reference.parse("Ex 41")
	BiblePassage::InvalidReferenceError: Exodus doesn't have a chapter 41
	
# License
bible-passage is distributed under the [MIT License](http://www.opensource.org/licenses/MIT).