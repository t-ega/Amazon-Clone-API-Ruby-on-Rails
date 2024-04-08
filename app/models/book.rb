class Book < ApplicationRecord
  validates :title, presence: true, length: {:minimum => 3}
  validates :author_id, presence: true
  belongs_to :author
end
