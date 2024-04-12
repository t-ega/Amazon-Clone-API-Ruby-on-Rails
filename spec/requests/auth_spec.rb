require 'rails_helper'

RSpec.describe "Auths", type: :request do
  describe "POST /create" do

    # The confirmation method returns a mail object which
    # has methods such as deliver_now, deliver_later e.t.c
    # a call to deliver_now should do nothing
    let(:mailer) {double({deliver_now: nil})}

    before do
      # Prevent an actual confirmation message from being sent
      allow(UserMailer).to receive(:confirmation).and_return(mailer)
    end

    it "should create a user successfully" do

      user_data = {
          "user": {
            "name": "John doe",
            "email": "johndoe@example.com",
            "phone": "1234567890",
            "password": "secretpassword",
            "password_confirmation": "secretpassword"
          }
      }

      expect {
        post "/api/v1/auth/signup", params: user_data
      }.to change{User.count}.from(0).to(1)

      expect(response).to have_http_status(:created)

      expect(User.find_by(email: "johndoe@example.com").confirmed?).to be(false)
      expect(UserMailer).to have_received(:confirmation)
      expect(response.body).to include("Check email for confirmation")

    end

    it "should return an error for incomplete user data" do
      user_data = {
        "user": {
        }
      }

      expect {
        post "/api/v1/auth/signup", params: user_data
      }.not_to change{User.count}.from(0)

      expect(response).to have_http_status(:bad_request)
      expect(response.body).to include("error")
    end
  end
end
