FactoryBot.define do
  factory :project do
    name { Faker::RickAndMorty.location }
    description { Faker::RickAndMorty.quote }
  end
end
