class User < ApplicationRecord
  belongs_to :role

  validates :fname, presence: true, length: { minimum: 3, maximum: 50 }
  validates :lname, presence: true, length: { minimum: 3, maximum: 50 }
  validates :age, presence: false,
            numericality: { only_integer: true, greater_than_or_equal_to: 18 },
            allow_blank: true
  validates :location, presence: false, length: { minimum: 3 }, allow_blank: true
  validates :email, presence: false,
            format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i },
            allow_blank: true
  validates :password, presence: false, length: { minimum: 8 }, allow_blank: true
end
