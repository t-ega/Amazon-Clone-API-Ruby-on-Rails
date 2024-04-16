require 'rails_helper'

RSpec.describe Author, type: :model do

  it "should be valid with valid attributes" do
    expect(Author.new(first_name: "test", last_name: "tester")).to be_valid
  end

  it "should be invalid without a first_name attribute" do
    expect(Author.new(last_name: "tester")).to_not be_valid
  end

  it "should be invalid without a last_name attribute" do
    expect(Author.new(first_name: "test")).to_not be_valid
  end
end
