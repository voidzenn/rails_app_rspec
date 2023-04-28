class Role < ApplicationRecord
  has_one :user

  validates :name, presence: true, length: { minimum: 4, maximum: 30 }
end
