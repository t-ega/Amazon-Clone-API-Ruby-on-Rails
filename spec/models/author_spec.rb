require 'rails_helper'

RSpec.describe Author, type: :model do

  let(:user) { FactoryBot.create(:user, email: "test@test.com", password: "password", password_confirmation: "password") }

  it "should be valid with valid attributes" do

    expect(Author.new(first_name: "test", user: user, age: 1, last_name: "tester")).to be_valid
  end

  it "should be invalid without a first_name attribute" do
    expect(Author.new(last_name: "tester")).to_not be_valid
  end

  it "should be invalid without a last_name attribute" do
    expect(Author.new(first_name: "test")).to_not be_valid
  end
end
