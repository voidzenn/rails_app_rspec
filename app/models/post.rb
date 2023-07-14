class Post < ApplicationRecord
  belongs_to :user, foreign_key: :user_id

  validates :title, presence: true,
            length: { minimum: 3, maximum: 20 }
  validates :content, presence: true,
            length: { minimum: 3, maximum: 50 }
end
