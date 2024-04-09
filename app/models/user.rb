class User < ApplicationRecord
  CONFIRMATION_TOKEN_EXPIRATION = 10.minutes

  validates :password, presence: true, length: {minimum: 6}
  validates :email, format: {with: URI::MailTo::EMAIL_REGEXP}, presence: true, uniqueness: true
  normalizes :email, :name, with: -> attribute {attribute.strip.downcase}

  def confirm!
    update_columns(confirmed_at: Time.current)
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
