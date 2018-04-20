FactoryBot.define do
  factory :user do
    name { Faker::RickAndMorty.character }
    email { Faker::Internet.email }
    password Faker::Internet.password(10, 20)
  end
end
