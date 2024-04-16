class Author < ApplicationRecord
  has_many :books, dependent: :destroy
  belongs_to :user
  validates :user, presence:true,  uniqueness: { message: "An author with this user_id already exists" }
  validates :first_name, presence: true, length: { minimum: 2, maximum: 30}
  validates :last_name, presence: true, length: { minimum: 2, maximum: 30}
  validates :age, presence: false, numericality: { only_integer: true, greater_than_or_equal_to: 1,
                                                  less_than_or_equal_to: 999 }

  def full_name = "#{self.first_name} #{self.last_name}"
end
