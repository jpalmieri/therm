FactoryBot.define do
  factory :temps do
    value { rand(0.00001..999.999).round(3) }
  end
end
