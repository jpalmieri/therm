FactoryBot.define do
  factory :user do
    name { Faker::RickAndMorty.character }
    email { Faker::Internet.email }
    email { Faker::Internet.password(10, 20) }
  end
end
