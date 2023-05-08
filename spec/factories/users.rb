FactoryBot.define do
  factory :user do
    fname {Faker::Name.first_name}
    lname { Faker::Name.last_name }
    age {Faker::Number.between(from: 18, to: 65)}
    location {Faker::Address.city}
    email {Faker::Internet.email}
    password {Faker::Internet.password(min_length: 8, max_length: 12)}
    role {create :role}
  end
end