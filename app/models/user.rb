class User < ApplicationRecord
  CONFIRMATION_TOKEN_EXPIRATION = 10.minutes
  has_secure_password

  validates :password, presence: true, confirmation: true, length: {minimum: 6}
  validates :password_confirmation, presence: true
  validates :name, presence: true
  validates :email, format: {with: URI::MailTo::EMAIL_REGEXP}, presence: true, uniqueness: true
  normalizes :email, :name, with: -> attribute {attribute.strip.downcase}

  def confirm!
    update_columns(confirmed_at: Time.current)
  end

  def send_confirmation_email!
    confirmation_token = generate_confirmation_token
    UserMailer.confirmation(self, confirmation_token).deliver_now
  end

  def confirmed?
    confirmed_at.present?
  end

  def generate_confirmation_token
    signed_id expires_in: CONFIRMATION_TOKEN_EXPIRATION, purpose: :confirm_email
  end

  def unconfirmed?
    !confirmed?
  end
end
