require 'rails_helper'


RSpec.describe "Author", type: :request do

  describe "POST /author" do
    let!(:user) {
      FactoryBot.create(:user, name:  "Name", phone: "123456",
                        email: "email@example.com", password: "password", password_confirmation: "password")
    }

    it "should create the author" do
      author_params = {
        "author": {
          "first_name": "Firstname",
          "last_name": "Lastname",
          "about": "About",
          "user_id": user.id,
          "age": 30
        }
      }

      expect {
        post "/api/v1/authors/", params: author_params
      }.to change{ Author.count }.from(0).to(1)

      expect(response).to have_http_status(:created)
      expect(response.body).to include("author")

    end

    describe "Throws errors" do

      it "should return an error if the params are invalid" do
        author_params = {
          "author": {
          }
        }

        expect {
          post "/api/v1/authors/", params: author_params
        }.not_to change { Author.count }.from(0)

        expect(response).to have_http_status(:bad_request)
        expect(response.body).to include("error")
      end

      it "should return an error an author with the same user_id already exists" do
        FactoryBot.create(:author, first_name: "first",
                          last_name: "last_name", about:"about", user: user, age: 10)

        author_params = {
          "author": {
            "first_name": "Firstname",
            "last_name": "Lastname",
            "about": "About",
            "user_id": user.id,
            "age": 30
          }
        }

        expect {
          post "/api/v1/authors/", params: author_params
        }.to_not change {Author.count }.from(1)

        expect(response).to have_http_status(:bad_request)
        expect(response.body).to include("An author with this user_id already exists")
      end

    end

  end

  describe "GET /author" do
    it "should get all authors "

  end
end