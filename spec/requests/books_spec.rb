require "rails_helper"

describe "Books API", type: :request do
  endpoint = "/api/v1/books"

  describe :get_books do

    FactoryBot.create(:book, author: "1", title: "You")
    FactoryBot.create(:book, author: "Terader", title: "Him")

    it "should return all books" do
      get endpoint
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).size).to eq(2)
    end

  end

  describe "POST /books" do

    it "should create a new book" do
      expect {
        post endpoint, params: {book: {author: "A test author", title: "My title"}};
      }.to change {Book.count}.from(0).to(1)

      expect(response).to have_http_status(:created)
    end

  end

  describe "DELETE /book " do
    book = FactoryBot.create(:book, author: "Tega", title: "You")

    it "should delete a book successfully" do
    #   Create a book using Factory_bot first

    expect {
      delete "#{endpoint}/#{book.id}"
    }.to change {Book.count}.from(1).to(0)

    expect(response).to have_http_status(:no_content)

    end
  end

end