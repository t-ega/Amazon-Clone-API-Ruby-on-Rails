class User < ApplicationRecord
  validates :password, presence: true, length: {minimum: 6}
  validates :email, format: {with: URI::MailTo::EMAIL_REGEXP}, presence: true, uniqueness: true
  normalizes :email, :name, with: -> attribute {attribute.strip.downcase}
end
