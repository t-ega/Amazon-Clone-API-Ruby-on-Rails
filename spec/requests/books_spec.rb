require "rails_helper"

describe "Books API", type: :request do
  endpoint = "/api/v1/books"

  describe "GET /books" do

    let!(:author) { FactoryBot.create(:author, first_name: "Test", last_name: "Author", age: 1) }

    it "should return all books" do
      FactoryBot.create(:book, author: author, title: "Book 1")
      FactoryBot.create(:book, author: author, title: "Book 2")

      get endpoint
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).size).to eq(2)

      expect(JSON.parse(response.body)).to(eq([
         {
           "id"=> 1,
           "title"=>  "Book 1",
           "author"=>  {
             "id"=>  1,
             "first_name"=>  "Test",
             "last_name"=>  "Author",
             "age"=>  1,
             "full_name"=>  "Test Author"
           }
         }, {
         "id"=> 2,
         "title"=>  "Book 2",
         "author"=>  {
           "id"=>  1,
           "first_name"=>  "Test",
           "last_name"=>  "Author",
           "age"=>  1,
           "full_name"=>  "Test Author"
         }
       }
      ]))
    end

  end

  describe "POST /books" do

    let!(:author) { FactoryBot.create(:author, first_name: "Test", last_name: "Author", age: 1) }

    it "should create a new book" do
      expect {
        post endpoint, params: {book: {author_id: author.id, title: "My title"}};
      }.to change {Book.count}.from(0).to(1)

      expect(response).to have_http_status(:created)
      puts JSON.parse(response.body)
      expect(JSON.parse(response.body)).to(eq(
          {
            "id"=> 1,
            "title"=>  "My title",
            "author"=>  {
              "id"=>  1,
              "first_name"=>  "Test",
              "last_name"=>  "Author",
              "age"=>  1,
              "full_name"=>  "Test Author"
            }
          }))
    end

  end

  describe "DELETE /book " do

    let!(:author) { FactoryBot.create(:author, first_name: "Test", last_name: "Author", age: 1) }
    let!(:book) { FactoryBot.create(:book, author: author, title: "You") }

    it "should delete a book successfully" do

      expect {
        delete "#{endpoint}/#{book.id}"
      }.to change {Book.count}.from(1).to(0)

      expect(response).to have_http_status(:no_content)

    end
  end

end