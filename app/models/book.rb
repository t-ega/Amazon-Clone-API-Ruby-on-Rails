class Book < ApplicationRecord
  validates :title, presence: true, length: {:minimum => 3}
  validates :author_id, presence: true
  validates :price, presence: true,  numericality: { only_integer: true, greater_than_or_equal_to: 1,
                                                     less_than_or_equal_to: 999 }
  belongs_to :author
end
