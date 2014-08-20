require_relative '../spec_helper'

describe BiblePassage::InvalidReference do

  let(:reference) { BiblePassage::InvalidReference.new("An error") }

  it "is a Reference" do
    expect(reference.is_a?(BiblePassage::Reference)).to eq(true)
  end

  it "is invalid" do
    expect(reference.valid?).to eq(false)
  end

  it "returns the supplied message" do
    expect(reference.error).to eq("An error")
  end

end
