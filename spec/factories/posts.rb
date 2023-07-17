FactoryBot.define do
  factory :post do
    title {Faker::Lorem.characters number: 20}
    content {Faker::Lorem.characters number: 50}
    user {create :user}
  end
end