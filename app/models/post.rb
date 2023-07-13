class Post < ApplicationRecord
  validates :title, presence: true,
            length: { minimum: 3, maximum: 20 }
  validates :content, presence: true,
            length: { minimum: 3, maximum: 20 }
end
