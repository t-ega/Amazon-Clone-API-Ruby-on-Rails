class Author < ApplicationRecord
  has_many :books
  validates :first_name, presence: true, length: {minimum: 2, maximum: 30}
  validates :last_name, presence: true, length: {minimum: 2, maximum: 30}

  def full_name = "#{self.first_name} #{self.last_name}"
end
